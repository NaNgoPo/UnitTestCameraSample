//
//  CameraController.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraControllerManager/CameraControllerManager.h"
#import "ButtonCameraController.h"
#import "SwipeToChoose.h"
#import "Toast.h"
#import "HoleView.h"
#import "BorderFocusView.h"
#import "FocusViewBase.h"
#import "FocusViewBuilder.h"
NS_ASSUME_NONNULL_BEGIN

@interface CameraController : UIViewController<ButtonDelegate>
@property (nonatomic) CameraControllerManager *cameraManager;
@end
NS_ASSUME_NONNULL_END
