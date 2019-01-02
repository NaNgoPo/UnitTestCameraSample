//
//  FocusViewWithImage.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 1/2/19.
//  Copyright © 2019 East Agile. All rights reserved.
//

#import "FocusViewWithImage.h"
@interface FocusViewWithImage()
@property(strong,nonatomic) BackGroundView *backgroundImageView;
@property(strong,nonatomic) NSString *imageDisplay;
@end

@implementation FocusViewWithImage
- (void)buildView{
  [super buildView];
  if(self.backgroundImageView == nil){
    self.backgroundImageView = [BackGroundView new];
  }
  [self addSubview:self.backgroundImageView];
}
- (void)adjustSize:(CGRect)newSize{
  [super adjustSize:newSize];
  self.backgroundImageView.frame = newSize;
  [self.backgroundImageView adjustImageView];
}
- (void)setImageWithName:(NSString *)name{
  [self.backgroundImageView setImage:name];
}
@end
