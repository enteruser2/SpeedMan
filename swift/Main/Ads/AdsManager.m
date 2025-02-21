//
//  AdsManager.m
//  BasicFramework
//
//  Created by qf on 2022/2/13.
//  Copyright © 2022 Rainy. All rights reserved.
//

#import "AdsManager.h"
#import "BaseAdsClass.h"
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

@implementation AdsManager

static AdsManager *adsManager = nil;

+(instancetype)shareAdsManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adsManager = [[AdsManager alloc] init];
    });
    return adsManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)loadAdType:(AdTypeEnum)adtype parameters:(NSString *)parameters
{
    NSLog(@"loadadType:%ld---parameters:%@",adtype,parameters);
    NSString * type = @"";
    switch (adtype) {
        case RewardAd_Type:
            type = Reward_Type;
            break;
        case FullVideoAd_Type:
            type = FullScreenVideo_Type;
            break;
            
        default:
            NSLog(@"广告类型传递错误");
            break;
    }
    
    [BaseAdsClass FactoryWithAdPlatfrom:Base_Platfrom
                                andType:type
                              andIsShow:NO
                           andParameter:parameters
                                  andVC:[self getCurrentVC]];
}

- (void)showAdType:(AdTypeEnum)adtype parameters:(NSString *)parameters
{
    NSLog(@"showadType:%ld---parameters:%@",adtype,parameters);
    NSString * type = @"";
    switch (adtype) {
        case RewardAd_Type:
            type = Reward_Type;
            break;
        case FullVideoAd_Type:
            type = FullScreenVideo_Type;
            break;
        default:
            NSLog(@"广告类型传递错误");
            break;
    }
    
    [BaseAdsClass FactoryWithAdPlatfrom:Base_Platfrom
                                andType:type
                              andIsShow:YES
                           andParameter:parameters
                                  andVC:[self getCurrentVC]];
}


-(UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

-(UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]])
    {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]])
    {
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }
    else
    {
        currentVC = rootVC;
    }
    return currentVC;
}

@end
