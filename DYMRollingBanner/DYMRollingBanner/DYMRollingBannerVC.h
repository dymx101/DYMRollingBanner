//
//  ViewController.h
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMBannerVC.h"

/// The view controller which rolling a group of banner images
@interface DYMRollingBannerVC : UIPageViewController
/// image urls for the rolling banner
@property (nonatomic, copy)     NSArray                 *rollingImageURLs;
/// time interval between the rolling
@property (nonatomic, assign)   NSTimeInterval          rollingInterval;


/// start rolling
-(void)startRolling;
/// stop rolling
-(void)stopRolling;

-(void)addBannerTapHandler:(DYMBannderTapHandler)handler;

@end

