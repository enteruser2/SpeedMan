//
//  main.m
//  engine
//
//  Created by macmini on 2025/2/18.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <iostream>

#include "platform/BasePlatform.h"
int main(int argc, char * argv[]) {
//    cc::BasePlatform* platform = cc::BasePlatform::getPlatform();
//    if (platform->init()) {
//        return -1;
//    }
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}





