//
//  BaseFullScreenVideo.h
//  TestAA-mobile
//
//  Created by qf on 2020/12/4.
//

#import "BaseAdsClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseFullScreenVideo : BaseAdsClass

@property (nonatomic, assign) BOOL  isclickJupm;//是否点击跳过
@property (nonatomic, assign) BOOL isReward;//是否发放奖励

@property (nonatomic, assign) int eventType;// 广告事件类型
@property (nonatomic, strong) NSString * errorCode;
@property (nonatomic, strong) NSString * errorMsg;

@property (nonatomic,strong) id obj;
@property (nonatomic, assign) BOOL isClick; // 是否点击广告


-(void)loadFullScreenVideo;

-(void)showFullScreenVideo;

-(void)loadError;

-(void)loadSuccess;

-(void)showError;

-(void)showSuccess;

-(void)closeVideo;

-(void)clickVideo;

-(void)rewardIssue;
@end

NS_ASSUME_NONNULL_END
