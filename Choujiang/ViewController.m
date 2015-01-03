//
//  ViewController.m
//  Choujiang
//
//  Created by 胡瑨 on 14/12/13.
//  Copyright (c) 2014年 TN. All rights reserved.
//

#import "ViewController.h"
#import "FlipView.h"
#import "HJTimer.h"

#define PEOPLE_COUNT 11
#define Red_Color [UIColor colorWithRed:1 green:73.0/255.0 blue:18.0/255.0 alpha:1]

@interface ViewController ()
{
    CGFloat duration;
    CGFloat rate;
    CGFloat maxDuration;
    CGFloat tempDuration;
}

@property (nonatomic, strong) FlipView * frontView;
@property (nonatomic, strong) FlipView * backView;
@property (nonatomic, strong) HJTimer * timer;

@property (nonatomic, strong) UIView * subView;

@property (nonatomic, strong) HJTimer * durationTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.subView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.subView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.subView];
    
    self.frontView = [[[NSBundle mainBundle] loadNibNamed:@"FlipView" owner:nil options:nil] objectAtIndex:0];
    self.frontView.controller = self;
    self.backView = [[[NSBundle mainBundle] loadNibNamed:@"FlipView" owner:nil options:nil] objectAtIndex:0];
    self.backView.controller = self;
    
    self.frontView.layer.cornerRadius = self.frontView.bounds.size.width/2;
    self.frontView.layer.borderWidth = 5;
    self.frontView.layer.borderColor = [Red_Color CGColor];
    self.frontView.layer.masksToBounds = YES;
    
    self.backView.layer.cornerRadius = self.backView.bounds.size.width/2;
    self.backView.layer.borderWidth = 5;
    self.backView.layer.borderColor = [Red_Color CGColor];
    self.backView.layer.masksToBounds = YES;
    
    self.backView.center = self.subView.center;
    self.frontView.center = self.subView.center;
    [self.subView addSubview:self.backView];
    [self.subView addSubview:self.frontView];
    
}

- (void)start
{
    duration = 0.1;
    rate = 1.0;
    self.frontView.numButton.enabled = NO;
    self.backView.numButton.enabled = NO;
    
    if (self.frontView.numButton.enabled == YES) {
        [self flipToBack];
    }
    else
    {
        [self flipToFront];
    }
    
    maxDuration = [self random:10]/10.0 + 1;
    self.timer = [HJTimer timeWithTimeInterval:1 target:self selector:@selector(flipToBack) withObject:nil repeats:NO];
    self.durationTimer = [HJTimer timeWithTimeInterval:rate target:self selector:@selector(updateDuration) withObject:nil repeats:YES];
}

- (void)updateDuration
{
    if (duration >= maxDuration) {
        duration = 0;
        self.timer = nil;
        return;
    }
    duration += [self random:10]/100.0;
    rate += [self random:10]/100.0;
}

- (void)flipToBack
{
    if (duration == 0) {
        self.frontView.numButton.enabled = YES;
        return;
    }
    tempDuration = duration;
    [UIView transitionFromView:self.frontView toView:self.backView duration:tempDuration options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionShowHideTransitionViews completion:^(BOOL finished) {
        [self.frontView.numButton setTitle:[NSString stringWithFormat:@"%d",[self random:PEOPLE_COUNT]] forState:UIControlStateNormal];
        if (duration == 0) {
            self.backView.numButton.enabled = YES;
            self.timer = nil;
            return;
        }
        self.timer = [HJTimer timeWithTimeInterval:0 target:self selector:@selector(flipToFront) withObject:nil repeats:NO];
    }];
}

- (void)flipToFront
{
    if (duration == 0) {
        self.backView.numButton.enabled = YES;
        return;
    }
    tempDuration = duration;
    [UIView transitionFromView:self.backView toView:self.frontView duration:tempDuration options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionShowHideTransitionViews completion:^(BOOL finished) {
        [self.backView.numButton setTitle:[NSString stringWithFormat:@"%d",[self random:PEOPLE_COUNT]] forState:UIControlStateNormal];
        if (duration == 0) {
            self.frontView.numButton.enabled = YES;
            self.timer = nil;
            return;
        }
        self.timer = [HJTimer timeWithTimeInterval:0 target:self selector:@selector(flipToBack) withObject:nil repeats:NO];
    }];
}

- (int)random:(int)max
{
    int index = arc4random() % max + 1;
    return index;
}

@end
