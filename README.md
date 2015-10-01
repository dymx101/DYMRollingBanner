# DYMRollingBanner
`DYMRollingBanner` is a clean and easy-to-use banner rolling control for your app's `homepage` screen which need to show some rolling banners.    

![DEMO Gif](http://cdn.cocimg.com/bbs/attachment/Fid_19/19_88471_6119c1d8323275c.gif)

## Why
Why do I write this ? Well...actually, I've been searching for a scrolling banner view at github for a while, but no luck since some of the code I found are too old to support `Autolayout`, others don't scrolls infinitely... none of them satisfied me. Then,  I decided to do it myself, to write a good one...and here you go...

## Features  
* Infinite scrolling, which mean it  return to show the first banner when ended with the last one.     
* Supports both local and remote images.    
* Paused on dragging and resumes on releasing when it's auto rolling.    
* Implemented a memory cache which makes it lightning fast and less memory consuming.     
* Block based event handling.    
* 100% compatible with `AutoLayout`.  
* Writen with clean code and very easy to use. 

## Installation 

### (from CocoaPods)

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like `DYMRollingBanner` in your projects. Simply add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'DYMRollingBanner', '~> 2.1.3'
```
### (direct installation)
Just copy these source files into you project:
* `DYMRollingBannerVC.h`    
* `DYMRollingBannerVC.m`    
* `DYMBannerVC.h`    
* `DYMBannerVC.m`    
* `DYMBannerPool.h`    
* `DYMBannerPool.m`   

 
## Usage     

Unlike many other banner scrolling controls, `DYMRollingBanner` doesn't use `UIScrollingView` or its subclasses `UITableview` or `UICollectionView`, instead it take full advantage of `UIPageViewController` which is natually an `INFINITE` controller.    
    
To integrate `DYMRollingBanner`, firstly, you need to copy the assciated files into your project, and import `DYMRollingBannerVC.h` file:    
```objective-c
#import <DYMRollingBanner/DYMRollingBannerVC.h>
```

Secondly, Create a `DYMRollingBannerVC` object.       
```objective-c
DYMRollingBannerVC      *_rollingBannerVC;

_rollingBannerVC = [DYMRollingBannerVC new];
```

Then, add the `DYMRollingBannerVC` object as the child view controller of the host controller.    
```objective-c
[self addChildViewController:_rollingBannerVC];
[self.view addSubview:_rollingBannerVC.view];
    
    // The code below lays out the _rollingBannerVC's view using Masonry
    [_rollingBannerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.and.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
 [_rollingBannerVC didMoveToParentViewController:self];
 ```

Finally, feed it with you image URLs or `UIImage` object:       
```objective-c
_rollingBannerVC.rollingInterval = 5;
_rollingBannerVC.rollingImages = @[@"http://www.drpsychmom.com/wp-content/uploads/2014/10/large_4278047231.jpg"
                                , @"https://c2.staticflickr.com/4/3345/5832660048_55f8b0935b.jpg"
                                , @"http://epaper.syd.com.cn/sywb/res/1/20080108/42241199752656275.jpg"
                                , [UIImage imageNamed:@"001"]    // Local Image
                                , [UIImage imageNamed:@"002"]    // Locak Image
                                ];
        
  [_rollingBannerVC addBannerTapHandler:^(NSInteger whichIndex) {
        NSLog(@"banner tapped, index = %@", @(whichIndex));
  }];
        
  [_rollingBannerVC startRolling];
```
And you are good to go!  

## Associated Classes   
* `DYMRollingBannerVC` is the view controller which rolls a group of banner images.   
* `DYMBannerVC` is the host view controller of each image, it's internally used by the `DYMRollingBannerVC`.    
* `DYMBannerPool` is the memory pool from which you dequeue a banner from, it's internally used by the `DYMRollingBannerVC`.    

## Notice    
`DYMRollingBanner` uses `SDWebImage` for image downloading, so if you install `DYMRollingBanner` using cocopods, this library will be installed too, but if you prefer to manually copy the source files into your project, make sure also to include `SDWebImage`. 

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests, or contact dymx101@hotmail.com.

## Credits

`DYMRollingBanner` is brought to you by [Yiming Dong](http://www.dongyiming.com). 


![Logo](http://cdn.cocimg.com/bbs/attachment/Fid_19/19_88471_d255b06e7b21a91.png)
