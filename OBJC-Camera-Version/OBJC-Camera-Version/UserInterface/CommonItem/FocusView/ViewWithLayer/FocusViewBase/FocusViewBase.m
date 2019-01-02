//
//  FocusViewBase.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 1/2/19.
//  Copyright © 2019 East Agile. All rights reserved.
//

#import "FocusViewBase.h"
@interface FocusViewBase()
@property(strong,nonatomic) HoleView *holeView;

@end

@implementation FocusViewBase
- (instancetype)init
{
  self = [super init];
  if (self) {
    [self buildView];
  }
  return self;
}
- (void)buildView{
  if(self.holeView == nil){
    self.holeView = [HoleView new];
  }
  [self addSubview:self.holeView];
}
- (void)adjustSize:(CGRect)newSize{
  self.frame = newSize;
  self.holeView.frame = newSize;
}
@end
