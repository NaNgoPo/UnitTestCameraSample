//
//  UploadingImageController.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/25/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "ImageDevicePhotosRepo.h"
#import "UploadingImageViewModel.h"
#import "Const.h"
NS_ASSUME_NONNULL_BEGIN

@interface UploadingImageController : NSObject
@property (nonatomic, strong, readwrite) RACSubject *eventLoadImage;
@property (nonatomic, strong, readwrite) RACSubject *eventPickImage;
@property (nonatomic, strong, readwrite) RACSubject *eventSelected;
-(void)getAllItemInDevicePhotos;
-(void)selectAssetAtIndex:(int)index andList:(PHFetchResult<PHAsset *> *)assetList;
-(BOOL)isSelectedItemAt:(int)index;
-(int)getCountValidItem;
@end

NS_ASSUME_NONNULL_END
