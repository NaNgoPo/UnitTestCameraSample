//
//  CameraControllerManager.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <ReactiveObjC.h>
#import "Const.h"
#import "CameraControllerViewModel.h"
#import "AppAVCaptureSession.h"
NS_ASSUME_NONNULL_BEGIN

@interface CameraControllerManager : NSObject<AVCapturePhotoCaptureDelegate,AVCaptureFileOutputRecordingDelegate>
@property (nonatomic, strong, readwrite) RACSubject *eventCameraController;
@property (nonatomic, strong, readwrite) RACSubject *eventLogger;
//Create View and add to tje viewDisplay
- (void)setupLivePreview:(UIView *)viewDisplay;
- (void)ajustingLayout:(UIView *)viewDisplay;
- (void)switchCameraFrontBack;
- (void)actionProcess;
- (void)changeFlashMode;
- (void)setMode:(CameraModeType)type;
- (NSString*)recoredTime;
- (BOOL)isValidSession;
@end

NS_ASSUME_NONNULL_END
