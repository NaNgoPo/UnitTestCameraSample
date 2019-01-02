//
//  FocusViewWithLayer.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 1/2/19.
//  Copyright © 2019 East Agile. All rights reserved.
//

#import "FocusViewWithLayer.h"
@interface FocusViewWithLayer()
@property(strong,nonatomic) BorderFocusView *borderFocusView;
@end

@implementation FocusViewWithLayer
- (void)buildView{
  [super buildView];
  if(self.borderFocusView == nil){
    self.borderFocusView = [BorderFocusView new];
  }
  [self addSubview:self.borderFocusView];
}
- (void)adjustSize:(CGRect)newSize{
  [super adjustSize:newSize];
  self.borderFocusView.frame = newSize;
}
@end
