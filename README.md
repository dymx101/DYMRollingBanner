# DYMRollingBanner
`DYMRollingBanner` is a clean and easy-to-use banner rolling control for your app's `homepage` screen which need to show some rolling banners.    

![DEMO Gif](http://cdn.cocimg.com/bbs/attachment/Fid_19/19_88471_6119c1d8323275c.gif)

### Why
Why do I write this ? Well...Actually, I've been searching for a scrolling banner view at github for a while, but no luck since some of the code I found are too old to support `Autolayout`, others don't scrolls infinitely... none of them satisfied me. Then,  I decided to do it myself, to write something cool...and finally,  here you go!

### Features  

* Writen with clean code and very easy to use.    
* Supports both local and remote images.    
* Paused on dragging and resumes on releasing.    
* Implements a memory cache which makes it lightning fast and less memory consuming.     
* Infinite scrolling, which mean it  return to show the first banner when ended with the last one.     
* Block based event handling.    
* 100% compatible with `AutoLayout`.      

 
### Usage     

Unlike many other banner scrolling controls, `DYMRollingBanner` doesn't use `UIScrollingView` or its subclasses `UITableview` or `UICollectionView`, instead it take full advantage of `UIPageViewController` which is natually an `INFINITE` controller.    
    
To integrate `DYMRollingBanner', firstly, you need to copy the assciated files into your project, and import `DYMRollingBannerVC.h` file:    
```objective-c
#import "DYMRollingBannerVC.h"
```

Secondly, Create a `DYMRollingBannerVC` object, and install it as a child view controller.    

Finally, feed it with you image URLs or `UIImage` object and you are good to go!    
```objective-c
DYMRollingBannerVC *vc = [[DYMRollingBannerVC alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

vc.rollingInterval = 5;
vc.rollingImages = @[@"http://www.drpsychmom.com/wp-content/uploads/2014/10/large_4278047231.jpg"
                                , @"https://c2.staticflickr.com/4/3345/5832660048_55f8b0935b.jpg"
                                , @"http://epaper.syd.com.cn/sywb/res/1/20080108/42241199752656275.jpg"
                                , [UIImage imageNamed:@"001"]    // Local Image
                                , [UIImage imageNamed:@"002"]    // Locak Image
                                ];
        
  [vc addBannerTapHandler:^(NSInteger whichIndex) {
        NSLog(@"banner tapped, index = %@", @(whichIndex));
  }];
        
  [vc startRolling];
```

### Notice    
This code is using `Masonry` for Autolayout, and `SDWebImage` for image downloading, so please remember to add these two libraries to your project when integrating `DYMRollingBanner`.    

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests.

## Credits

`DYMRollingBanner` is brought to you by [Yiming Dong](http://www.dongyiming.com). 


![Logo](http://cdn.cocimg.com/bbs/attachment/Fid_19/19_88471_d255b06e7b21a91.png)
