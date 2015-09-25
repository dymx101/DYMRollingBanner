//
//  ViewController.m
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import "DYMRollingBannerVC.h"
#import "DYMBannerPool.h"
#import <Masonry/Masonry.h>

@interface DYMRollingBannerVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate> {
    
    NSTimer         *_timer;
    
    DYMBannerPool   *_bannerPool;
    
    UIPageControl   *_pageControl;
}

/// handler block for banner tapping
@property (nonatomic, copy)     DYMBannderTapHandler    bannerTapHandler;

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
    self.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    
    _bannerPool = [[DYMBannerPool alloc] initWithSize:10];
    
    ///
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = _rollingImageURLs.count;
    _pageControl.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
    
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.and.right.equalTo(self.view);
    }];
    
    /// init first view controller and show it
    DYMBannerVC *vc = [_bannerPool dequeueBannerExclude:self.viewControllers];
    vc.bannerTapHandler = [self tapHandlerForVC];
    vc.imageURL = _rollingImageURLs.firstObject;
    
    [self setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}




#pragma mark - rolling
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
        nextVC.bannerTapHandler = [self tapHandlerForVC];
        nextVC.imageURL = _rollingImageURLs.firstObject;
    }
    
    __weak typeof(self) weakSelf = self;
    [self setViewControllers:@[nextVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf->_pageControl.currentPage = nextVC.index;
        
        
        // The codes below are trying to fix a nasty Bug, which says:
        // Assertion failure in -[DYMRollingBannerVC queuingScrollView:didEndManualScroll:toRevealView:direction:animated:didFinish:didComplete:], /SourceCache/UIKit/UIKit-3347.44.2/UIPageViewController.m:1875
        // No view controller managing visible view
        // http://stackoverflow.com/questions/12939280/uipageviewcontroller-navigates-to-wrong-page-with-scroll-transition-style
        if(finished)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf setViewControllers:@[nextVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];// bug fix for uipageview controller
            });
        }
    }];
}


#pragma mark - banner tapping
-(void)addBannerTapHandler:(DYMBannderTapHandler)handler {
    _bannerTapHandler = handler;
}


#pragma mark - helpers
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

/// if beforeOrAfter == YES, find a vc 'Before' it, otherwise 'After' it
-(DYMBannerVC *)vcNextTo:(UIViewController *)vc beforeOrAfter:(BOOL)beforeOrAfter {
    
    if (![vc isKindOfClass:[DYMBannerVC class]]) {
        //        NSLog(@"vc:%@ invalid, return nil", vc);
        return nil;
    }
    
    DYMBannerVC *nextVC = [_bannerPool dequeueBannerExclude:self.viewControllers];
    nextVC.bannerTapHandler = [self tapHandlerForVC];

    
    NSString *imageURL = ((DYMBannerVC *)vc).imageURL;
    NSInteger index = [_rollingImageURLs indexOfObject:imageURL];
    if (index != NSNotFound) {
        NSInteger nextIndex = [self cycleChangeIndex:index delta:(beforeOrAfter ? -1 : 1) maxIndex:_rollingImageURLs.count - 1];
        //        NSLog(@"current index:%@, next index:%@ \n", @(index), @(nextIndex));
        nextVC.imageURL = _rollingImageURLs[nextIndex];
        nextVC.index = nextIndex;
        
        return nextVC;
    }
    
    //    NSLog(@"imageURL:%@ invalid, return nil", imageURL);
    return nil;
}

-(DYMBannderTapHandler)tapHandlerForVC {
    
    return ^void(NSInteger index) {
        if (_bannerTapHandler) {
            _bannerTapHandler(index);
        }
    };
}


#pragma mark -  UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
//    NSLog(@"viewControllerBeforeViewController");
    return [self vcNextTo:viewController beforeOrAfter:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
//    NSLog(@"viewControllerAfterViewController");
    return [self vcNextTo:viewController beforeOrAfter:NO];
}


#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    DYMBannerVC *vc = pageViewController.viewControllers.firstObject;
    if ([vc isKindOfClass:[DYMBannerVC class]]) {
        _pageControl.currentPage = vc.index;
    }
}

@end
