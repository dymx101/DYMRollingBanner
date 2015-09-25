//
//  DYMBannerVC.h
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DYMBannderTapHandler)(NSInteger whichIndex);

/// Banner view controllers to show a banner image
@interface DYMBannerVC : UIViewController

/// placeHolder for the banner image
@property (nonatomic, strong)                   UIImage                 *placeHolder;
/// image url for the banner
@property (nonatomic, copy)                     NSString                *imageURL;
/// temporarily save the current index of the banner
@property (nonatomic, assign)                   NSInteger               index;

/// handler block for banner tapping
@property (nonatomic, copy)                     DYMBannderTapHandler    bannerTapHandler;

@end
