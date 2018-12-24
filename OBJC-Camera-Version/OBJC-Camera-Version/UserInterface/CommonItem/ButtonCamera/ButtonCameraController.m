//
//  ButtonCameraController.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "ButtonCameraController.h"

@interface ButtonCameraController ()

@end

@implementation ButtonCameraController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidLayoutSubviews{
  self.view.layer.cornerRadius = self.view.frame.size.width / 2;
}
- (IBAction)buttonProcessDidPressed:(id)sender {
  [self.delegate buttonDidPressed];
}
@end
