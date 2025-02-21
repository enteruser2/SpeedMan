//
//  CSJleInterstitialAD.m
//  BasicFramework
//
//  Created by 7x on 2022/3/12.
//  Copyright © 2022 Rainy. All rights reserved.
//

#import "CSJFullScreenVideo.h"
#import <PAGAdSDK/PAGAdSDK.h>

@interface CSJFullScreenVideo()<PAGLInterstitialAdDelegate>
@property (nonatomic, strong) PAGLInterstitialAd * interstitialAd;

@end

@implementation CSJFullScreenVideo

- (void)loadFullScreenVideo
{
    [super loadFullScreenVideo];
    
    PAGInterstitialRequest * request = [PAGInterstitialRequest request];
    [PAGLInterstitialAd loadAdWithSlotID:self.slotId request:request completionHandler:^(PAGLInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
        if (error) {
            NSLog(@"interstitial ad load fail : %@",error);
            self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
            self.errorMsg  = error.localizedDescription;
            [self loadError];
        }
        else
        {
            self.interstitialAd = interstitialAd;
            [self showFullScreenVideo];
        }
    }];
    
}

- (void)showFullScreenVideo
{
    [super showFullScreenVideo];
    self.interstitialAd.delegate = self;
    if (self.interstitialAd) {
        [self.interstitialAd presentFromRootViewController:self.vc];
    }
}
/// This method is called when the ad has been shown
- (void)adDidShow:(id<PAGAdProtocol>)ad
{
    NSLog(@"%s:adDidShow",__func__);
}

/// This method is called when the add has been clicked
- (void)adDidClick:(id<PAGAdProtocol>)ad
{
    NSLog(@"%s:adDidClick",__func__);
    [self clickVideo];
}

///This method is called when the ad has been dismissed.
- (void)adDidDismiss:(id<PAGAdProtocol>)ad
{
    NSLog(@"%s:adDidDismiss",__func__);
    [self showSuccess];
}

///This method is called when the ad has been show fail
- (void)adDidShowFail:(id<PAGAdProtocol>)ad error:(NSError *)error
{
    NSLog(@"%s:adDidShowFail %@",__func__,error);
    if (error) {
        self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
        self.errorMsg  = error.localizedDescription;
        [self showError];
    }
}


//#pragma mark BURewardedVideoAdDelegate
//- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
//    NSLog(@"%s:当视频广告材料加载成功时，会调用此方法。",__func__);
//    [self loadSuccess];
//    [self showInterstitial];
//}
//
//- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
//    NSLog(@"%s:当视频缓存成功时，将调用此方法。",__func__);
//}
//
//- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
//    NSLog(@"%s:当视频广告材料加载失败时，会调用此方法。%@",__func__,error);
//    [self loadError];
//}
//
//- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
//    NSLog(@"%s:当用户单击跳过按钮时，将调用此方法。",__func__);
//}
//
//- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd {
//    NSLog(@"%s:单击视频广告时调用此方法。",__func__);
//}
//
//- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
//    NSLog(@"%s:当视频广告关闭时，会调用此方法。",__func__);
//}
//
//- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error{
//    NSLog(@"%s:当视频广告播放完成或发生错误时，将调用此方法。%@",__func__,error);
//    if (error) {
//        [self showError];
//    }
//    else
//    {
//        [self showSuccess];
//    }
//}
//
//- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
//    NSLog(@"%s:当视频广告插槽显示时，将调用此方法。",__func__);
//}
//
//- (void)fullscreenVideoAdDidVisible:(BUFullscreenVideoAd *)fullscreenVideoAd{
//    NSLog(@"%s:当视频广告插槽显示时，将调用此方法。",__func__);
//}
//
//- (void)fullscreenVideoAdWillClose:(BUFullscreenVideoAd *)fullscreenVideoAd{
//    NSLog(@"%s:当视频广告即将关闭时，会调用此方法。",__func__);
//}
//
//- (void)fullscreenVideoAdCallback:(BUFullscreenVideoAd *)fullscreenVideoAd withType:(BUFullScreenVideoAdType)fullscreenVideoAdType{
//    NSLog(@"%s:这种方法用于获取全屏视频广告的类型。",__func__);
//}



@end
