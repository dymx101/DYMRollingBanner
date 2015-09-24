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
    
    self.imageURL = _imageURL;
}

-(void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:nil options:SDWebImageProgressiveDownload];
}


#pragma mark - touches
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    NSLog(@"touchesBegan");
//    
//    if (_touchBlock) {
//        _touchBlock(touches, event, kDYMTouchStageBegan);
//    }
//    
//    [super touchesBegan:touches withEvent:event];
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    NSLog(@"touchesEnded");
//    
//    if (_touchBlock) {
//        _touchBlock(touches, event, kDYMTouchStageEnded);
//    }
//    
//    [super touchesEnded:touches withEvent:event];
//}
//
//-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    NSLog(@"touchesCancelled");
//    
//    if (_touchBlock) {
//        _touchBlock(touches, event, kDYMTouchStageCancelled);
//    }
//    
//    [super touchesCancelled:touches withEvent:event];
//}

@end
