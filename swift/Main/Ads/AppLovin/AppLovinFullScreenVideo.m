//
//  AppLovinFullScreenVideo.m
//  CrazyBird
//
//  Created by 7x on 2024/4/22.
//

#import "AppLovinFullScreenVideo.h"
#import <AppLovinSDK/AppLovinSDK.h>
@interface AppLovinFullScreenVideo()<MAAdDelegate,MAAdRevenueDelegate>
@property (nonatomic, strong) MAInterstitialAd *interstitialAd;
@property (nonatomic, assign) NSInteger retryAttempt;
@end

@implementation AppLovinFullScreenVideo

-(void)loadFullScreenVideo
{
    [super loadFullScreenVideo];
    self.interstitialAd = [[MAInterstitialAd alloc] initWithAdUnitIdentifier: self.slotId];
    self.interstitialAd.delegate = self;
    self.interstitialAd.revenueDelegate = self;
    // Load the first ad
    [self.interstitialAd loadAd];
}

- (void)showFullScreenVideo
{
    [super showFullScreenVideo];
    if ( [self.interstitialAd isReady] )
    {
        NSDictionary * dic = @{@"sid":self.sId};
        [self.interstitialAd showAdForPlacement:self.postionADSceneType customData:[dic DictionaryConversionStringOfJson]];
    }
}



#pragma mark - MAAdDelegate Protocol

- (void)didLoadAd:(MAAd *)ad
{
    NSLog(@"视频已经加载");
    [self loadSuccess];
    [self showFullScreenVideo];
}

- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withError:(MAError *)error
{
    NSLog(@"视频加载失败");
    self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
    self.errorMsg  = error.message;
    [self loadError];
}

- (void)didDisplayAd:(MAAd *)ad
{
    // Pause your app's background audio
}

- (void)didClickAd:(MAAd *)ad {
    NSLog(@"点击视频");
    [self clickVideo];
}

- (void)didHideAd:(MAAd *)ad
{
    NSLog(@"隐藏视频");
    [self closeVideo];
    [self showSuccess];
}

- (void)didFailToDisplayAd:(MAAd *)ad withError:(MAError *)error
{
    NSLog(@"视频播放失败");
    self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
    self.errorMsg  = error.message;
    [self showError];
}

- (void)didPayRevenueForAd:(nonnull MAAd *)ad { 
    NSString * revenue =  [NSString stringWithFormat:@"%lf",ad.revenue];
    [self upDataEcpm:revenue];
}

@end

