//
//  SwipeCell.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/25/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "SwipeCell.h"
@interface SwipeCell()
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;

@end

@implementation SwipeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setupCellLabel:(NSString *)input withHightLight:(BOOL)isHightLight{
  self.centerLabel.text = input;
  UIFont *currentFont = self.centerLabel.font;
  if(isHightLight){
    [self.centerLabel setFont:[UIFont fontWithName:currentFont.fontName size:20]];
  }else{
     [self.centerLabel setFont:[UIFont fontWithName:currentFont.fontName size:14]];
  }
}
@end
