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


#import <UIKit/UIKit.h>
#import "DYMBannerVC.h"

/// The view controller which rolls a group of banner images
@interface DYMRollingBannerVC : UIPageViewController

/// Images for the rolling banner, can be a remote URL or UIImage
@property (nonatomic, copy)                     NSArray                 *rollingImages;

/// Time interval between the rolling
@property (nonatomic, assign)                   NSTimeInterval          rollingInterval;

/// The placeHolder image
@property (nonatomic, copy)                     UIImage                 *placeHolderImage;

/// Enable/disable infinite scrolling
@property (nonatomic, assign)                   BOOL                    infiniteScrollEnabled;

/// If 'YES', the auto scrolling will scroll to the right, otherwise to the left; the default value is 'NO'
@property (nonatomic, assign)                   BOOL                    isAutoScrollingBackward;

/// Background color when it reveals the scrollview edge, default value is black
@property (nonatomic, strong)                   UIColor                  *edgeBackgroundColor;

/// Start rolling
-(void)startRolling;

/// Stop rolling
-(void)stopRolling;

/// Handler for banner tap event
-(void)addBannerTapHandler:(DYMBannderTapHandler)handler;

/// Handler for banner tap event
-(void)setRemoteImageLoadingBlock:(DYMBannerRemoteImageLoadingBlock)loadingBlock;

@end

