//
//  AppDelegate.h
//  engine
//
//  Created by macmini on 2025/2/18.
//

#pragma once

#import "platform/ios/AppDelegateBridge.h"
#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
}

@property(nonatomic, readonly) ViewController *viewController;
@property(nonatomic, readonly) AppDelegateBridge *appDelegateBridge;
@end


