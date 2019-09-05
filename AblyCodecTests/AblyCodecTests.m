//
//  AblyCodecTests.m
//  AblyCodecTests
//
//  Created by Ricardo Pereira on 05/09/2019.
//  Copyright © 2019 Ably. All rights reserved.
//

#import <XCTest/XCTest.h>

@import AblyCodec;

@interface AblyCodecTests : XCTestCase

@end

@implementation AblyCodecTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    ARTCodec *codec = [[ARTCodec alloc] init];
    [codec test];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
