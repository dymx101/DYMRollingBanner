//  DYMRollingBanner (http://www.dongyiming.com)
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//
// ***PLEASE IGNORE THE ABOVE COPYRIGHT ANNOUNCEMENT, FEEL FREE TO USE THIS SHIT !!!***



#import "DYMRollingBannerVC.h"
#import "DYMBannerPool.h"

@interface DYMRollingBannerVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate> {
    
    NSTimer         *_timer;
    
    DYMBannerPool   *_bannerPool;
    
    UIPageControl   *_pageControl;
}

/// handler block for banner tapping
@property (nonatomic, copy)     DYMBannderTapHandler    bannerTapHandler;

/// image loading block
@property (nonatomic, copy)     DYMBannerRemoteImageLoadingBlock    remoteImageLoadingBlock;

@end

@implementation DYMRollingBannerVC

-(NSTimeInterval)rollingInterval {
    if (_rollingInterval < 1) {
        _rollingInterval = 1;
    }
    
    return _rollingInterval;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    if (self) {
        [self _doInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _doInit];
    }
    return self;
}

-(void)_doInit {
    
    _infiniteScrollEnabled = YES;
    
    _bannerPool = [[DYMBannerPool alloc] initWithSize:10];
    _pageControl = [[UIPageControl alloc] init];
    [_pageControl addTarget:self action:@selector(pageControlTapped:) forControlEvents:UIControlEventValueChanged];
    
    self.edgeBackgroundColor = [UIColor blackColor];
}

#pragma mark - page control
- (void)pageControlTapped:(UIPageControl *)pageControl {
    NSLog(@"%@", @(pageControl.currentPage));
    /// TODO: Handle the page controll tap event
    DYMBannerVC *currentVC = (DYMBannerVC *)self.viewControllers.firstObject;
    if (pageControl.currentPage != currentVC.index) {
        [self goForward:(pageControl.currentPage > currentVC.index) animated:YES];
    }
}

#pragma mark -
- (void)setEdgeBackgroundColor:(UIColor *)edgeBackgroundColor {
    _edgeBackgroundColor = edgeBackgroundColor;
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[NSClassFromString(@"_UIQueuingScrollView") class]]) {
            view.backgroundColor = _edgeBackgroundColor;
        }
    }
}

-(void)setRollingImages:(NSArray *)rollingImages {
    
    _rollingImages = rollingImages;
    
    _pageControl.hidden = (_rollingImages.count <= 1);
    
    /// set page count
    _pageControl.numberOfPages = _rollingImages.count;
    
    /// init first view controller and show it
    DYMBannerVC *vc = [_bannerPool dequeueBannerExclude:self.viewControllers];
    [self setupBannerVC:vc];
    
    [self setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(void)setupBannerVC:(DYMBannerVC *)bannerVC {
    bannerVC.bannerTapHandler = _bannerTapHandler;
    bannerVC.remoteImageLoadingBlock = _remoteImageLoadingBlock;
    bannerVC.image = _rollingImages.firstObject;
    bannerVC.placeHolder = _placeHolderImage;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    
    [self.view addSubview:_pageControl];
    
    /// Layout PageConstrol
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    id viewsDic = NSDictionaryOfVariableBindings(_pageControl);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_pageControl]|" options:0 metrics:nil views:viewsDic]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pageControl]|" options:0 metrics:nil views:viewsDic]];
    
}




#pragma mark - rolling
-(void)startRolling {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.rollingInterval target:self selector:@selector(doRolling) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)stopRolling {
    [_timer invalidate];
    _timer = nil;
}

-(void)pauseRolling {
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)resumeRolling {
    [_timer setFireDate:[NSDate dateWithTimeInterval:self.rollingInterval sinceDate:[NSDate date]]];
}

-(void)doRolling {
    
    if (_rollingImages.count <= 1) {
        return;
    }
    
    [self goForward:!self.isAutoScrollingBackward animated:YES];
}

