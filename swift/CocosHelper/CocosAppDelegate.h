//
//  CocosAppDelegate.h
//  GoodCut
//
//  Created by macmini on 2025/2/20.
//

#import <Foundation/Foundation.h>
#import "platform/ios/AppDelegateBridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface CocosAppDelegate : NSObject

@property (nonatomic,strong)AppDelegateBridge *appDelegateBridge;

+ (instancetype)shared;

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
