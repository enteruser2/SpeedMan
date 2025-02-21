//
//  CocosAppDelegate.m
//  GoodCut
//
//  Created by macmini on 2025/2/20.
//

#import "CocosAppDelegate.h"

@implementation CocosAppDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {

        self.appDelegateBridge = [[AppDelegateBridge alloc]init];

    }
    return self;
}

static CocosAppDelegate* _bridge = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bridge = [[CocosAppDelegate alloc] init];
    });

    return _bridge;
}

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.appDelegateBridge application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.appDelegateBridge applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.appDelegateBridge applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self.appDelegateBridge applicationWillTerminate:application];
}


@end
