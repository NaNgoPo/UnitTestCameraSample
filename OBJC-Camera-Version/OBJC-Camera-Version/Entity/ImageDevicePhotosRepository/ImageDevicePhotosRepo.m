//
//  ImageDevicePhotosRepo.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/25/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "ImageDevicePhotosRepo.h"

@implementation ImageDevicePhotosRepo
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.eventDevicePhotos = [RACSubject new];
  }
  return self;
}
-(void)getAllItemInPhotosDevice{
  [self requestAuthorize];// call the authorize
  PHFetchOptions *options = [PHFetchOptions new];
  NSArray *arrayDescriptor = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:true],nil];
  options.sortDescriptors = arrayDescriptor;
  options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d || mediaType == %d",PHAssetMediaTypeImage,PHAssetMediaTypeVideo];
  PHFetchResult<PHAsset *> *imagesAndVideos =[PHAsset fetchAssetsWithOptions:options];
  [self.eventDevicePhotos sendNext:imagesAndVideos];
}
-(void)requestAuthorize{
  [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    
  }];
}
@end
