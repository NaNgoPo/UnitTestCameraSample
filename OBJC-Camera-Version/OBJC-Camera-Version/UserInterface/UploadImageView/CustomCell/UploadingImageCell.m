//
//  UploadingImageCell.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "UploadingImageCell.h"
@interface UploadingImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCenter;
@end
@implementation UploadingImageCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}
-(void)setupUploadingCell:(PHAsset *)asset withHighLight:(BOOL)isHighLight{
  @weakify(self);
  [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(50, 50) contentMode:(PHImageContentModeDefault) options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
    @strongify(self);
    dispatch_async(dispatch_get_main_queue(), ^(void){
      [self.imageViewCenter setImage:result];
      if(isHighLight){
        self.backgroundColor = [UIColor redColor];
      }else{
        self.backgroundColor = [UIColor whiteColor];
      }
    });
  }];
}
@end
