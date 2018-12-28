//
//  GalleryChoosenController.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/28/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "ImageDevicePhotosRepo.h"
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface GalleryChoosenController : NSObject
@property(strong,nonatomic) NSMutableArray<PHCollection *> *items;
@property (nonatomic, strong, readwrite) RACSubject *eventLayout;
@end

NS_ASSUME_NONNULL_END
