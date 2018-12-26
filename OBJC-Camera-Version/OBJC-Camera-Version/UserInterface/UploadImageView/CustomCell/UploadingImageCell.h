//
//  UploadingImageCell.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface UploadingImageCell : UICollectionViewCell
-(void)setupUploadingCell:(PHAsset *)asset withHighLight:(BOOL)isHighLight;
@end

NS_ASSUME_NONNULL_END
