//
//  DYMViewController.m
//  DYMRollingBanner
//
//  Created by Daniel Dong on 09/26/2015.
//  Copyright (c) 2015 Daniel Dong. All rights reserved.
//

#import "DYMViewController.h"
#import <DYMRollingBanner/DYMRollingBannerVC.h>

@interface DYMViewController ()

@end

@implementation DYMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"embed"]
        && [segue.destinationViewController isKindOfClass:[DYMRollingBannerVC class]]) {
        
        DYMRollingBannerVC *vc = (DYMRollingBannerVC *)segue.destinationViewController;
        vc.rollingInterval = 5;
        
        vc.rollingImages = @[@"http://www.drpsychmom.com/wp-content/uploads/2014/10/large_4278047231.jpg"
                             , @"https://c2.staticflickr.com/4/3345/5832660048_55f8b0935b.jpg"
                             , @"http://epaper.syd.com.cn/sywb/res/1/20080108/42241199752656275.jpg"
                             , [UIImage imageNamed:@"001"]
                             , [UIImage imageNamed:@"002"]
                             ];
        
        [vc addBannerTapHandler:^(NSInteger whichIndex) {
            NSLog(@"banner tapped, index = %@", @(whichIndex));
        }];
        
        [vc startRolling];
    }
}

@end
