//
//  AdsManager.h
//  BasicFramework
//
//  Created by qf on 2022/2/13.
//  Copyright © 2022 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RewardAd_Type,
    SplashAd_Type,
    BannerAd_Type,
    InterstitialAd_Type,
    FullVideoAd_Type,
    ExpressAd_Type,

} AdTypeEnum;

typedef enum : NSUInteger {
    /**
     * 类型，1-展示，2-点击，3-关闭，4-播完，5-下载，6-安装，7-发放奖励，8-加载失败，9-渲染失败, 10-ecpm
     */
    Display = 1,
    Click   = 2,
    Close   = 3,
    Complete = 4,
    Download = 5,
    Install  = 6,
    Reward   = 7,
    LoadFail = 8,
    RenderFail = 9,
    Revenue    = 10,
} AdEventTypeEnum;

@interface AdsManager : NSObject

+(instancetype)shareAdsManager;


-(void)loadAdType:(AdTypeEnum)adtype parameters:(NSString *)parameters;

-(void)showAdType:(AdTypeEnum)adtype parameters:(NSString *)parameters;


@end

NS_ASSUME_NONNULL_END
