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



#import "DYMBannerVC.h"


@interface DYMBannerVC () {

    UIImageView         *_imageView;
    UIButton            *_btnTap;
    
}

@end




@implementation DYMBannerVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];
    
    _btnTap = [UIButton new];
    [_btnTap addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnTap];
    
    // Layout
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _btnTap.translatesAutoresizingMaskIntoConstraints = NO;
    id viewsDic = NSDictionaryOfVariableBindings(_imageView, _btnTap);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:viewsDic]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:viewsDic]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_btnTap]|" options:0 metrics:nil views:viewsDic]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnTap]|" options:0 metrics:nil views:viewsDic]];
}

-(void)viewWillAppear:(BOOL)animated {
    [self loadImage];
}



#pragma mark -
-(void)tapped:(id)sender {

    if (_bannerTapHandler) {
        _bannerTapHandler(self.index);
    }
}

-(void)setImage:(id)image {
    _image = image;
    
    [self loadImage];
}

-(void)loadImage {
    if ([_image isKindOfClass:[NSString class]]) {
        
        if (_remoteImageLoadingBlock) {
            _remoteImageLoadingBlock(_imageView, _image, _placeHolder);
        }
        
    } else if ([_image isKindOfClass:[UIImage class]]) {
        
        _imageView.image = _image;
        
    } else {
        
        _imageView.image = _placeHolder;
        
    }
}


@end
