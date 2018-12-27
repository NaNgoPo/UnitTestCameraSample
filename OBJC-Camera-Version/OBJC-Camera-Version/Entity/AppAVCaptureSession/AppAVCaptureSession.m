//
//  AppAVCaptureSession.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/27/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "AppAVCaptureSession.h"
@interface AppAVCaptureSession()
@property (nonatomic) AVCaptureSession *capturesSession;
@end

@implementation AppAVCaptureSession
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.capturesSession = [AVCaptureSession new];
  }
  return self;
}
#pragma mark - CONTROL CAPTURE SESSION
- (BOOL)checkAndAddPhotoInput:(AVCaptureInput *)input andPhotoOutput:(AVCaptureOutput *)output{
  if ([self.capturesSession canAddInput:input] && [self.capturesSession canAddOutput:output]) {// check and add capture session
    [self.capturesSession addInput:input];
    [self.capturesSession addOutput:output];
    return true;
  }
  return false;
}
- (void)clearAllSession{
  if(self.capturesSession == nil){
    return;
  }
  for(AVCaptureInput *input in self.capturesSession.inputs){
    [self.capturesSession removeInput:input];
  }
  for(AVCaptureOutput *output in self.capturesSession.outputs){
    [self.capturesSession removeOutput:output];
  }
}
- (BOOL)isValidSession{
  return (self.capturesSession.inputs.count > 0);
}
#pragma mark - getters/setters
- (AVCaptureSession *)getSession{
  return self.capturesSession;
}
@end
