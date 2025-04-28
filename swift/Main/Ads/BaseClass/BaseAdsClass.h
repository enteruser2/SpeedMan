//
//  BaseAdsClass.h
//  TestAA-mobile
//
//  Created by qf on 2020/12/2.
//

/**
 所有广告基类
1、广告平台初始化
2、广告类型初始化
 */

#import <Foundation/Foundation.h>
#import <objc/runtime.h> //包含对类、成员变量、属性、方法的操作
#import <UIKit/UIKit.h>
#import "OCProgressHUD.h"
#import "NSDictionary+Extension.h"
#import "NSString+Extension.h"
#import "AdCacheTool.h"
#import "SpeedMan-Swift.h"


NS_ASSUME_NONNULL_BEGIN

/**
 *  Ads
 */
extern NSString* const Google_TypeName;
extern NSString* const CSJ_TypeName;
extern NSString* const AppLovin_TypeName;
extern NSString *const FaceBook_TypeName;

extern NSString *const Base_Platfrom;
extern NSString *const Google_Platfrom;
extern NSString *const CSJ_Platfrom;
extern NSString *const AppLovin_Platfrom;
extern NSString *const FaceBook_Platfrom;

extern NSString *const Reward_Type;
extern NSString *const FullScreenVideo_Type;

@interface BaseAdsClass : NSObject

@property (nonatomic, strong) UIViewController * vc;
@property (nonatomic,copy) NSString * json; //传过来的json参数
@property (nonatomic,copy) NSString * slotId;//广告位ID
@property (nonatomic,copy) NSString * adType;//广告平台
@property (nonatomic,copy) NSString * defaultsAdType;//默认广告平台
@property (nonatomic,copy) NSString * defaultsId;//默认广告位ID
@property (nonatomic,copy) NSString * platformType;
@property (nonatomic,copy) NSString * postionADSceneType; // 广告场景类型
@property (nonatomic,copy) NSString * sId;
@property (nonatomic, strong) NSString * cpmStr;

@property (nonatomic,assign) BOOL  isShowFuc;//是否自动展示



//工厂方法 类名组成 广告平台 + 广告类型；如：GDT + RewardVideo
+(void)FactoryWithAdPlatfrom:(NSString *)platfrom andType:(NSString *)type andIsShow:(BOOL)isShowFuc andParameter:(NSString *)parameter andVC:(UIViewController *)vc;

//反射赋值
-(void)ReflexSetValueParameter:(NSString *)parameter andVC:(UIViewController *)vc;


//初始化
-(id)initWithObj;


@end

NS_ASSUME_NONNULL_END
