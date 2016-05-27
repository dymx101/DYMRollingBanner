# DYMRollingBanner
`DYMRollingBanner` is a clean and easy-to-use banner rolling control for your app's `homepage` screen which need to show some rolling banners.    

![DEMO Gif](http://cdn.cocimg.com/bbs/attachment/Fid_19/19_88471_6119c1d8323275c.gif)

## Why
Why do I write this ? Well...actually, I've been searching for a scrolling banner view at github for a while, but no luck since some of the code I found are too old to support `Autolayout`, others don't scrolls infinitely... none of them satisfied me. Then,  I decided to do it myself, to write a good one...and here you go...

## Features  
* Infinite scrolling, which mean it shows banners/images in a infinite loop.
* Can scroll automatically, the intervals and the direction of the scrolling is configurable.
* Supports both local and remote images.
* Placeholder image is customizable, Remote image fetch method is also cusomizable.  
* Paused on dragging and resumes on releasing when it's auto rolling.    
* Have a memory cache which makes it lightning fast and less memory consuming.     
* Block based event handling.    
* 100% compatible with `AutoLayout`.  
* Writen with clean code and very easy to use.     

## Installation 

### (from CocoaPods)

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like `DYMRollingBanner` in your projects. Simply add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'DYMRollingBanner', '~> 2.1.7'
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
        // setup the rolling images
        _rollingBannerVC.rollingImages = @[@"http://easyread.ph.126.net/G8GtEi-zmPQzvS5w7ScxmQ==/7806606224489671909.jpg"
                             , @"https://c2.staticflickr.com/4/3345/5832660048_55f8b0935b.jpg"
                             , @"http://epaper.syd.com.cn/sywb/res/1/20080108/42241199752656275.jpg"
                             , [UIImage imageNamed:@"001"]
                             , [UIImage imageNamed:@"002"]
                             ];
                             
        // Start auto rolling (optional, default does not auto roll)
        [_rollingBannerVC startRolling];
```
And you are good to go!  

You can also do many customizations to it (they are optional):       
```objective-c
        // Set the inteval for rolling (optional, the default value is 1 sec)
        _rollingBannerVC.rollingInterval = 5;
        
        // Set the placeholder image (optional, the default place holder is nil)
        _rollingBannerVC.placeHolderImage = [UIImage imageNamed:@"default"];
        
        // Define the way how you load the image from a remote url
        [_rollingBannerVC setRemoteImageLoadingBlock:^(UIImageView *imageView, NSString *imageUrlStr, UIImage *placeHolderImage) {
            [imageView sd_cancelCurrentImageLoad];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:placeHolderImage options:SDWebImageProgressiveDownload];
        }];
        
        // Add a handler when a tap event occours (optional, default do noting)
        [_rollingBannerVC addBannerTapHandler:^(NSInteger whichIndex) {
            NSLog(@"banner tapped, index = %@", @(whichIndex));
        }];
        
        // If 'YES', the auto scrolling will scroll to the right
        vc.isAutoScrollingBackward = YES;
```

## Associated Classes   
* `DYMRollingBannerVC` is the view controller which rolls a group of banner images.   
* `DYMBannerVC` is the host view controller of each image, it's internally used by the `DYMRollingBannerVC`.    
* `DYMBannerPool` is the memory pool from which you dequeue a banner from, it's internally used by the `DYMRollingBannerVC`.    

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests, or contact dymx101@hotmail.com.

## Credits

`DYMRollingBanner` is brought to you by [Yiming Dong](http://www.dongyiming.com).     
Follow me or ask questions or just say Hi! at Twitter : <a href="https://twitter.com/dymx101" target="_blank">@dymx101</a>    


![Logo](http://cdn.cocimg.com/bbs/attachment/Fid_19/19_88471_d255b06e7b21a91.png)
