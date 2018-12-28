//
//  GAlleryChoosen.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/28/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface GAlleryChoosen : UICollectionViewCell
@property (nonatomic, strong, readwrite) RACSubject *eventButton;
- (void)setupCell:(PHCollection *)album;
@end

NS_ASSUME_NONNULL_END
