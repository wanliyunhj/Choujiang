//
//  HJTimer.m
//
//  Created by hujin on 14-2-13.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import "HJTimer.h"
#import "HJTimerBridge.h"

@interface HJTimer ()
@property (nonatomic, strong) HJTimerBridge *timerBridge;
@end

@implementation HJTimer
@synthesize timerBridge;

- (void)dealloc
{
    [timerBridge invalidate];
}

+ (HJTimer *)timeWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector withObject:(id)object repeats:(BOOL)repeat{
    HJTimer *timerBridge = [[HJTimer alloc] initWithTimeInterval:interval target:target selector:selector withObject:object repeats:repeat];
    return timerBridge;
}

- (id)initWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector withObject:(id)object repeats:(BOOL)repeat{
    self = [super init];
    if (self) {
        self.timerBridge = [HJTimerBridge timerBridgeWithTimeInterval:interval target:target selector:selector withObject:object repeats:repeat];
    }
    return self;
}



@end
