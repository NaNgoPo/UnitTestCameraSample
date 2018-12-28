//
//  CameraController.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "CameraController.h"

@interface CameraController ()
@property (weak, nonatomic) IBOutlet UIView *cameraDisplayView;
@property (weak, nonatomic) IBOutlet UIView *viewButtonHolder;
@property (weak, nonatomic) IBOutlet UIButton *buttonFlash;
@property (weak, nonatomic) IBOutlet UILabel *labelDuration;
@property (weak, nonatomic) IBOutlet UIView *swipeChoosenViewHolder;
@property (weak, nonatomic) IBOutlet UIView *focusView;

@property (strong, nonatomic) SwipeToChoose *swipeToChooseView;
//@property (nonatomic) CameraControllerManager *cameraManager;
@property (nonatomic) ButtonCameraController *buttonCamera;
@property (nonatomic) HoleView *holeView;
@property (nonatomic) BorderFocusView *focusViewRect;
@end

@implementation CameraController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.cameraManager = [CameraControllerManager new];
  self.buttonCamera = [ButtonCameraController new];
  self.holeView = [HoleView new];
  [self.focusView addSubview:self.holeView];
  self.focusViewRect = [BorderFocusView new];
  [self.focusView addSubview:self.focusViewRect];
  self.buttonCamera.delegate = self;
  [self.viewButtonHolder addSubview:self.buttonCamera.view];
  [self.viewButtonHolder setBackgroundColor:[UIColor clearColor]];
  self.swipeToChooseView = [SwipeToChoose new];
  [self.swipeChoosenViewHolder addSubview:self.swipeToChooseView.view];
  @weakify(self);
  [self.swipeToChooseView.eventChangeMode subscribeNext:^(id  _Nullable info) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [self.cameraManager setMode:(CameraModeType)[info integerValue]];
    });
    if([info integerValue] == kCameraModePhoto){
      dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.labelDuration setHidden:true];
      });
    }else{
      dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.labelDuration setHidden:false];
      });
    }
  }];
  [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:true block:^(NSTimer * _Nonnull timer) {
    dispatch_async(dispatch_get_main_queue(), ^(void){
      self.labelDuration.text = [self.cameraManager recoredTime];
    });
  }];
  [self.cameraManager.eventCameraController subscribeNext:^(id  _Nullable cameraFlashSignal) {
    @strongify(self);
    NSInteger flashMode = [(NSNumber *)cameraFlashSignal integerValue];
    NSString *nameImage = @"ic_flash_off";
    switch (flashMode) {
      case 0:// flash off
        nameImage = @"ic_flash_off";
        break;
      case 1:// flash on
        nameImage = @"ic_flash_on";
        break;
      case 2:// flash auto
        nameImage = @"ic_flash_auto";
        break;
      default:
        break;
    }
    dispatch_async(dispatch_get_main_queue(), ^(void){
      [self.buttonFlash setImage:[UIImage imageNamed:nameImage] forState:UIControlStateNormal];
    });
  }];
  [self.cameraManager.eventLogger subscribeNext:^(id  _Nullable loggerInfo) {
    @strongify(self);
    NSString *diplayString = (NSString *)loggerInfo;
    dispatch_async(dispatch_get_main_queue(), ^(void){
      [self.view makeToast:diplayString];
    });
  }];
  
}
- (void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self.cameraManager setupLivePreview:self.cameraDisplayView];
}
- (void)viewDidLayoutSubviews{
  [self.cameraManager ajustingLayout:self.cameraDisplayView];
  self.buttonCamera.view.frame = CGRectMake(0, 0, self.viewButtonHolder.frame.size.width, self.viewButtonHolder.frame.size.height);
  self.swipeToChooseView.view.frame = CGRectMake(0, 0, self.swipeChoosenViewHolder.frame.size.width, self.swipeChoosenViewHolder.frame.size.height);//self.swipeChoosenViewHolder
  self.holeView.frame = CGRectMake(0, 0, self.focusView.frame.size.width, self.focusView.frame.size.height);
  self.focusViewRect.frame = CGRectMake(0, 0, self.focusView.frame.size.width, self.focusView.frame.size.height);
}
- (IBAction)requestChangeCamera:(id)sender {
  [self.cameraManager switchCameraFrontBack];
}
- (IBAction)openGalleryDidPressed:(id)sender {
  [self performSegueWithIdentifier:@"showUpload" sender:self];
}
-(void)buttonDidPressed{
  [self.cameraManager actionProcess];
}
- (IBAction)buttonFlashDidPressed:(id)sender {
  [self.cameraManager changeFlashMode];
}

@end
