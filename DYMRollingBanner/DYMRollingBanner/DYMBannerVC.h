//
//  DYMBannerVC.h
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EDYMTouchStage) {
    kDYMTouchStageBegan
    , kDYMTouchStageMoved
    , kDYMTouchStageEnded
    , kDYMTouchStageCancelled
};

typedef void(^DYMBannerTouchBlock)(NSSet *touches, UIEvent *event, EDYMTouchStage stage);

@interface DYMBannerVC : UIViewController

@property (nonatomic, strong, readonly)         UIImageView             *imageView;

@property (nonatomic, copy)                     NSString                *imageURL;

@property (nonatomic, copy)                     DYMBannerTouchBlock     touchBlock;

@end
