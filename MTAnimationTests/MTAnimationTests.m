//
//  MTAnimationTests.m
//  MTAnimationTests
//
//  Created by Adam Kirk on 4/25/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTAnimationTests.h"
#import "UIView+MTAnimation.h"

@implementation MTAnimationTests

- (void)setUp
{
    [super setUp];

    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

- (void)testUserInteraction {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.userInteractionEnabled = NO;
    
    __block BOOL testIsDone = NO;
    float animationDuration = 0.3f;
    
    [UIView mt_animateViews:@[view] duration:animationDuration timingFunction:kMTEaseOutExpo animations:^{
        view.alpha = 0.8f;
    } completion:^{
        testIsDone = YES;
    }];
    
    // Wait until test is done
    float seconds = 1.f + animationDuration;
    NSDate *until = [NSDate dateWithTimeIntervalSinceNow:seconds];
    while ([until timeIntervalSinceNow] > 0 && !testIsDone)
    {
        NSDate *deltaUntil = [NSDate dateWithTimeIntervalSinceNow:1.f/10];
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:deltaUntil];
    }
    
    
    STAssertTrue(testIsDone, @"Animation should have completed by now");
    STAssertFalse(view.userInteractionEnabled, @"User interaction should remain disabled");
}



@end
