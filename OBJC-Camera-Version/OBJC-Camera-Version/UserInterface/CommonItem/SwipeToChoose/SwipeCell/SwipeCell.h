//
//  SwipeCell.h
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/25/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwipeCell : UICollectionViewCell
-(void)setupCellLabel:(NSString *)input withHightLight:(BOOL)isHightLight;
@end

NS_ASSUME_NONNULL_END
