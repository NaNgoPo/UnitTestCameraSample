//
//  CarouselView.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/26/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>
#import <Photos/Photos.h>
#import <ReactiveObjC.h>
#import "Const.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarouselView : UIViewController<iCarouselDelegate,iCarouselDataSource>
@property (strong, nonatomic) NSMutableArray<PHAsset *> *listOfAsset;
- (void)changeDisplay:( PHFetchResult<PHAsset *> * _Nullable)assets fromInfo:(NSMutableArray *)selectedList;
@end

NS_ASSUME_NONNULL_END
