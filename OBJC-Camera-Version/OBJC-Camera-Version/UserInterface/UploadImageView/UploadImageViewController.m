//
//  UploadImageViewController.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "UploadImageViewController.h"

@interface UploadImageViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionUpdate;
@property (strong,nonatomic) UploadingImageController *controller;
@property (strong,nonatomic) PHFetchResult<PHAsset *> *result;
@property (strong,nonatomic) NSMutableArray *selectedList;
@property (weak, nonatomic) IBOutlet UILabel *labelPostItem;
@property (weak, nonatomic) IBOutlet UIView *indicatedView;

@end

@implementation UploadImageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.mainCollectionUpdate registerNib:[UINib nibWithNibName:@"UploadingImageCell" bundle:nil] forCellWithReuseIdentifier:@"UploadingImageCell"];
  self.controller = [UploadingImageController new];
  @weakify(self);
  [self.controller.eventLoadImage subscribeNext:^(id  _Nullable loadImagesEvent) {
    @strongify(self);
    self.result = (PHFetchResult<PHAsset *> *)loadImagesEvent;
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.mainCollectionUpdate reloadData];
    });
  }];
  [self.controller.eventSelected subscribeNext:^(id  _Nullable listOfSelectedItem) {
    @strongify(self);
    self.selectedList = (NSMutableArray *)listOfSelectedItem;
    dispatch_async(dispatch_get_main_queue(), ^(void){
      NSArray<NSIndexPath *> *visibleCells = [self.mainCollectionUpdate indexPathsForVisibleItems];
      [self.mainCollectionUpdate reloadItemsAtIndexPaths:visibleCells];
      [self setTextFotCountLabel];
    });
  }];
  [self setTextFotCountLabel];
}
-(void)setTextFotCountLabel{
  int validSlotCouting = [self.controller getCountValidItem];
  if(validSlotCouting == 0){
    [self.labelPostItem setHidden:true];
    [self.indicatedView setHidden:true];
  }else{
    [self.labelPostItem setHidden:false];
    [self.indicatedView setHidden:false];
    [self.labelPostItem setText:[NSString stringWithFormat:@"Post(%d)",validSlotCouting]];
  }
}
-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self.controller getAllItemInDevicePhotos];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  PHAsset *asset = [self.result objectAtIndex:indexPath.row];
  UploadingImageCell *cell = (UploadingImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UploadingImageCell" forIndexPath:indexPath];
  BOOL isSelected = [self.controller isSelectedItemAt:(int)indexPath.row];
  [cell setupUploadingCell:asset withHighLight:isSelected];
  return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  [self.controller selectAssetAtIndex:(int)indexPath.row andList:self.result];
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.result.count;
}
- (IBAction)buttonCancelDidPressed:(id)sender {
  [self dismissViewControllerAnimated:true completion:^{
    
  }];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  CGSize sizeView = collectionView.frame.size;
  double  newWidth = sizeView.width / 5;
  double newHeight = sizeView.height / 2;
  return CGSizeMake(newWidth, newHeight);
}
@end
