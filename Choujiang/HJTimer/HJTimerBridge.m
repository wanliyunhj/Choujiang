//
//  HJTimerBridge.m
//
//  Created by hujin on 14-2-13.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import "HJTimerBridge.h"

#define hjCallBack(target, sel, ...) \
IMP imp = [target methodForSelector:sel]; \
void (*func)(id, SEL, ...) = (void *)imp; \
func(target, sel, ## __VA_ARGS__);

@interface HJTimerBridge ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL targetSelector;

@end

@implementation HJTimerBridge
@synthesize timer;
@synthesize target;
@synthesize targetSelector;

- (id)init {
    self = [super init];
    return self;
}


+ (HJTimerBridge *)timerBridgeWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector withObject:(id)object repeats:(BOOL)repeat {
    HJTimerBridge *controller = [[HJTimerBridge alloc] init];
    controller.target = target;
    controller.targetSelector = selector;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:controller selector:@selector(fire:) userInfo:object repeats:repeat];
    
    controller.timer = timer;
    
    return controller;
}

- (void)fire:(id)object {
    NSTimer * tempTimer = (NSTimer *)object;
    hjCallBack(target, targetSelector,tempTimer.userInfo);
}

- (void)invalidate {    
    self.target = nil;
    
    [self.timer invalidate];
    self.timer = nil;
}

- (BOOL)isValid {
    return [self.timer isValid];
}

- (void)dealloc {
    [timer invalidate];
}
@end
