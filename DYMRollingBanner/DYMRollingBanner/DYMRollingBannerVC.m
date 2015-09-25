//
//  ViewController.m
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import "DYMRollingBannerVC.h"
#import "DYMBannerVC.h"
#import "DYMBannerPool.h"

@interface DYMRollingBannerVC () <UIPageViewControllerDataSource> {
    
    NSTimer         *_timer;
    
    DYMBannerPool   *_bannerPool;
}

@end

@implementation DYMRollingBannerVC

-(NSTimeInterval)rollingInterval {
    if (_rollingInterval < 1) {
        _rollingInterval = 1;
    }
    
    return _rollingInterval;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    
    _bannerPool = [[DYMBannerPool alloc] initWithSize:10];
    
    DYMBannerVC *vc = [_bannerPool dequeueBannerExclude:self.viewControllers];
    vc.imageURL = _rollingImageURLs.firstObject;
    [self setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(void)startRolling {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.rollingInterval target:self selector:@selector(doRolling) userInfo:nil repeats:YES];
    
    // I haven't added the timer to the runloop common modes since I need the timer to be paused when scrolling...
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)stopRolling {
    [_timer invalidate];
    _timer = nil;
}

-(void)pauseRolling {
//    NSLog(@"pauseRolling");
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)resumeRolling {
//    NSLog(@"resumeRolling");
    [_timer setFireDate:[NSDate dateWithTimeInterval:self.rollingInterval sinceDate:[NSDate date]]];
}

-(void)doRolling {
    DYMBannerVC *currentVC = (DYMBannerVC *)self.viewControllers.firstObject;
    DYMBannerVC *nextVC = [self vcNextTo:currentVC beforeOrAfter:NO];
    if (nextVC == nil) {
        nextVC = [_bannerPool dequeueBannerExclude:self.viewControllers];
        nextVC.imageURL = _rollingImageURLs.firstObject;
    }
    
    [self setViewControllers:@[nextVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(NSInteger)cycleChangeIndex:(NSInteger)index delta:(NSInteger)delta maxIndex:(NSInteger)maxIndex {
    
//    NSLog(@"input index:%@, delta:%@, maxIndex:%@", @(index), @(delta), @(maxIndex));
    
    index += delta;
    
    if (index < 0) {
        index = maxIndex;
    } else if (index > maxIndex) {
        index = 0;
    }
    
//    NSLog(@"output index:%@", @(index));
    
    return index;
}

#pragma mark -  UIPageViewControllerDataSource
/// HELPER METHOD: beforeOrAfter: YES - Before, NO - After
-(DYMBannerVC *)vcNextTo:(UIViewController *)vc beforeOrAfter:(BOOL)beforeOrAfter {
    
    if (![vc isKindOfClass:[DYMBannerVC class]]) {
//        NSLog(@"vc:%@ invalid, return nil", vc);
        return nil;
    }
    
    DYMBannerVC *nextVC = [_bannerPool dequeueBannerExclude:self.viewControllers];
    
    NSString *imageURL = ((DYMBannerVC *)vc).imageURL;
    NSInteger index = [_rollingImageURLs indexOfObject:imageURL];
    if (index != NSNotFound) {
        NSInteger nextIndex = [self cycleChangeIndex:index delta:(beforeOrAfter ? -1 : 1) maxIndex:_rollingImageURLs.count - 1];
//        NSLog(@"current index:%@, next index:%@ \n", @(index), @(nextIndex));
        nextVC.imageURL = _rollingImageURLs[nextIndex];
        
        return nextVC;
    }
    
//    NSLog(@"imageURL:%@ invalid, return nil", imageURL);
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
//    NSLog(@"viewControllerBeforeViewController");
    return [self vcNextTo:viewController beforeOrAfter:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
//    NSLog(@"viewControllerAfterViewController");
    return [self vcNextTo:viewController beforeOrAfter:NO];
}


@end
