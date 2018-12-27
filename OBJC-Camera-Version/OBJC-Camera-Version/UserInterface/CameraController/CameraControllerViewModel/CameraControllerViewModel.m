//
//  CameraControllerViewModel.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/27/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "CameraControllerViewModel.h"

@implementation CameraControllerViewModel
-(void)saveAsset:(id)asset{
  if([asset isKindOfClass:[NSURL class]]){
    [self saveVideo:(NSURL *)asset];
  }else if([asset isKindOfClass:[AVCapturePhoto class]]){
    [self savePhoto:(AVCapturePhoto *)asset ];
  }else{
    NSLog(@"Unsupport file saving");
  }
}
-(void)savePhoto:(AVCapturePhoto *)photo{
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
-(void)saveVideo:(NSURL *)videoUrl{
   UISaveVideoAtPathToSavedPhotosAlbum(videoUrl.path, nil, nil, nil);
}
@end
