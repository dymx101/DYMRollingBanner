# DYMRollingBanner
`DYMRollingBanner` is a clean and easy-to-use banner rolling control for your `homepage` screen.    

![DEMO Gif](http://cdn.cocimg.com/bbs/attachment/Fid_19/19_88471_6119c1d8323275c.gif)

### Why do I write it ?
Recently, I've been searching for a scrolling banner view on the hub, but no luck...Some of the code I found are too old, they don't support Autolayout, and some don't scrolls infinitely... none of them satisfies me. So,  I finally decided to write a brand new control for this usage...and here you go!

### Why you should use it   

* It's writen with clean code and very easy to use.  
* It supports both local and remote images.    
* Auto Rolling will be paused when dragging, and resumed when dragging ended.    
* Internally it has memory cache which makes it lightning fast and less memory consuming.    
* It rolls banners infinitely in a cycle patter, that mean it shows the first banner after the last one. 
* It uses block as the handler to handle image tapping events.    
* Support `AutoLayout` perfectly.  
* It's free :-) 

 
### How to use    
Firstly...  
```objective-c
#import "DYMRollingBannerVC.h"
```

Secondly, Create a `DYMRollingBannerVC` object, and install it as the child view controller of your `homepage` view controller.   

Finally, feed it with you image URLs and you are good to go!
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
