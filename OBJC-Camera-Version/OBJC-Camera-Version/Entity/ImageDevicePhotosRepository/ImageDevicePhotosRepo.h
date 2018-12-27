//
//  ImageDevicePhotosRepo.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/25/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface ImageDevicePhotosRepo : NSObject
@property (nonatomic, strong, readwrite) RACSubject *eventDevicePhotos;
-(void)getAllItemInPhotosDevice;
-(void)getAllAlbumInDevice;
-(void)saveAssetToPhotos;
@end

NS_ASSUME_NONNULL_END
