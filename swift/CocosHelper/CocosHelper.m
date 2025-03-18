//
//  CocosHelper.m
//  AngryMan
//
//  Created by 7x on 2023/11/7.
//

#import "CocosHelper.h"
#include "base/UTF8.h"
#include "cocos/bindings/jswrapper/SeApi.h"
#import "NSString+Extension.h"
#import "CocosBridgeModel.h"
#import "SpeedMan-Swift.h"

typedef enum
{
    UserInfoApi,
    ReportGoogleID,
    HomeApi,
    PassGameApi,
    PassGameVideoGoldApi,
    GetMoneyApi,
    SpecialEventApi,
    SpecialEventSuccessApi,
    OfflineGoldRewardApi,
    PropGoldRewardApi,
    MarQueeApi,
    AddEnergyApi,
    ReduceEnergyApi,
    OperateSuccessApi,
}ApiType;

NSString *  cocos_action     = @"";
NSString *  cocos_argument   = @"";
NSString *  cocos_callbackId = @"";

@implementation CocosHelper

+ (instancetype)sharedCocosHelper
{
    static CocosHelper *helper= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!helper) {
            
            helper = [CocosHelper new];
        }
    });
    return helper;
}


+(void)nativeCallCocosEvent:(NSString*)action argument:(NSString*)argument callbackId:(NSString*)callbackId {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString * name = @"window.speedman.nativeCallWaterCocos";
        std::string funcName = [name UTF8String];
        std::string actionName = [action UTF8String];
        std::string param001 = [argument UTF8String];
        std::string param002 = [callbackId UTF8String];
        std::string jsCallStr = cc::StringUtils::format("%s(\'%s\',\"%s\");",funcName.c_str(),param001.c_str(),param002.c_str());
        NSLog(@"CocosHelper----nativeCallCocosEvent %@---%@----%@",action,argument,callbackId);
        se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str());
    });

}

+(void)nativeCallCocosRootEvent:(NSString*)action argument:(NSString*)argument callbackId:(NSString*)callbackId {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString * name = @"window.speedmanroot.nativeCallWaterCocos";
        std::string funcName = [name UTF8String];
        std::string actionName = [action UTF8String];
        std::string param001 = [argument UTF8String];
        std::string param002 = [callbackId UTF8String];
        std::string jsCallStr = cc::StringUtils::format("%s(\'%s\',\"%s\");",funcName.c_str(),param001.c_str(),param002.c_str());
        NSLog(@"CocosHelper----nativeCallCocosRootEvent %@---%@----%@",action,argument,callbackId);
        se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str());
    });

}


+(void)cocosCallnativeEvent:(NSString*)action argument:(NSString*)argument callbackId:(NSString*)callbackId {
    NSLog(@"CocosHelper----cocosCallnativeEvent %@---%@----%@",action,argument,callbackId);
    CocosBridgeModel * model = nil;
    if (![NSString isNULL:argument]) {
        model = [[CocosBridgeModel alloc]initWithString:argument error:nil];
    }
//    else if([action isEqualToString:@"OpenActivity"] && model != nil)
//    {
//        [CocosSwift OpenActivityWithActivityType:[model.type intValue] cocosInteractID:[model.id intValue]];
//    }

}


+(NSString *)getTranslateInfo{
    NSLog(@"CocosHelper----getTranslateInfo ");
   return [CocosSwift getTranslateInfo];
}

+(NSString *)getVersionNumber{
    NSLog(@"CocosHelper----getVersionNumber");
    return [CocosSwift getVersionNumber];
}

+(NSString *)getAppName{
    NSLog(@"CocosHelper----getAppName");
    return [CocosSwift getAppName];
}

+(void)getLookVideo:(NSString*)type{
    NSLog(@"CocosHelper----getLookVideo:%@",type);
    [CocosSwift getLookVideoWithVideotype:type];
}

+(void)OpenActivity:(NSString*)type param:(NSString*)param{
    NSLog(@"CocosHelper----OpenActivity:%@--%@",type,param);
    [CocosSwift OpenActivityWithType:type param:param];
}

+(void)SendJSError:(NSString*)error{
    NSLog(@"CocosHelper----SendJSError:%@",error);
    [CocosSwift SendJSErrorWithError:error];
}

+(NSString *)getRequestHeaderInfo{
    NSLog(@"CocosHelper----getRequestHeaderInfo");
    return [CocosSwift getRequestHeaderInfo];
}

+(NSString *) getUserInfo{
    NSLog(@"CocosHelper----getUserInfo");
    return [CocosSwift getUserInfo];
}

+(void)apphideGoodCutLaunchView
{
    UIViewController * vc = [CocosHelper getCurrentVC];
    NSLog(@"CocosHelper----hideSplashView : %@",vc);
    if ([vc isKindOfClass:ViewController.class]) {
        SEL selector = NSSelectorFromString(@"hideSplashView");
        if ( [vc respondsToSelector:selector] == YES ) {
            ((void (*)(id, SEL))[vc methodForSelector:selector])(vc, selector);
        }
    }
}

+ (void)setLanguageChange:(NSString*)code{
    NSLog(@"CocosHelper----setLanguageChange :%@",code);
    [CocosSwift setLanguageChangeWithCode:code];

}

+(void)copyContent:(NSString*)text{
    NSLog(@"CocosHelper----copyContent :%@",text);
    [CocosSwift copyContentWithText:text];
}

+ (void)setShareContent:(NSString*)shareBean type:(NSString*)type{
    NSLog(@"CocosHelper----setShareContent :%@",shareBean);
    [CocosSwift setShareContentWithShareBean:shareBean type:type];
}

+ (void)updataApp{
    NSLog(@"CocosHelper----updataApp");
    [CocosSwift updataApp];
}

+ (void)loginOut{
    NSLog(@"CocosHelper----loginOut");
    [CocosSwift loginOut];
}

+ (void)vibrate{
    NSLog(@"CocosHelper----vibrate");
    [CocosSwift vibrate];
}


+(UIViewController *)getCurrentVC
{

    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];

    return currentVC;
}

+(UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;

    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]])
    {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]])
    {

        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }
    else
    {
        currentVC = rootVC;
    }
    return currentVC;
}

@end
