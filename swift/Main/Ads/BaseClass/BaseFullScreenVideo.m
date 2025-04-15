//
//  BaseFullScreenVideo.m
//  TestAA-mobile
//
//  Created by qf on 2020/12/4.
//

#import "BaseFullScreenVideo.h"

@implementation BaseFullScreenVideo

- (id)initWithObj
{
    self = [super initWithObj];
    if (self) {
        self.errorCode = @"0";
        self.errorMsg  = @"0";
        //是否存在对应广告缓存
        id obj = [[AdCacheTool shareAdCacheTool].tmpDic objectForKey:self.slotId];
        if (!obj)
        {
            NSString * classStr = [NSString stringWithFormat:@"%@%@",self.platformType,FullScreenVideo_Type];
            obj = [[NSClassFromString(classStr) alloc]init];
            [obj ReflexSetValueParameter:self.json andVC:self.vc];
            [[AdCacheTool shareAdCacheTool].tmpDic setObject:obj forKey:self.slotId];
            [obj loadFullScreenVideo];
        }
        else if(self.isShowFuc)
        {
            [obj ReflexSetValueParameter:self.json andVC:self.vc];
            [obj showFullScreenVideo];
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
-(void)loadFullScreenVideo
{
    //子类实现
    [OCProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:@"Loading..." isTouched:NO inView:[UIApplication sharedApplication].keyWindow];

}

//展示视频
-(void)showFullScreenVideo
{
    //子类实现
    [OCProgressHUD hideProgressHUDAfterDelay:0];
}

-(void)remove
{
    if([[AdCacheTool shareAdCacheTool].AdsShowDic objectForKey:self.slotId]){
        [[AdCacheTool shareAdCacheTool].AdsShowDic removeObjectForKey:self.slotId];
    }
    NSLog(@"BaseFullScreenVideo--清除%@激励视频缓存----slotId:%@----",self.adType,self.slotId);
}

-(void)removeCache
{
    if([[AdCacheTool shareAdCacheTool].tmpDic objectForKey:self.slotId]){
        [[AdCacheTool shareAdCacheTool].tmpDic removeObjectForKey:self.slotId];
    }
}

//加载失败
-(void)loadError
{
    [OCProgressHUD hideProgressHUDAfterDelay:0];
    self.eventType = LoadFail;
    [self loadDefaultAd];
    [[AdsSwift shared] videoErrorWithPostionADSceneType:self.postionADSceneType];
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
    [OCProgressHUD hideProgressHUDAfterDelay:0];
    self.eventType = RenderFail;
    [self loadDefaultAd];
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
    [self closeEvent];
    self.eventType = Close;
    [self removeCache];
}

//点击视频内容
-(void)clickVideo
{
    self.isClick = true;
    self.eventType = Click;
}


- (void)setEventType:(int)eventType
{
    _eventType = eventType;
    [self updateLog];
}

//发放奖励
-(void)rewardIssue
{
    self.isReward = true;
}



// 广告加载失败后,加载默认广告位
-(void)loadDefaultAd
{
    // 只默认加载一次,防止重复一直刷
    NSString * key = @"isLoadFullDefault";
    BOOL isLoadDefault = [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];
    if (isLoadDefault) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.defaultsId = @"981897202";
    self.defaultsAdType = @"1";

    NSString * adID   = self.defaultsId;
    NSString * adType = self.defaultsAdType;

    BOOL isShowFuc = NO;
    if ([[AdCacheTool shareAdCacheTool].tmpDic objectForKey:adID] ) {
        isShowFuc = YES;
    }
    NSDictionary * dic = @{@"slotId":adID,
                           @"adType":adType,
                           @"postionADSceneType":self.postionADSceneType,
                           @"isShowFuc":@(isShowFuc)};
    
    [[AdsManager shareAdsManager] loadAdType:FullVideoAd_Type parameters:[dic DictionaryConversionStringOfJson]];
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
    
    // 1-展示，2-点击，3-关闭，4-播完，5-下载，6-安装，7-奖励成功，8-加载失败，9-渲染失败
    NSDictionary * dic = @{@"type":@(self.eventType),
                           @"postionADSceneType":self.postionADSceneType,
                           @"source":source,
                           @"ad_type":@(3),
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
    if (self.isClick && [self.postionADSceneType isEqualToString:@"iosVideoAdIdFreePlay"])
    {
        [[AdsSwift shared] clickEventWithPostionADSceneType:self.postionADSceneType];
    }
}

@end
