//
//  CameraControllerManager.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "CameraControllerManager.h"

typedef enum {
  kCameraModePhoto = 0,
  kCameraModeVideo = 1
} CameraModeType;

@interface CameraControllerManager ()
@property (nonatomic) AVCaptureSession *capturesSession;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureMovieFileOutput *videoOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) CameraModeType myCurrentMode;
//setting
@property (nonatomic) AVCapturePhotoSettings *photoSetting;

@end

@implementation CameraControllerManager
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.capturesSession = [AVCaptureSession new];
    self.capturesSession.sessionPreset = AVCaptureSessionPresetPhoto;
    self.stillImageOutput = [AVCapturePhotoOutput new];
    self.videoOutput = [AVCaptureMovieFileOutput new];
    self.photoSetting = [AVCapturePhotoSettings new];
    self.eventCameraController = [RACSubject subject];
    self.eventLogger =  [RACSubject subject];
    self.myCurrentMode = kCameraModePhoto; // set default is photo mode
    
    [self createInitialCamera:AVCaptureDevicePositionBack withMode:self.myCurrentMode];
    //    [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:true block:^(NSTimer * _Nonnull timer) {
    //      NSLog(@"%f",CMTimeGetSeconds(self.videoOutput.recordedDuration));
    //    }];
  }
  return self;
}
#pragma mark - Setup Camera Preview
- (void)createInitialCamera:(AVCaptureDevicePosition) position{
  [self createInitialCamera:position withMode:self.myCurrentMode];// take the same setting input output of camera
}
- (void)createInitialCamera:(AVCaptureDevicePosition) position withMode:(CameraModeType)mode{
  self.photoSetting.flashMode = AVCaptureFlashModeAuto;
  AVCaptureDevice *cameraDevice = [self cameraWithPosition:position];
  if (!cameraDevice) {
    NSLog(@"Unable to access camera!");
    return;
  }
  NSError *error;
  AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:cameraDevice
                                                                      error:&error];
  
  if (!error) {
    NSLog(@"Error:%@",error.localizedDescription);
  }
  
  self.stillImageOutput = [AVCapturePhotoOutput new];
  self.videoOutput = [AVCaptureMovieFileOutput new];
  [self clearCapture];
  if(mode == kCameraModePhoto){
    [self buildCapturePicture:input andOutput:self.stillImageOutput];
  }else{
    [self buildCameraRecord:input andOutput:self.videoOutput];
  }
  [self.capturesSession startRunning];
}
-(void)buildCapturePicture:(AVCaptureDeviceInput *)input andOutput:(AVCapturePhotoOutput *)output{
  if ([self.capturesSession canAddInput:input] && [self.capturesSession canAddOutput:output]) {
    [self.capturesSession addInput:input];
    [self.capturesSession addOutput:output];
  }
}
-(void)buildCameraRecord:(AVCaptureDeviceInput *)input andOutput:(AVCaptureMovieFileOutput *)output{
  if ([self.capturesSession canAddInput:input] && [self.capturesSession canAddOutput:output]) {
    [self.capturesSession addInput:input];
    [self.capturesSession addOutput:output];
  }
}
-(void)clearCapture{
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
- (void)setupLivePreview:(UIView *)viewDisplay {
  self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.capturesSession];
  
  if (self.videoPreviewLayer) {
    self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    [viewDisplay.layer addSublayer:self.videoPreviewLayer];
    [self ajustingLayout:viewDisplay];
  }
}
-(void)ajustingLayout:(UIView *)viewDisplay {
  dispatch_async(dispatch_get_main_queue(), ^{
    self.videoPreviewLayer.frame = CGRectMake(0, 0, viewDisplay.frame.size.width, viewDisplay.frame.size.height);
  });
}
// Find a camera with the specified AVCaptureDevicePosition, returning nil if one is not found
- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
  AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                                                                                                          mediaType:AVMediaTypeVideo
                                                                                                                           position:position];
  NSArray *captureDevices = [captureDeviceDiscoverySession devices];
  
  if(captureDevices.count > 0){
    return captureDevices[0];
  }
  return nil;
}
#pragma mark - Camera public interface function
-(void)changeFlashMode{
  //  Change the camera mode to the next, in loop
  switch (self.photoSetting.flashMode) {
    case AVCaptureFlashModeOn:
      self.photoSetting.flashMode = AVCaptureFlashModeOff;
      [self.eventLogger sendNext:@"Flash: off"];
      break;
    case AVCaptureFlashModeOff:
      self.photoSetting.flashMode = AVCaptureFlashModeAuto;
      [self.eventLogger sendNext:@"Flash: auto"];
      break;
    case AVCaptureFlashModeAuto:
      self.photoSetting.flashMode = AVCaptureFlashModeOn;
      [self.eventLogger sendNext:@"Flash: on"];
      break;
    default:
      break;
  }
  [self.eventCameraController sendNext:[NSNumber numberWithInt:self.photoSetting.flashMode]];
}
-(void)actionProcess{
  if(self.myCurrentMode == kCameraModePhoto){
    [self capturePicture];
  }else{
    [self excuteVideoRecord];
  }
}
-(void)excuteVideoRecord{
  if((self.videoOutput == nil) || (self.videoOutput.connections.count < 1)){
    [self.eventLogger sendNext:@"Oop error occured!"];
    return;
  }
  NSString *outputFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[@"movie" stringByAppendingPathExtension:@"mov"]];
  if(self.videoOutput.isRecording){
    [self.eventLogger sendNext:@"end recording"];
    [self.videoOutput stopRecording];
  }else{
    [self.eventLogger sendNext:@"start recording"];
    [self.videoOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:outputFilePath] recordingDelegate:self];
    
  }
}
-(void)capturePicture{
  if(self.stillImageOutput == nil){
    return;
  }
  [self.eventLogger sendNext:@"Image captured"];
  if([self.stillImageOutput connections].count > 0){
    AVCapturePhotoSettings *captureSetting = [AVCapturePhotoSettings photoSettingsFromPhotoSettings:self.photoSetting];
    [self.stillImageOutput capturePhotoWithSettings:captureSetting delegate:self];
  }
}

-(void)switchCameraFrontBack{
  if(self.capturesSession.inputs.count < 1 ){
    return;
  }
  AVCaptureInput *currentDevideInput = [self.capturesSession.inputs objectAtIndex:0];
  if(currentDevideInput != nil){
    if(((AVCaptureDeviceInput*)currentDevideInput).device.position == AVCaptureDevicePositionBack){
      [self createInitialCamera:AVCaptureDevicePositionFront];
    }else{
      [self createInitialCamera:AVCaptureDevicePositionBack];
    }
  }
  return;
}

#pragma mark - Camera private function
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error{
  [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    if(status != PHAuthorizationStatusAuthorized){
      return;
    }
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      PHAssetCreationRequest *requestImage = [PHAssetCreationRequest creationRequestForAsset];
      [requestImage addResourceWithType:PHAssetResourceTypePhoto data:photo.fileDataRepresentation options:nil];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
      NSLog(@"completion %@",error.localizedDescription);
    }];
  }];
}
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
  NSLog(@"captured video");
  UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, nil, nil, nil);
  [self.eventLogger sendNext:@"Video saved to PHOTOS"];
}
@end
