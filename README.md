# DYMRollingBanner
`DYMRollingBanner` is a clean and easy-to-use banner rolling control for your `homepage` screen.

### Why did I write this shit
Recently, I've been searching for a scrolling banner view on the hub, but no luck... none of them satisfies me, so I decide to write my own.

### Why you should use it   

* It's writen with clean code and very easy to use.    
* Support `AutoLayout` perfectly.    
* It internally implemented a memory reusing mechanism, so it behaves faster and costs less memory.    
* It can roll banners infinitely in a cycle patter, that mean it shows the first banner after the last one. 
* It uses block as the handler to handle image tapping events.
* It's free :-) 

 
### How to use    
Firstly...  
```objective-c
#import "DYMRollingBannerVC.h"
```

Secondly, Create a `DYMRollingBannerVC` object, and install it as the child view controller of your `homepage` view controller.   

Finally, feed it with you image URLs and you are good to go!
```objective-c
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
```

### Notice    
This code is using `Masonry` for Autolayout, and `SDWebImage` for image downloading, so please remember to add these two libraries to your project when integrating `DYMRollingBanner`.    

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests.

## Credits

`DYMRollingBanner` is brought to you by [Yiming Dong](http://www.dongyiming.com). 
