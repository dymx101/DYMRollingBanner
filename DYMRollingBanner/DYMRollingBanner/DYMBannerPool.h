//
//  DYMBannerPool.h
//  DYMRollingBanner
//
//  Created by Dong Yiming on 15/9/25.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DYMBannerVC;

/// The memory pool from which you dequeue a banner from
@interface DYMBannerPool : NSObject
/// Initialize the pool with a size, the default & minimal size is 5
-(instancetype)initWithSize:(NSInteger)poolSize;
/// dequeue a banner for use, excluding banners which are current showing
-(DYMBannerVC *)dequeueBannerExclude:(NSArray *)visibleVCs;

@end
