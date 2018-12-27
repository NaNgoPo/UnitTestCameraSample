//
//  AppAVCaptureSession.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/27/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface AppAVCaptureSession : NSObject
//control session
- (BOOL)checkAndAddPhotoInput:(AVCaptureInput *)input andPhotoOutput:(AVCaptureOutput *)output;
- (void)clearAllSession;
-(BOOL)isValidSession;
//getters/setters
- (AVCaptureSession *)getSession;
@end

NS_ASSUME_NONNULL_END
