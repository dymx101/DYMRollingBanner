//
//  DYMBannerVC.h
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Banner view controllers to show a banner image
@interface DYMBannerVC : UIViewController

/// placeHolder for the banner image
@property (nonatomic, strong)                   UIImage                 *placeHolder;
/// image url for the banner
@property (nonatomic, copy)                     NSString                *imageURL;

@end
