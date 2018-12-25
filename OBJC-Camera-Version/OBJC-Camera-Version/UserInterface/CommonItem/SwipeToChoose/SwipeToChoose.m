//
//  SwipeToChoose.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/25/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "SwipeToChoose.h"

@interface SwipeToChoose ()
@property (weak, nonatomic) IBOutlet UICollectionView *collecitonViewMain;
@property (strong, nonatomic) NSMutableArray *listOfInfo;
@property (assign, nonatomic) int leftIndex;
@property (assign, nonatomic) int rightIndex;
@property (assign, nonatomic) int currentSelected;
@end

@implementation SwipeToChoose

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  [self.collecitonViewMain registerNib:[UINib nibWithNibName:@"SwipeCell" bundle:nil]  forCellWithReuseIdentifier:@"SwipeCell"];
  self.listOfInfo = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"",@"",@"Photo",@"Camera",@"",@"",nil]];//fotmat the cell with list: [space][space][photo][camera][space][space]
  self.currentSelected = 0;
  self.leftIndex = 2;
  self.rightIndex = 3;
}
-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self snapToCorrectPossition];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  NSString *valueText = [self.listOfInfo objectAtIndex:indexPath.row];
  SwipeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SwipeCell" forIndexPath:indexPath];
  [cell setupCellLabel:valueText withHightLight:(self.currentSelected == indexPath.row)];
  return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  if((indexPath.row == self.leftIndex) || (indexPath.row == self.rightIndex)){
    [self moveToPossition:(int)indexPath.row];
  }
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.listOfInfo.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  double fixedWidth = self.view.frame.size.width / 3.0;
  double fixedHeight = self.view.frame.size.height;
  return CGSizeMake(fixedWidth, fixedHeight);
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  [self snapToCorrectPossition];
}
-(void)snapToCorrectPossition{
  int snapValue = 0;
  double currentOffset = self.collecitonViewMain.contentOffset.x;
  CGSize size = self.view.frame.size;
  double cellWidth = size.width / 3;
  currentOffset = currentOffset + cellWidth/2;
  currentOffset = currentOffset + cellWidth;
  double maxOffset = cellWidth * self.listOfInfo.count;
  if(currentOffset > (maxOffset / 2.0)){
    snapValue = self.rightIndex;
  }else{
    snapValue = self.leftIndex;
  }
  [self moveToPossition:snapValue];
}
-(void)moveToPossition:(int)withValue{
  self.currentSelected = withValue;
  [self.collecitonViewMain reloadData];
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.collecitonViewMain scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:withValue inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
  });
}
@end
