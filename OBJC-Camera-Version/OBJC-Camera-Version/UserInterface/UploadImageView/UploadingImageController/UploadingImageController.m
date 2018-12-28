//
//  UploadingImageController.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/25/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "UploadingImageController.h"

@interface UploadingImageController()
@property(strong,nonatomic) ImageDevicePhotosRepo *imageRepository;
@property(strong,nonatomic) UploadingImageViewModel *viewModel;
@property(strong,nonatomic) NSMutableArray *itemList;
@end
@implementation UploadingImageController
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.eventLoadImage = [RACSubject new];
    self.eventPickImage = [RACSubject new];
    self.eventSelected = [RACSubject new];
    self.imageRepository = [ImageDevicePhotosRepo new];
    self.viewModel = [UploadingImageViewModel new];
    NSArray *arrayValue = @[@-1, @-1, @-1, @-1, @-1];
    self.itemList = [[NSMutableArray alloc] initWithArray:arrayValue];
    
    @weakify(self);
    [self.imageRepository.eventDevicePhotos subscribeNext:^(id  _Nullable fetchResult) {
      @strongify(self);
      PHFetchResult<PHAsset *> *result = (PHFetchResult<PHAsset *> *)fetchResult;
      [self.eventLoadImage sendNext:result];
    }];
  }
  return self;
}
- (void)getAllItemInDevicePhotos{
  [self.imageRepository getAllItemInPhotosDevice];
}
- (void)getAllItemInsideAlbum:(PHAssetCollection *)album{
  [self.imageRepository getAllItemInsideAlbum:album];
}
- (void)selectAssetAtIndex:(int)index andList:(PHFetchResult<PHAsset *> *)assetList{
  int foundedIndex = [self.viewModel firstIndexOfValue:index inArray:self.itemList];
  if(foundedIndex == INVALID_VALUE){ // the value is not inside the set, so need to add it
    [self setFirstEmptySpaceWith:index forList:self.itemList];
  }else{ // the value is inside the set,need to remove index
    [self removeItemWith:index forList:self.itemList];
  }
  [self.eventSelected sendNext:self.itemList];
}
- (void)setFirstEmptySpaceWith:(int)value forList:(NSMutableArray *)list{
  int foundedIndex = [self.viewModel firstIndexOfValue:INVALID_VALUE inArray:list];
  if(foundedIndex != INVALID_VALUE){// found an empty slot!!!
    [list replaceObjectAtIndex:foundedIndex withObject:[NSNumber numberWithInt:value]];
  }
}
- (void)removeItemWith:(int)value forList:(NSMutableArray *)list{
  int foundedIndex = [self.viewModel firstIndexOfValue:value inArray:list];
  if(foundedIndex != INVALID_VALUE){// found an empty slot!!!
    [list replaceObjectAtIndex:foundedIndex withObject:[NSNumber numberWithInt:-1]];
  }
}
- (BOOL)isSelectedItemAt:(int)index{
  int foundedIndex = [self.viewModel firstIndexOfValue:index inArray:self.itemList];
  return (foundedIndex != INVALID_VALUE);
}
- (int)getCountValidItem{
  return [self.viewModel findAllValidSlotInArray:self.itemList];
}
- (void)clearState{
  NSArray *arrayValue = @[@-1, @-1, @-1, @-1, @-1];
  self.itemList = [[NSMutableArray alloc] initWithArray:arrayValue];
  [self.eventSelected sendNext:self.itemList];
}
@end
