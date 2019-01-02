//
//  FocusViewBase.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 1/2/19.
//  Copyright © 2019 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HoleView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FocusViewBase : UIView
- (void)buildView;
- (void)adjustSize:(CGRect)newSize;
@end

NS_ASSUME_NONNULL_END
