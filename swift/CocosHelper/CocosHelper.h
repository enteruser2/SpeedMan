//
//  CocosHelper.h
//  AngryMan
//
//  Created by 7x on 2023/11/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *  cocos_action;
extern NSString *  cocos_argument;
extern NSString *  cocos_callbackId;

@interface CocosHelper : NSObject

+ (instancetype)sharedCocosHelper;

+ (void)nativeCallCocosEvent:(NSString*)action argument:(NSString*)argument callbackId:(NSString*)callbackId;

+ (void)nativeCallCocosRootEvent:(NSString*)action argument:(NSString*)argument callbackId:(NSString*)callbackId;

+ (void)cocosCallnativeEvent:(NSString*)action argument:(NSString*)argument callbackId:(NSString*)callbackId;

+ (void)apphideGoodCutLaunchView;

+ (void)getLookVideo:(NSString*)type;
	
+(void)OpenActivity:(NSString*)type param:(NSString*)param;

+(void)SendJSError:(NSString*)error;

+(void)copyContent:(NSString*)text;

+ (void)setLanguageChange:(NSString*)code;

+ (void)setShareContent:(NSString*)shareBean type:(NSString*)type;

+ (void)updataApp;

+ (void)loginOut;

+ (void)vibrate;

+(NSString *)getRequestHeaderInfo;

+(NSString *) getTranslateInfo;

+(NSString *) getUserInfo;

+(NSString *)getVersionNumber;

+(NSString *)getAppName;

+(UIViewController*)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
