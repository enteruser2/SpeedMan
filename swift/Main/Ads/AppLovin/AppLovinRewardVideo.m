//
//  AppLovinRewardVideo.m
//  CrazyBird
//
//  Created by 7x on 2024/4/22.
//

#import "AppLovinRewardVideo.h"
#import <AppLovinSDK/AppLovinSDK.h>
@interface AppLovinRewardVideo()<MARewardedAdDelegate>

@property (nonatomic, strong) MARewardedAd *rewardedAd;
@property (nonatomic, assign) NSInteger retryAttempt;

@end

@implementation AppLovinRewardVideo

#pragma mark - View Lifecycle

-(void)loadRewardVideo
{
    [super loadRewardVideo];
    // userID 上报
    ALSdk * al = [ALSdk shared];
    self.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier:self.slotId sdk:al];
    self.rewardedAd.delegate = self;
    // Load the first ad
    [self.rewardedAd loadAd];
}

- (void)showRewardVideo
{
    [super showRewardVideo];
    if ( [self.rewardedAd isReady] )
    {
        [self.rewardedAd showAd];
    }
}



- (void)didClickAd:(nonnull MAAd *)ad {
    NSLog(@"点击视频");
    [self clickVideo];
}

- (void)didDisplayAd:(nonnull MAAd *)ad {
    // Pause your app's background audio
}

- (void)didFailToDisplayAd:(nonnull MAAd *)ad withError:(nonnull MAError *)error {
    NSLog(@"视频播放失败");
    self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
    self.errorMsg  = error.message;
    [self showError];
}

- (void)didFailToLoadAdForAdUnitIdentifier:(nonnull NSString *)adUnitIdentifier withError:(nonnull MAError *)error {
    NSLog(@"视频加载失败");
    self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
    self.errorMsg  = error.message;
    [self loadError];
}

- (void)didHideAd:(nonnull MAAd *)ad {
    NSLog(@"隐藏视频");
    [self showSuccess];
    [self closeVideo];
}

- (void)didLoadAd:(nonnull MAAd *)ad {
    NSLog(@"视频已经加载");
    [self loadSuccess];
    [self showRewardVideo];
}



- (void)didRewardUserForAd:(nonnull MAAd *)ad withReward:(nonnull MAReward *)reward {
    NSLog(@"可以给用户发放奖励");
    [self rewardIssue];
}

@end

