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


typedef void(^DYMBannderTapHandler)(NSInteger whichIndex);

typedef void(^DYMBannerRemoteImageLoadingBlock)(UIImageView *imageView, NSString *imageUrlStr, UIImage *placeHolderImage);


/// Banner view controller to show a banner image
@interface DYMBannerVC : UIViewController

/// PlaceHolder for the banner image
@property (nonatomic, strong)                   UIImage                 *placeHolder;

/// Image for the banner, can be a URL or UIImage
@property (nonatomic, copy)                     id                      image;

/// Temporarily save the current index of the banner
@property (nonatomic, assign)                   NSInteger               index;

/// Handler block for banner tapping
@property (nonatomic, copy)                     DYMBannderTapHandler    bannerTapHandler;

/// Reomte image loading block
@property (nonatomic, copy)                     DYMBannerRemoteImageLoadingBlock    remoteImageLoadingBlock;

@end
