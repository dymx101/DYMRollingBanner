//
//  DYMViewController.m
//  DYMRollingBanner
//
//  Created by Daniel Dong on 12/03/2015.
//  Copyright (c) 2015 Daniel Dong. All rights reserved.
//

#import "DYMViewController.h"
#import <DYMRollingBanner/DYMRollingBannerVC.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface DYMViewController ()

@end

@implementation DYMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"embed"]
        && [segue.destinationViewController isKindOfClass:[DYMRollingBannerVC class]]) {
        
        DYMRollingBannerVC *vc = (DYMRollingBannerVC *)segue.destinationViewController;
        
        // 1. Set the inteval for rolling (optional, the default value is 1 sec)
        vc.rollingInterval = 5;
        
        // 2. set the placeholder image (optional, the default place holder is nil)
        vc.placeHolderImage = [UIImage imageNamed:@"default"];
        
        // 3. define the way how you load the image from a remote url
        [vc setRemoteImageLoadingBlock:^(UIImageView *imageView, NSString *imageUrlStr, UIImage *placeHolderImage) {
            [imageView sd_cancelCurrentImageLoad];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:placeHolderImage options:SDWebImageProgressiveDownload];
        }];
        
        // 4. setup the rolling images
        vc.rollingImages = @[@"http://easyread.ph.126.net/G8GtEi-zmPQzvS5w7ScxmQ==/7806606224489671909.jpg"
                             , @"http://www.qqpk.cn/Article/UploadFiles/201312/20131212154331984.jpg"
                             , @"http://epaper.syd.com.cn/sywb/res/1/20080108/42241199752656275.jpg"
                             , [UIImage imageNamed:@"001"]
                             , [UIImage imageNamed:@"002"]
                             ];
        
        // 5. add a handler when a tap event occours (optional, default do noting)
        [vc addBannerTapHandler:^(NSInteger whichIndex) {
            NSLog(@"banner tapped, index = %@", @(whichIndex));
        }];
        
        // 6.
        vc.isAutoScrollingBackward = YES;
        
        // 6. start auto rolling (optional, default does not auto roll)
        [vc startRolling];
    }
}

@end
