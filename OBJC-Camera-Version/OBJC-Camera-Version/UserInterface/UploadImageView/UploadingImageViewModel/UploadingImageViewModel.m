//
//  UploadingImageViewModel.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/26/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "UploadingImageViewModel.h"

@implementation UploadingImageViewModel
- (int)firstIndexOfValue:(int)value inArray:(NSMutableArray *)array{
  for (int i = 0; i<array.count; i++) {
    if([array[i] intValue] == value){
      return i;// return the index
    }
  }
  return INVALID_VALUE;
}
- (int)findAllValidSlotInArray:(NSMutableArray *)array{
  int count = array.count;
  for (int i = 0; i<array.count; i++) {
    if([array[i] intValue] == INVALID_VALUE){
      count = count - 1;// return the index
    }
  }
  return count;
}
@end
