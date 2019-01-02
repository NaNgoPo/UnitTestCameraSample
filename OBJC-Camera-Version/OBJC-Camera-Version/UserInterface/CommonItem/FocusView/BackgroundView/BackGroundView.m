//
//  BackGroundView.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 1/2/19.
//  Copyright © 2019 East Agile. All rights reserved.
//

#import "BackGroundView.h"
@interface BackGroundView()
@property(strong,nonatomic) UIImageView *imageViewCenter;
@property(strong,nonatomic) NSString *imageNamedInAsset;
@end

@implementation BackGroundView
const int PADDING_IMAGE = 20;
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    [self setOpaque:false];
    self.imageViewCenter = [[UIImageView alloc] init];
    [self addSubview:self.imageViewCenter];
    self.imageNamedInAsset = @"FocusImageTest";
  }
  return self;
}
- (void)adjustImageView{
  self.imageViewCenter.frame = CGRectMake(PADDING_IMAGE, PADDING_IMAGE, self.frame.size.width - (2 * PADDING_IMAGE), self.frame.size.height - (2 * PADDING_IMAGE));
  self.imageViewCenter.image = [UIImage imageNamed:self.imageNamedInAsset];
}

@end
