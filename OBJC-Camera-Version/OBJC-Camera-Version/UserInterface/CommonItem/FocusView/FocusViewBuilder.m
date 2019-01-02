//
//  FocusViewBuilder.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 1/2/19.
//  Copyright © 2019 East Agile. All rights reserved.
//

#import "FocusViewBuilder.h"

@implementation FocusViewBuilder
+ (FocusViewBase *)buildFocusViewWithMode:(FocusViewMode)mode{
  return [self buildFocusViewWithMode:mode withAdditionalInfo:@""];
}
+ (FocusViewBase *)buildFocusViewWithMode:(FocusViewMode)mode withAdditionalInfo:(NSString *)info{
  switch (mode) {
    case kFocusViewImage:
    {
      FocusViewWithImage *viewResult = [FocusViewWithImage new];
      [viewResult setImageWithName:info];
      return viewResult;
    }
      break;
    case kFocusViewLayer:
      return [FocusViewWithLayer new];
      break;
    default:
      break;
  }
}

@end
