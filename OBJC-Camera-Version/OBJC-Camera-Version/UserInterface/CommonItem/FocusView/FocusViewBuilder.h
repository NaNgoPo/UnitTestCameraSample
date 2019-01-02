//
//  FocusViewBuilder.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 1/2/19.
//  Copyright © 2019 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FocusViewBase.h"
#import "FocusViewWithImage.h"
#import "FocusViewWithLayer.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum :int{
  kFocusViewLayer = 0,
  kFocusViewImage = 1
} FocusViewMode;
@interface FocusViewBuilder : NSObject
+ (FocusViewBase *)buildFocusViewWithMode:(FocusViewMode)mode;
+ (FocusViewBase *)buildFocusViewWithMode:(FocusViewMode)mode withAdditionalInfo:(NSString *)info;
@end

NS_ASSUME_NONNULL_END
