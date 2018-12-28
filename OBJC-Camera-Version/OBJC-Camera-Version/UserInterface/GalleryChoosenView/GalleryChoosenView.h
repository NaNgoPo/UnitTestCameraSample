//
//  GalleryChoosenView.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/28/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAlleryChoosen.h"
#import "GalleryChoosenController.h"
NS_ASSUME_NONNULL_BEGIN

@interface GalleryChoosenView : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong, readwrite) RACSubject *eventChoosenGallery;
@end

NS_ASSUME_NONNULL_END
