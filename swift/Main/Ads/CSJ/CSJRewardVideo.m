//
//  CSJRewardVideo.m
//  BasicFramework
//
//  Created by 7x on 2022/3/11.
//  Copyright © 2022 Rainy. All rights reserved.
//

#import "CSJRewardVideo.h"
#import <PAGAdSDK/PAGAdSDK.h>
@interface CSJRewardVideo()<PAGRewardedAdDelegate>

@property (nonatomic, strong) PAGRewardedAd *rewardedAd;

@property (nonatomic, assign) BOOL isLoad;

@end

@implementation CSJRewardVideo


- (void)loadRewardVideo
{
    [super loadRewardVideo];
    PAGRewardedRequest *request = [PAGRewardedRequest request];
    [PAGRewardedAd loadAdWithSlotID:self.slotId request:request completionHandler:^(PAGRewardedAd * _Nullable rewardedAd, NSError * _Nullable error) {
        if (error) {
            NSLog(@"reward ad load fail : %@",error);
            if (error) {
                self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
                self.errorMsg  = error.localizedDescription;
                [self loadError];
            }
            return;
        }
        self.rewardedAd = rewardedAd;
        self.rewardedAd.delegate = self;
        [self loadSuccess];
    }];
}

- (void)showRewardVideo
{
    if (self.rewardedAd) {
       [self.rewardedAd presentFromRootViewController:self.vc];
    }
}


- (void)adDidShow:(PAGRewardedAd *)ad {
    NSLog(@"ad show");
    [self showSuccess];
}

- (void)adDidClick:(PAGRewardedAd *)ad {
    NSLog(@"ad click");
    [self clickVideo];
}

- (void)adDidDismiss:(PAGRewardedAd *)ad {
    NSLog(@"ad dismiss");
    [self closeVideo];
}

- (void)rewardedAd:(PAGRewardedAd *)rewardedAd userDidEarnReward:(PAGRewardModel *)rewardModel {
    NSLog(@"reward earned! rewardName:%@ rewardMount:%ld",rewardModel.rewardName,(long)rewardModel.rewardAmount);
}

- (void)rewardedAd:(PAGRewardedAd *)rewardedAd userEarnRewardFailWithError:(NSError *)error {
    NSLog(@"reward earned failed. Error:%@",error);
    
        if (error) {
            self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
            self.errorMsg  = error.localizedDescription;
            [self showError];
        }
        else
        {
            [self rewardIssue];
        }
}



@end
