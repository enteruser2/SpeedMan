//
//  BaseRewardVideo.m
//  TestAA-mobile
//
//  Created by qf on 2020/12/2.
//

#import "BaseRewardVideo.h"
#import "AdsManager.h"

@implementation BaseRewardVideo

- (id)initWithObj
{
    self = [super initWithObj];
    if (self) {
        
        //是否存在对应广告缓存
        id obj = [[AdCacheTool shareAdCacheTool].tmpDic objectForKey:self.slotId];
        if (!obj)
        {
            NSString * classStr = [NSString stringWithFormat:@"%@%@",self.platformType,Reward_Type];
            obj = [[NSClassFromString(classStr) alloc]init];
            [obj ReflexSetValueParameter:self.json andVC:self.vc];
            [obj loadRewardVideo];
            [[AdCacheTool shareAdCacheTool].tmpDic setObject:obj forKey:self.slotId];
        }
        else if(self.isShowFuc)
        {
            [obj ReflexSetValueParameter:self.json andVC:self.vc];
            [obj showRewardVideo];
        }
        
        
    }
    return self;
}

-(void)ReflexSetValueParameter:(NSString *)parameter andVC:(UIViewController *)vc
{
    [super ReflexSetValueParameter:parameter andVC:vc];
}

#pragma 抽出重复方法
//预加载视频
-(void)loadRewardVideo
{
    //子类实现
    [OCProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:@"Loading..." isTouched:NO inView:[UIApplication sharedApplication].keyWindow];

}

//展示视频
-(void)showRewardVideo
{
    //子类实现
    
}

-(void)remove
{
    
    if([[AdCacheTool shareAdCacheTool].AdsShowDic objectForKey:self.slotId])
    {
        [[AdCacheTool shareAdCacheTool].AdsShowDic removeObjectForKey:self.slotId];
    }
    
    NSLog(@"BaseRewardVideo--清除%@激励视频缓存----slotId:%@----",self.adType,self.slotId);
}

-(void)removeCache
{
    if([[AdCacheTool shareAdCacheTool].tmpDic objectForKey:self.slotId]){
        [[AdCacheTool shareAdCacheTool].tmpDic removeObjectForKey:self.slotId];
    }
}

// 广告加载失败后,加载默认广告位
-(void)loadDefaultAd
{
    // 只默认加载一次,防止重复一直刷
    NSString * key = @"isLoadDefault";
    BOOL isLoadDefault = [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];
    if (isLoadDefault) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

    self.defaultsId = @"9e02a6064152aa3d";
    self.defaultsAdType = @"3";

    NSString * adID   = self.defaultsId;
    NSString * adType = self.defaultsAdType;
    
    BOOL isShowFuc = NO;
    if ([[AdCacheTool shareAdCacheTool].tmpDic objectForKey:adID] ) {
        isShowFuc = YES;
    }
    //激励视频
    NSDictionary * dic = @{@"slotId":adID,
                           @"adType":adType,
                           @"postionADSceneType":self.postionADSceneType,
                           @"isShowFuc":@(self.isShowFuc)};
    
    [[AdsManager shareAdsManager] loadAdType:RewardAd_Type parameters:[dic DictionaryConversionStringOfJson]];
}

//加载失败
-(void)loadError
{

    [OCProgressHUD hideProgressHUDAfterDelay:0];
    self.eventType = LoadFail;
    [[AdsSwift shared] videoErrorWithPostionADSceneType:self.postionADSceneType];
    [self loadDefaultAd];
    [self removeCache];
}

//加载成功
-(void)loadSuccess
{
    [OCProgressHUD hideProgressHUDAfterDelay:0];
    self.eventType = Display;
    [[AdCacheTool shareAdCacheTool].AdsLoadDic setValue:self forKey:self.slotId];
    
}

//播放失败
-(void)showError
{
    
    self.eventType = RenderFail;
    [[AdsSwift shared] videoErrorWithPostionADSceneType:self.postionADSceneType];
    [self removeCache];
}

//播放成功
-(void)showSuccess
{
   
    [[AdCacheTool shareAdCacheTool].AdsShowDic setValue:self forKey:self.slotId];
    self.eventType = Complete;
}

//关闭视频
-(void)closeVideo
{
    // 视频播放完毕，关闭可发放奖励
    if (self.isReward)
    {
        [self closeEvent];
    }
    
    self.eventType = Close;
    [self removeCache];

}



//点击视频内容
-(void)clickVideo
{
    self.isClick = true;
    self.eventType = Click;

}


//发放奖励
-(void)rewardIssue
{
    self.isReward = true;
    self.eventType = Reward;
}

// 上报ecpm
-(void)upDataEcpm:(NSString *)cpmStr {
    self.cpmStr = cpmStr;
    self.eventType = Revenue;
}

- (void)setEventType:(int)eventType
{
    _eventType = eventType;
    [self updateLog];
}

-(NSDictionary *)getJson
{
    if ([NSString isNULL:self.errorCode]|| [NSString isNULL:self.errorMsg]) {
        self.errorCode = @"0";
        self.errorMsg  = @"0";
    }
    NSString * source = @"";
    if ([self.adType isEqualToString:CSJ_TypeName])
    {
        source = @"csj";
    }
    else if ([self.adType isEqualToString:Google_TypeName])
    {
        source = @"google";
    }
    else if ([self.adType isEqualToString:AppLovin_TypeName])
    {
        source = @"applovin";
    }
    else if ([self.adType isEqualToString:FaceBook_TypeName])
    {
        source = @"facebook";
    }
    
    NSLog(@"BaseRewardVideo--getJson %d---%@",self.eventType,self.postionADSceneType);

    NSDictionary * dic = @{@"type":@(self.eventType),
                           @"postionADSceneType":self.postionADSceneType,
                           @"source":source,
                           @"ad_type":@(1),
                           @"cpmStr":self.cpmStr,
                           @"source_id":self.slotId,
                           @"error_code":self.errorCode,
                           @"error_msg":self.errorMsg,
    };
    return dic;
}

-(void)updateLog
{
    NSDictionary * dic = [self getJson];
    [[AdsSwift shared] updateLogWithDic:dic];
}


#pragma mark 业务逻辑
-(void)closeEvent
{
    [[AdsSwift shared] closeEventWithPostionADSceneType:self.postionADSceneType];
    if (self.isClick && [self.postionADSceneType isEqualToString:@"iosVideoAdIdFreePlay"]) {
        [[AdsSwift shared] clickEventWithPostionADSceneType:self.postionADSceneType];
    }
}



@end
