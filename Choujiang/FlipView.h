//
//  FrontSideView.h
//  Choujiang
//
//  Created by 胡瑨 on 14/12/13.
//  Copyright (c) 2014年 TN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface FlipView : UIView

@property (weak, nonatomic) IBOutlet UIButton *numButton;

@property (nonatomic, weak) ViewController *controller;

@end
