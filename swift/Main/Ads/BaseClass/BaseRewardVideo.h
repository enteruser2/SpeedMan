//
//  BaseRewardVideo.h
//  TestAA-mobile
//
//  Created by qf on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import "BaseAdsClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseRewardVideo : BaseAdsClass

@property (nonatomic, assign) BOOL isReward;//是否发放奖励
@property (nonatomic, assign) int eventType;// 广告事件类型


@property (nonatomic, strong) NSString * cpmStr;
@property (nonatomic, strong) NSString * errorCode;
@property (nonatomic, strong) NSString * errorMsg;
@property (nonatomic, assign) BOOL isClick; // 是否点击广告


-(void)loadRewardVideo;

-(void)showRewardVideo;

-(void)remove;

-(void)loadError;

-(void)loadSuccess;

-(void)showError;

-(void)showSuccess;

-(void)closeVideo;

-(void)clickVideo;

-(void)rewardIssue;

@end

NS_ASSUME_NONNULL_END
