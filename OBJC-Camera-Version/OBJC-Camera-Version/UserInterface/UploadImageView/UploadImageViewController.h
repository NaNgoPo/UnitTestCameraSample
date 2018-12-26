//
//  UploadImageViewController.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadingImageController.h"
#import <ReactiveObjC.h>
#import "UploadingImageCell.h"
#import "CarouselView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UploadImageViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

NS_ASSUME_NONNULL_END
