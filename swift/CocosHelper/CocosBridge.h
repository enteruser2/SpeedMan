//
//  CocosBridge.h
//  swift
//
//  Created by 7x on 2023/12/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "View.h"

NS_ASSUME_NONNULL_BEGIN

@interface CocosBridge : NSObject


+ (instancetype)shared;

- (View *)getCocosView;

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

- (void)initCocosMain;
@end

NS_ASSUME_NONNULL_END
