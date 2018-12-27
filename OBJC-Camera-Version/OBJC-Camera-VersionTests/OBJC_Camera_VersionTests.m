//
//  OBJC_Camera_VersionTests.m
//  OBJC-Camera-VersionTests
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "CameraControllerManager.h"
#import "CameraController.h"
#import <Photos/Photos.h>
@interface OBJC_Camera_VersionTests : XCTestCase

@end

@implementation OBJC_Camera_VersionTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testCameraControllerFrontBack {
  CameraController *viewController = [CameraController new];
  
  CameraControllerManager *controllerObj = [CameraControllerManager new];
  CameraControllerManager *controllerMock = OCMPartialMock(controllerObj);
  
  AVCaptureSession *captureSession = [AVCaptureSession new];
  AVCaptureSession *captureSessionMock = OCMPartialMock(captureSession);
//  OCMStub([captureSessionMock ])
  OCMStub([controllerMock isValidSession]).andReturn(true);
  viewController.cameraManager = controllerMock;// inject the value
  [viewController.cameraManager switchCameraFrontBack];// try to call switch camera
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
