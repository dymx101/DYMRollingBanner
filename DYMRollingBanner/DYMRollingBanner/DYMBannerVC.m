//
//  DYMBannerVC.m
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/24.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import "DYMBannerVC.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

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
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    ///
    _btnTap = [UIButton new];
    [_btnTap addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnTap];
    [_btnTap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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

-(void)setImageURL:(NSString *)imageURL {
    
    if (![_imageURL isEqualToString:imageURL]) {
//        NSLog(@"----------\nBanner cancel loading: %@\nStart loading: %@\n", _imageURL, imageURL);
        _imageURL = imageURL;
        
    } else {
//        NSLog(@"------\nShowing the same image");
    }
}

-(void)loadImage {
    [_imageView sd_cancelCurrentImageLoad];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageURL]
                  placeholderImage:_placeHolder options:SDWebImageProgressiveDownload];
}




@end
