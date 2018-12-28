//
//  GAlleryChoosen.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/28/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "GAlleryChoosen.h"
@interface GAlleryChoosen()
@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;
@property (weak, nonatomic) IBOutlet UIImageView *imageHolder;
@property (strong, nonatomic) PHAssetCollection *assetColectionInfo;
@end
@implementation GAlleryChoosen

- (void)awakeFromNib {
  [super awakeFromNib];
  self.eventButton = [RACSubject new];
}
- (void)setupCell:(PHCollection *)album{
  [self.buttonCategory setTitle:album.localizedTitle forState:(UIControlStateNormal)];
  if([album isKindOfClass:[PHAssetCollection class]]){
    PHAssetCollection *collectionPrefetch = (PHAssetCollection *)album;
    self.assetColectionInfo = collectionPrefetch;
    PHAsset *firstAsset = [PHAsset fetchAssetsInAssetCollection:collectionPrefetch options:nil].firstObject;
     @weakify(self);
    if(firstAsset != nil){
      [[PHImageManager defaultManager] requestImageForAsset:firstAsset targetSize:CGSizeMake(590,172) contentMode:(PHImageContentModeDefault) options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        @strongify(self);
        self.imageHolder.image = result;
      }];
    }
  }
}
- (IBAction)buttonSelectAssetDidPressed:(id)sender {
  [self.eventButton sendNext:self.assetColectionInfo];
}
@end
