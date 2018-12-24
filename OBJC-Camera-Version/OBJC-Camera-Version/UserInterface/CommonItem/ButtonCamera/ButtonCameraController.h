//
//  ButtonCameraController.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ButtonDelegate <NSObject>
-(void)buttonDidPressed;
@end
@interface ButtonCameraController : UIViewController
@property (nonatomic, weak) id<ButtonDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
