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

@interface DYMBannerVC ()

@property (nonatomic, strong)         UIImageView             *imageView;

@end

@implementation DYMBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.9];
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [self loadImage];
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
