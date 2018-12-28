//
//  GalleryChoosenView.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/28/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "GalleryChoosenView.h"

@interface GalleryChoosenView ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMain;
@property (strong, nonatomic) GalleryChoosenController *controller;
@end

@implementation GalleryChoosenView

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.collectionViewMain registerNib:[UINib nibWithNibName:@"GAlleryChoosen" bundle:nil] forCellWithReuseIdentifier:@"GAlleryChoosen"];
  self.controller = [GalleryChoosenController new];
  if(self.eventChoosenGallery == nil){
    self.eventChoosenGallery = [RACSubject new];
  }
  @weakify(self);
  [self.controller.eventLayout subscribeNext:^(id  _Nullable x) {
    @strongify(self);
    [self.collectionViewMain reloadData];
  }];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  GAlleryChoosen *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GAlleryChoosen" forIndexPath:indexPath];
  [cell setupCell:[self.controller.items objectAtIndex:indexPath.row]];
  [cell.eventButton subscribeNext:^(id  _Nullable buttonEvent) {
     [self closeCurrentPopup];
     [self.eventChoosenGallery sendNext:buttonEvent];
  }];
  return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return self.controller.items.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  double fixedWidth = self.view.frame.size.width;
  double fixedHeight = 90;
  return CGSizeMake(fixedWidth, fixedHeight);
}
- (IBAction)buttonCloseDidPressed:(id)sender {
  [self closeCurrentPopup];
}
- (void)closeCurrentPopup{
  [self dismissViewControllerAnimated:true completion:^{
    // do nothing on end....
  }];
}
@end
