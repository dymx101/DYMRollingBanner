//
//  ViewController.h
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYMRollingBannerVC : UIPageViewController

@property (nonatomic, copy)     NSArray             *rollingImageURLs;
@property (nonatomic, assign)   NSTimeInterval      rollingInterval;

-(void)startRolling;
-(void)stopRolling;

@end

