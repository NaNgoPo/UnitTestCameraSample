//
//  GalleryChoosenController.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/28/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "GalleryChoosenController.h"
@interface GalleryChoosenController()
@property(strong,nonatomic) ImageDevicePhotosRepo *imageRepo;

@end
@implementation GalleryChoosenController
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.imageRepo = [ImageDevicePhotosRepo new];
    self.items = [NSMutableArray new];
    self.eventLayout = [RACSubject new];
    [self setupObserve];
    [self.imageRepo getAllAlbumInDevice];
  }
  return self;
}
- (void)setupObserve{
  @weakify(self);
  [self.imageRepo.eventGalleryManage subscribeNext:^(id  _Nullable results) {// listen the change of gallery
    if( [results isKindOfClass:[NSMutableArray class]]){
      @strongify(self);
      self.items = results;
      [self.eventLayout sendNext:@"completed"];
    }
  }];
}

@end
