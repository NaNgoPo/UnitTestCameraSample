//
//  BorderFocusView.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/26/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "BorderFocusView.h"

@implementation BorderFocusView
const int PADDING_FOCUS = 20;
const int DISTANCE = 100;
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    [self setOpaque:false];
  }
  return self;
}
- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGFloat totalDistance = PADDING_FOCUS + DISTANCE;
  CGFloat widthView = self.frame.size.width;
  CGFloat heightView = self.frame.size.height;
  CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
  //topleft
  CGContextMoveToPoint(ctx, PADDING_FOCUS, totalDistance);
  CGContextAddLineToPoint(ctx, PADDING_FOCUS, PADDING_FOCUS);
  CGContextAddLineToPoint(ctx, totalDistance, PADDING_FOCUS);
  //topright
  CGContextMoveToPoint(ctx, widthView - PADDING_FOCUS, totalDistance);
  CGContextAddLineToPoint(ctx, widthView - PADDING_FOCUS, PADDING_FOCUS);
  CGContextAddLineToPoint(ctx, widthView - totalDistance, PADDING_FOCUS);
  //bottom left
  CGContextMoveToPoint(ctx,PADDING_FOCUS, heightView - totalDistance);
  CGContextAddLineToPoint(ctx, PADDING_FOCUS, heightView - PADDING_FOCUS);
  CGContextAddLineToPoint(ctx, totalDistance, heightView - PADDING_FOCUS);
  //bottom right
  CGContextMoveToPoint(ctx,widthView - PADDING_FOCUS, heightView - totalDistance);
  CGContextAddLineToPoint(ctx, widthView - PADDING_FOCUS, heightView - PADDING_FOCUS);
  CGContextAddLineToPoint(ctx, widthView - totalDistance, heightView - PADDING_FOCUS);
  
  CGContextSetLineWidth(ctx, 6);
  CGContextStrokePath(ctx);
  UIGraphicsEndImageContext();
}
@end
