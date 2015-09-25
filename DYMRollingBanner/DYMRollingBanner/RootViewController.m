//
//  RootViewController.m
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import "RootViewController.h"
#import "DYMRollingBannerVC.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"containment"]
        && [segue.destinationViewController isKindOfClass:[DYMRollingBannerVC class]]) {
        
        DYMRollingBannerVC *vc = (DYMRollingBannerVC *)segue.destinationViewController;
        vc.rollingInterval = 5;
        vc.rollingImageURLs = @[@"http://www.drpsychmom.com/wp-content/uploads/2014/10/large_4278047231.jpg"    // bridge
                                , @"https://c2.staticflickr.com/4/3345/5832660048_55f8b0935b.jpg"               // girl
                                , @"http://epaper.syd.com.cn/sywb/res/1/20080108/42241199752656275.jpg"         // another puppy
                                ];
        
        [vc addBannerTapHandler:^(NSInteger whichIndex) {
            NSLog(@"banner tapped, index = %@", @(whichIndex));
        }];
        
        [vc startRolling];
    }
}

@end
