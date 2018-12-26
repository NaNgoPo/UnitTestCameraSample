//
//  SwipeToChoose.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/25/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeCell.h"
#import <ReactiveObjC.h>
#import "Const.h"
NS_ASSUME_NONNULL_BEGIN

@interface SwipeToChoose : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) RACSubject *eventChangeMode;
@end

NS_ASSUME_NONNULL_END
