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
