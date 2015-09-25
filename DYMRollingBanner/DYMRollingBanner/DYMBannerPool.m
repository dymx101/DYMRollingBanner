//
//  DYMBannerPool.m
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/25.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import "DYMBannerPool.h"
#import "DYMBannerVC.h"

static const NSInteger  MIN_POOL_SIZE = 5;

@interface DYMBannerPool () {
    NSMutableArray      *_banners;
}
@property(nonatomic, assign) NSInteger      poolSize;

@end

@implementation DYMBannerPool


- (instancetype)init {
    self = [super init];
    if (self) {
        _poolSize = MIN_POOL_SIZE;
        [self doInit];
    }
    return self;
}

-(instancetype)initWithSize:(NSInteger)poolSize {
    self = [super init];
    if (self) {
        _poolSize = MIN(poolSize, MIN_POOL_SIZE);
        [self doInit];
    }
    return self;
}

-(void)doInit {
    
    _banners = [NSMutableArray arrayWithCapacity:_poolSize];
    
    for (NSInteger i = 0; i < _poolSize; i++) {
        DYMBannerVC *vc = [DYMBannerVC new];
        vc.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.98];
        [_banners addObject:vc];
    }
}

-(DYMBannerVC *)dequeueBannerExclude:(NSArray *)visibleVCs {
    
    DYMBannerVC *vc;
    
    for (DYMBannerVC *candidateVC in _banners) {
        if ([visibleVCs indexOfObject:candidateVC] == NSNotFound) {
            vc = candidateVC;
            break;
        }
    }
    
    [_banners removeObject:vc];
    [_banners addObject:vc];
    
    return vc;
}

@end
