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
@property (nonatomic) CameraControllerManager *cameraManager;
@property (nonatomic) ButtonCameraController *buttonCamera;
@property (weak, nonatomic) IBOutlet UIButton *buttonFlash;
@property (weak, nonatomic) IBOutlet UILabel *labelDuration;

@end

@implementation CameraController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.cameraManager = [CameraControllerManager new];
  self.buttonCamera = [ButtonCameraController new];
  self.buttonCamera.delegate = self;
  [self.viewButtonHolder addSubview:self.buttonCamera.view];
  [self.viewButtonHolder setBackgroundColor:[UIColor clearColor]];
  @weakify(self);
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
-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self.cameraManager setupLivePreview:self.cameraDisplayView];
}
- (void)viewDidLayoutSubviews{
  [self.cameraManager ajustingLayout:self.cameraDisplayView];
  self.buttonCamera.view.frame = CGRectMake(0, 0, self.viewButtonHolder.frame.size.width, self.viewButtonHolder.frame.size.height);
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
