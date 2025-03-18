//
//  CocosBridge.m
//  swift
//
//  Created by 7x on 2023/12/13.
//

#import "CocosBridge.h"
#import "CocosAppDelegate.h"

//#include <iostream>
//
//#include "platform/BasePlatform.h"
    
@interface CocosBridge()
@property (nonatomic,strong) View * cocosView;

@end

@implementation CocosBridge

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLoadView =  false;
        CGRect bounds = [[UIScreen mainScreen] bounds];
        self.cocosView = [[View alloc] initWithFrame:bounds];
        
    }
    return self;
}

- (void)initCocosMain{
    cc::BasePlatform* platform = cc::BasePlatform::getPlatform();
    if (platform->init()) {
    }
}


static CocosBridge* _bridge = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bridge = [[CocosBridge alloc] init];
    });

    return _bridge;
}


- (View *)getCocosView {
    self.isLoadView =  true;
    return self.cocosView;
}


- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (self.isLoadView) {
        [[[CocosAppDelegate shared] appDelegateBridge] application:application didFinishLaunchingWithOptions:launchOptions];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    if (self.isLoadView) {
        [[[CocosAppDelegate shared] appDelegateBridge] applicationWillResignActive:application];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (self.isLoadView) {
        [[[CocosAppDelegate shared] appDelegateBridge] applicationDidBecomeActive:application];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    if (self.isLoadView) {
        [[[CocosAppDelegate shared] appDelegateBridge] applicationWillTerminate:application];
    }
}

@end
