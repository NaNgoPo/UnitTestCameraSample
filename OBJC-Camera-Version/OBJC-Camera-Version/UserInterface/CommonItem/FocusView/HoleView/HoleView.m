//
//  HoleView.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/26/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "HoleView.h"

@implementation HoleView
const int PADDING = 10;
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    [self setOpaque:false];
  }
  return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
  [super drawRect:rect];
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(ctx, [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.5].CGColor);
  CGContextAddRect(ctx, rect);
  CGContextFillPath(ctx);
  CGRect smallRect = CGRectMake(PADDING, PADDING, rect.size.width - (PADDING * 2.0), rect.size.height - (PADDING * 2.0));
  [self createBigRect:rect withSmallRectInside:smallRect];
  UIGraphicsEndImageContext();
}
-(void)createBigRect:(CGRect)bigrect withSmallRectInside:(CGRect)smallRect {
  CAShapeLayer *shapeCenter = [CAShapeLayer new];
  CGPathRef newPath = CGPathCreateMutable();
  CGPathAddRect(newPath, nil, smallRect);
  CGPathAddRect(newPath, nil, bigrect);
  shapeCenter.path = newPath;
  shapeCenter.fillRule = kCAFillRuleEvenOdd;
  self.layer.mask = shapeCenter;
}
@end