- (void)goForward:(BOOL)forward animated:(BOOL)animated {
    DYMBannerVC *currentVC = (DYMBannerVC *)self.viewControllers.firstObject;
    DYMBannerVC *nextVC = [self vcNextTo:currentVC backward:!forward];
    if (nextVC == nil) {
        nextVC = [_bannerPool dequeueBannerExclude:self.viewControllers];
        [self setupBannerVC:nextVC];
    }
    
    UIPageViewControllerNavigationDirection direction = forward ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    
    __weak typeof(self) weakSelf = self;
    [self setViewControllers:@[nextVC] direction:direction animated:animated completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf->_pageControl.currentPage = nextVC.index;
        
        
        // The codes below are trying to fix a nasty Bug, which says:
        // Assertion failure in -[DYMRollingBannerVC queuingScrollView:didEndManualScroll:toRevealView:direction:animated:didFinish:didComplete:], /SourceCache/UIKit/UIKit-3347.44.2/UIPageViewController.m:1875
        // No view controller managing visible view
        // http://stackoverflow.com/questions/12939280/uipageviewcontroller-navigates-to-wrong-page-with-scroll-transition-style
        if(finished)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf setViewControllers:@[nextVC] direction:direction animated:NO completion:NULL];// bug fix for uipageview controller
            });
        }
    }];
}


#pragma mark - banner tapping
-(void)addBannerTapHandler:(DYMBannderTapHandler)handler {
    _bannerTapHandler = handler;
}

-(void)setRemoteImageLoadingBlock:(DYMBannerRemoteImageLoadingBlock)loadingBlock {
    _remoteImageLoadingBlock = loadingBlock;
}


#pragma mark - helpers
-(NSInteger)cycleChangeIndex:(NSInteger)index delta:(NSInteger)delta maxIndex:(NSInteger)maxIndex {
    
    index += delta;
    
    if (index < 0) {
        index = maxIndex;
    } else if (index > maxIndex) {
        index = 0;
    }
    
    return index;
}

/// if beforeOrAfter == YES, find a vc 'Before' it, otherwise 'After' it
-(DYMBannerVC *)vcNextTo:(UIViewController *)vc backward:(BOOL)backward {
    
    if (![vc isKindOfClass:[DYMBannerVC class]]) {
        return nil;
    }
    
    DYMBannerVC *nextVC = [_bannerPool dequeueBannerExclude:self.viewControllers];
    [self setupBannerVC:nextVC];

    
    NSString *imageURL = ((DYMBannerVC *)vc).image;
    NSInteger index = [_rollingImages indexOfObject:imageURL];
    if (index != NSNotFound) {
        
        NSInteger maxIndex = _rollingImages.count - 1;
        
        if (!_infiniteScrollEnabled) {
            if ((index <= 0 && backward)
                || (index >= maxIndex && !backward)) {
                return nil;
            }
        }
        
        NSInteger nextIndex = [self cycleChangeIndex:index delta:(backward ? -1 : 1) maxIndex:maxIndex];
        
        nextVC.image = _rollingImages[nextIndex];
        nextVC.index = nextIndex;
        
        return nextVC;
    }
    
    return nil;
}

//-(DYMBannderTapHandler)tapHandlerForVC {
//    
//    return ^void(NSInteger index) {
//        if (_bannerTapHandler) {
//            _bannerTapHandler(index);
//        }
//    };
//}


#pragma mark -  UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {

    if (_rollingImages.count <= 1) {
        return nil;
    }
    
    return [self vcNextTo:viewController backward:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {

    if (_rollingImages.count <= 1) {
        return nil;
    }
    
    return [self vcNextTo:viewController backward:NO];
}


#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
//      NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [self pauseRolling];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
//      NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [self resumeRolling];
    
    DYMBannerVC *vc = pageViewController.viewControllers.firstObject;
    if ([vc isKindOfClass:[DYMBannerVC class]]) {
        _pageControl.currentPage = vc.index;
    }
}

@end
