//
//  ViewController.m
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import "DYMRollingBannerVC.h"
#import "DYMBannerVC.h"

@interface DYMRollingBannerVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate> {
    DYMBannerVC     *_banner1;
    DYMBannerVC     *_banner2;
    
    NSTimer         *_timer;
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
    
    _banner1 = [DYMBannerVC new];
    _banner1.view.backgroundColor = [UIColor orangeColor];
    
    _banner2 = [DYMBannerVC new];
    _banner2.view.backgroundColor = [UIColor redColor];
    
//    __weak typeof(self) weakSelf = self;
//    DYMBannerTouchBlock touchBlock = ^void(NSSet *touches, UIEvent *event, EDYMTouchStage stage) {
//        
//        __strong typeof(self) strong = weakSelf;
//        if (stage == kDYMTouchStageBegan) {
//            [strong pauseRolling];
//        } else {
//            [strong resumeRolling];
//        }
//    };
//    
//    _banner1.touchBlock = touchBlock;
//    _banner2.touchBlock = touchBlock;
    
    _banner1.imageURL = _rollingImageURLs.firstObject;
    [self setViewControllers:@[_banner1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(void)startRolling {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.rollingInterval target:self selector:@selector(doRolling) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)stopRolling {
    [_timer invalidate];
    _timer = nil;
}

-(void)pauseRolling {
    NSLog(@"pauseRolling");
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)resumeRolling {
    NSLog(@"resumeRolling");
    [_timer setFireDate:[NSDate dateWithTimeInterval:self.rollingInterval sinceDate:[NSDate date]]];
}

-(void)doRolling {
    DYMBannerVC *currentVC = (DYMBannerVC *)self.viewControllers.firstObject;
    DYMBannerVC *nextVC = [self vcNextTo:currentVC beforeOrAfter:NO];
    if (nextVC == nil) {
        nextVC = _banner1;
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
        return nil;
    }
    
    DYMBannerVC *nextVC = (vc == _banner1 ? _banner2 : _banner1);
    
    NSInteger index = [_rollingImageURLs indexOfObject:((DYMBannerVC *)vc).imageURL];
    if (index != NSNotFound) {
        NSInteger nextIndex = [self cycleChangeIndex:index delta:(beforeOrAfter ? -1 : 1) maxIndex:_rollingImageURLs.count - 1];
        nextVC.imageURL = _rollingImageURLs[nextIndex];
        
        NSLog(@"current index:%@, next index:%@", @(index), @(nextIndex));
        
        return nextVC;
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSLog(@"viewControllerBeforeViewController");
    return [self vcNextTo:viewController beforeOrAfter:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSLog(@"viewControllerAfterViewController");
    return [self vcNextTo:viewController beforeOrAfter:NO];
}

#pragma mark -  UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    NSLog(@"willTransitionToViewControllers");
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"didFinishAnimating");
}


@end
