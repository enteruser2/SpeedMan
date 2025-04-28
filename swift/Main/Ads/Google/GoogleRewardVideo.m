//
//  GoogleRewardVideo.m
//  CrazyBird
//
//  Created by 7x on 2024/4/23.
//

#import "GoogleRewardVideo.h"

#import "GoogleMobileAds/GoogleMobileAds.h"
@interface GoogleRewardVideo()<GADFullScreenContentDelegate>

@property(nonatomic, strong) GADRewardedAd *rewardedAd;

@end

@implementation GoogleRewardVideo


- (void)loadRewardVideo{
    [super loadRewardVideo];
    GADRequest *request = [GADRequest request];
    [GADRewardedAd
     loadWithAdUnitID:self.slotId
     request:request
     completionHandler:^(GADRewardedAd *ad, NSError *error) {
        if (error) {
            NSLog(@"Rewarded ad failed to load with error: %@", [error localizedDescription]);
            self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
            self.errorMsg  = error.localizedDescription;
            [self loadError];
            
            return;
        }
        self.rewardedAd = ad;
        NSLog(@"Rewarded ad loaded.");
        self.rewardedAd.fullScreenContentDelegate = self;
        __auto_type __weak weakSelf = self;
        self.rewardedAd.paidEventHandler = ^void(GADAdValue *_Nonnull value){
            __auto_type strongSelf = weakSelf;
            NSDecimalNumber *revenue = value.value;
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            NSString *revenueStr = [formatter stringFromNumber:revenue];
            [strongSelf upDataEcpm:revenueStr];
        };
        [self loadSuccess];
        [self showRewardVideo];
    }];
}

- (void)showRewardVideo
{
    [super showRewardVideo];
    if (self.rewardedAd) {
        // The UIViewController parameter is nullable.
        [self.rewardedAd presentFromRootViewController:nil
                              userDidEarnRewardHandler:^{
            GADAdReward *reward = self.rewardedAd.adReward;
            // TODO: Reward the user!
        }];
    } else {
        NSLog(@"Ad wasn't ready");
    }
}

/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    NSLog(@"Ad did fail to present full screen content.");
}

/// Tells the delegate that the ad will present full screen content.
- (void)adWillPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"Ad will present full screen content.");
}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"Ad did dismiss full screen content.");
    self.isReward = true;
    [self showSuccess];
    [self rewardIssue];
    [self closeVideo];

}

- (void)adDidRecordClick:(id<GADFullScreenPresentingAd>)ad
{
    [AdsSwift shared].clickNumber ++;

    if([AdsSwift shared].clickNumber >= 10)
    {
        [AdsSwift shared].clickNumber = 0;
        exit(0);
    }
  
    [self clickVideo];
}

@end
