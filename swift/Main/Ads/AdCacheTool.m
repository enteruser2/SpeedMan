//
//  AdCacheTool.m
//  BasicFramework
//
//  Created by qf on 2022/2/13.
//  Copyright © 2022 Rainy. All rights reserved.
//

#import "AdCacheTool.h"

@implementation AdCacheTool
static AdCacheTool *adCacheTool = nil;

+(instancetype)shareAdCacheTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adCacheTool = [[AdCacheTool alloc] init];
    });
    return adCacheTool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tmpDic   = [NSMutableDictionary dictionary];
        self.AdsLoadDic = [NSMutableDictionary dictionary];
        self.AdsShowDic = [NSMutableDictionary dictionary];
        self.CloseFeedAds = [NSMutableArray array];
    }
    return self;
}

@end
