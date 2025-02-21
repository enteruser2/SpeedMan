//
//  AdCacheTool.h
//  BasicFramework
//
//  Created by qf on 2022/2/13.
//  Copyright © 2022 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface AdCacheTool : NSObject

@property (nonatomic, strong) NSMutableDictionary * tmpDic;
@property (nonatomic, strong) NSMutableArray * CloseFeedAds;//关闭信息流广告出现不同步处理
@property (nonatomic, strong) NSMutableDictionary * AdsLoadDic;//广告预加载缓存池
@property (nonatomic, strong) NSMutableDictionary * AdsShowDic;//广告展示缓存池

+(instancetype)shareAdCacheTool;

@end

NS_ASSUME_NONNULL_END
