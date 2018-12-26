//
//  UploadingImageViewModel.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/26/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Const.h"
NS_ASSUME_NONNULL_BEGIN

@interface UploadingImageViewModel : NSObject
- (int)firstIndexOfValue:(int)value inArray:(NSMutableArray *)array;
- (int)findAllValidSlotInArray:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
