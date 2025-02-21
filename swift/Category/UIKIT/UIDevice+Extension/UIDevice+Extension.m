//
//  UIDevice+Extension.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIDevice+Extension.h"

#include <sys/types.h>
#include <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "NSString+Extension.h"
@implementation UIDevice (Extension)



- (NSString*)hardwareString {
    int name[] = {CTL_HW,HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0); // getting size of answer
    char *hw_machine = (char*)malloc(size);
    
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

/* This is another way of gtting the system info
 * For this you have to #import <sys/utsname.h>
 */

/*
 NSString* machineName
 {
 struct utsname systemInfo;
 uname(&systemInfo);
 return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
 }
 */

+ (NSString *)getPhoneModel
{
    // iPhone http://theiphonewiki.com/wiki/IPhone
    // iPad http://theiphonewiki.com/wiki/IPad
    // iPad Mini http://theiphonewiki.com/wiki/IPad_mini
    // iPod http://theiphonewiki.com/wiki/IPod
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *hardware = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
#pragma mark -iphone
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([hardware isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([hardware isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([hardware isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([hardware isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([hardware isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([hardware isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([hardware isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([hardware isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([hardware isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    
    if ([hardware isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([hardware isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    if ([hardware isEqualToString:@"iPhone11,8"])    return @"iPhone XR";
    if ([hardware isEqualToString:@"iPhone11,2"])    return @"iPhone XS";
    if ([hardware isEqualToString:@"iPhone11,4"])    return @"iPhone XS Max";
    if ([hardware isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max";
    
    if ([hardware isEqualToString:@"iPhone12,1"])    return @"iPhone 11";
    if ([hardware isEqualToString:@"iPhone12,3"])    return @"iPhone 11 Pro";
    if ([hardware isEqualToString:@"iPhone12,5"])    return @"iPhone 11 Pro Max";
    if ([hardware isEqualToString:@"iPhone12,8"])    return @"iPhone SE (2nd generation)";
    if ([hardware isEqualToString:@"iPhone13,1"])    return @"iPhone 12 mini";
    if ([hardware isEqualToString:@"iPhone13,2"])    return @"iPhone 12";
    if ([hardware isEqualToString:@"iPhone13,3"])    return @"iPhone 12 Pro";
    if ([hardware isEqualToString:@"iPhone13,4"])    return @"iPhone 12 Pro Max";
    if ([hardware isEqualToString:@"iPhone14,4"])    return @"iPhone 13 mini";
    if ([hardware isEqualToString:@"iPhone14,5"])    return @"iPhone 13";
    if ([hardware isEqualToString:@"iPhone14,2"])    return @"iPhone 13 Pro";
    if ([hardware isEqualToString:@"iPhone14,3"])    return @"iPhone 13 Pro Max";
    if ([hardware isEqualToString:@"iPhone14,6"])    return @"iPhone SE (3rd generation)";
    
    if ([hardware isEqualToString:@"iPhone14,7"])    return @"iPhone 14";
    if ([hardware isEqualToString:@"iPhone14,8"])    return @"iPhone 14 Plus";
    if ([hardware isEqualToString:@"iPhone15,2"])    return @"iPhone 14 Pro";
    if ([hardware isEqualToString:@"iPhone15,3"])    return @"iPhone 14 Pro";

    
#pragma mark -ipod
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([hardware isEqualToString:@"iPod7,1"])      return @"iPod Touch (6 Gen)";
    if ([hardware isEqualToString:@"iPod9,1"])      return @"iPod Touch (7 Gen)";

#pragma mark -ipad
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi Rev. A)";

    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";

    if ([hardware isEqualToString:@"iPad6,11"])      return @"iPad 5";
    if ([hardware isEqualToString:@"iPad6,12"])      return @"iPad 5";
    
    if ([hardware isEqualToString:@"iPad7,5"])      return @"iPad 6";
    if ([hardware isEqualToString:@"iPad7,6"])      return @"iPad 6";
    
    if ([hardware isEqualToString:@"iPad7,11"])      return @"iPad 7";
    if ([hardware isEqualToString:@"iPad7,12"])      return @"iPad 7";
    
    if ([hardware isEqualToString:@"iPad11,6"])      return @"iPad 8";
    if ([hardware isEqualToString:@"iPad11,7"])      return @"iPad 8";
    
    if ([hardware isEqualToString:@"iPad12,1"])      return @"iPad 9";
    if ([hardware isEqualToString:@"iPad12,2"])      return @"iPad 9";
    
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad mini";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad mini";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad mini";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad mini 2";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad mini 2";
    if ([hardware isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    if ([hardware isEqualToString:@"iPad4,7"])      return @"iPad mini 3";
    if ([hardware isEqualToString:@"iPad4,8"])      return @"iPad mini 3";
    if ([hardware isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    if ([hardware isEqualToString:@"iPad5,1"])      return @"iPad mini 4";
    if ([hardware isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    if ([hardware isEqualToString:@"iPad11,1"])     return @"iPad mini (5th generation)";
    if ([hardware isEqualToString:@"iPad11,2"])     return @"iPad mini (5th generation)";
    if ([hardware isEqualToString:@"iPad14,1"])     return @"iPad mini (5th generation)";
    if ([hardware isEqualToString:@"iPad14,2"])     return @"iPad mini (5th generation)";
    
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi+GSM)";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air (WiFi+CDMA)";
    if ([hardware isEqualToString:@"iPad5,3"])      return @"iPad Air2";
    if ([hardware isEqualToString:@"iPad5,4"])      return @"iPad Air2";
    if ([hardware isEqualToString:@"iPad11,3"])     return @"iPad Air (3rd generation)";
    if ([hardware isEqualToString:@"iPad11,4"])     return @"iPad Air (3rd generation)";
    if ([hardware isEqualToString:@"iPad13,1"])     return @"iPad Air (4rd generation)";
    if ([hardware isEqualToString:@"iPad13,2"])     return @"iPad Air (4rd generation)";
    if ([hardware isEqualToString:@"iPad13,16"])    return @"iPad Air (5rd generation)";
    if ([hardware isEqualToString:@"iPad13,17"])    return @"iPad Air (5rd generation)";
    
    if ([hardware isEqualToString:@"iPad6,7"])      return @"iPad Pro (12.9-inch)";
    if ([hardware isEqualToString:@"iPad6,8"])      return @"iPad Pro (12.9-inch)";
    if ([hardware isEqualToString:@"iPad6,3"])      return @"iPad Pro (9.7-inch)";
    if ([hardware isEqualToString:@"iPad6,4"])      return @"iPad Pro (9.7-inch)";
    if ([hardware isEqualToString:@"iPad7,1"])      return @"iPad Pro (12.9-inch) (2nd generation)";
    if ([hardware isEqualToString:@"iPad7,2"])      return @"iPad Pro (12.9-inch) (2nd generation)";
    if ([hardware isEqualToString:@"iPad7,3"])      return @"iPad Pro (10.5-inch)";
    if ([hardware isEqualToString:@"iPad7,4"])      return @"iPad Pro (10.5-inch)";
    if ([hardware isEqualToString:@"iPad8,1"])      return @"iPad Pro (11-inch)";
    if ([hardware isEqualToString:@"iPad8,2"])      return @"iPad Pro (11-inch)";
    if ([hardware isEqualToString:@"iPad8,3"])      return @"iPad Pro (11-inch)";
    if ([hardware isEqualToString:@"iPad8,4"])      return @"iPad Pro (11-inch)";
    if ([hardware isEqualToString:@"iPad8,5"])      return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([hardware isEqualToString:@"iPad8,6"])      return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([hardware isEqualToString:@"iPad8,7"])      return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([hardware isEqualToString:@"iPad8,8"])      return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([hardware isEqualToString:@"iPad8,9"])      return @"iPad Pro (11-inch) (2nd generation)";
    if ([hardware isEqualToString:@"iPad8,10"])     return @"iPad Pro (11-inch) (2nd generation)";
    if ([hardware isEqualToString:@"iPad8,11"])     return @"iPad Pro (12.9-inch) (4th generation)";
    if ([hardware isEqualToString:@"iPad8,12"])     return @"iPad Pro (12.9-inch) (4th generation)";
    if ([hardware isEqualToString:@"iPad13,4"])     return @"iPad Pro (11-inch) (3rd generation)";
    if ([hardware isEqualToString:@"iPad13,5"])     return @"iPad Pro (11-inch) (3rd generation)";
    if ([hardware isEqualToString:@"iPad13,6"])     return @"iPad Pro (11-inch) (3rd generation)";
    if ([hardware isEqualToString:@"iPad13,7"])     return @"iPad Pro (11-inch) (3rd generation)";
    if ([hardware isEqualToString:@"iPad13,8"])     return @"iPad Pro (12.9-inch) (5th generation)";
    if ([hardware isEqualToString:@"iPad13,9"])     return @"iPad Pro (12.9-inch) (5th generation)";
    if ([hardware isEqualToString:@"iPad13,10"])     return @"iPad Pro (12.9-inch) (5th generation)";
    if ([hardware isEqualToString:@"iPad13,11"])     return @"iPad Pro (12.9-inch) (5th generation)";
#pragma mark -Simulator
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    return @"unknow";
}

+ (NSString *)getPhoneLocalizedModel
{
    return [[UIDevice currentDevice] localizedModel];
}

+(NSString *)getScreenPix
{
    NSString *screenPix = @"";
    //屏幕尺寸
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    //分辨率
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    screenPix = [NSString stringWithFormat:@"%.0fx%.0f",width*scale_screen,height*scale_screen];
    return screenPix;
}


- (Hardware)hardware {
    NSString *hardware = [self hardwareString];
    
    // iPhone http://theiphonewiki.com/wiki/IPhone
    // iPad http://theiphonewiki.com/wiki/IPad
    // iPad Mini http://theiphonewiki.com/wiki/IPad_mini
    // iPod http://theiphonewiki.com/wiki/IPod
    
    if ([hardware isEqualToString:@"iPhone1,1"])    return IPHONE_2G;
    if ([hardware isEqualToString:@"iPhone1,2"])    return IPHONE_3G;
    if ([hardware isEqualToString:@"iPhone2,1"])    return IPHONE_3GS;
    if ([hardware isEqualToString:@"iPhone3,1"])    return IPHONE_4;
    if ([hardware isEqualToString:@"iPhone3,2"])    return IPHONE_4;
    if ([hardware isEqualToString:@"iPhone3,3"])    return IPHONE_4_CDMA;
    if ([hardware isEqualToString:@"iPhone4,1"])    return IPHONE_4S;
    if ([hardware isEqualToString:@"iPhone5,1"])    return IPHONE_5;
    if ([hardware isEqualToString:@"iPhone5,2"])    return IPHONE_5_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone5,3"])    return IPHONE_5C;
    if ([hardware isEqualToString:@"iPhone5,4"])    return IPHONE_5C_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone6,1"])    return IPHONE_5S;
    if ([hardware isEqualToString:@"iPhone6,2"])    return IPHONE_5S_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone7,2"])    return IPHONE_6;
    if ([hardware isEqualToString:@"iPhone7,1"])    return IPHONE_6_PLUS;
    if ([hardware isEqualToString:@"iPhone8,1"])    return IPHONE_6S;
    if ([hardware isEqualToString:@"iPhone8,2"])    return IPHONE_6S_PLUS;
    if ([hardware isEqualToString:@"iPhone8,4"])    return IPHONE_SE;
    if ([hardware isEqualToString:@"iPhone9,1"])    return IPHONE_7;
    if ([hardware isEqualToString:@"iPhone9,3"])    return IPHONE_7;
    if ([hardware isEqualToString:@"iPhone9,2"])    return IPHONE_7_PLUS;
    if ([hardware isEqualToString:@"iPhone9,4"])    return IPHONE_7_PLUS;
    
    
    
    if ([hardware isEqualToString:@"iPod1,1"])      return IPOD_TOUCH_1G;
    if ([hardware isEqualToString:@"iPod2,1"])      return IPOD_TOUCH_2G;
    if ([hardware isEqualToString:@"iPod3,1"])      return IPOD_TOUCH_3G;
    if ([hardware isEqualToString:@"iPod4,1"])      return IPOD_TOUCH_4G;
    if ([hardware isEqualToString:@"iPod5,1"])      return IPOD_TOUCH_5G;
    
    if ([hardware isEqualToString:@"iPad1,1"])      return IPAD;
    if ([hardware isEqualToString:@"iPad1,2"])      return IPAD_3G;
    if ([hardware isEqualToString:@"iPad2,1"])      return IPAD_2_WIFI;
    if ([hardware isEqualToString:@"iPad2,2"])      return IPAD_2;
    if ([hardware isEqualToString:@"iPad2,3"])      return IPAD_2_CDMA;
    if ([hardware isEqualToString:@"iPad2,4"])      return IPAD_2;
    if ([hardware isEqualToString:@"iPad2,5"])      return IPAD_MINI_WIFI;
    if ([hardware isEqualToString:@"iPad2,6"])      return IPAD_MINI;
    if ([hardware isEqualToString:@"iPad2,7"])      return IPAD_MINI_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad3,1"])      return IPAD_3_WIFI;
    if ([hardware isEqualToString:@"iPad3,2"])      return IPAD_3_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad3,3"])      return IPAD_3;
    if ([hardware isEqualToString:@"iPad3,4"])      return IPAD_4_WIFI;
    if ([hardware isEqualToString:@"iPad3,5"])      return IPAD_4;
    if ([hardware isEqualToString:@"iPad3,6"])      return IPAD_4_GSM_CDMA;
    if ([hardware isEqualToString:@"iPad4,1"])      return IPAD_AIR_WIFI;
    if ([hardware isEqualToString:@"iPad4,2"])      return IPAD_AIR_WIFI_GSM;
    if ([hardware isEqualToString:@"iPad4,3"])      return IPAD_AIR_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad4,4"])      return IPAD_MINI_RETINA_WIFI;
    if ([hardware isEqualToString:@"iPad4,5"])      return IPAD_MINI_RETINA_WIFI_CDMA;
    
    
    if ([hardware isEqualToString:@"i386"])         return SIMULATOR;
    if ([hardware isEqualToString:@"x86_64"])       return SIMULATOR;
    return NOT_AVAILABLE;
}

- (NSString*)hardwareDescription {
    NSString *hardware = [self hardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev. A)";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (Global)";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S (GSM)";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S (Global)";
    
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([hardware isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([hardware isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([hardware isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([hardware isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([hardware isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad (WiFi)";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi Rev. A)";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi+GSM)";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air (WiFi+CDMA)";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (WiFi+CDMA)";
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"This is a device which is not listed in this category. Please visit https://github.com/inderkumarrathore/UIDevice-Hardware and add a comment there.");
    NSLog(@"Your device hardware string is: %@", hardware);
    if ([hardware hasPrefix:@"iPhone"]) return @"iPhone";
    if ([hardware hasPrefix:@"iPod"]) return @"iPod";
    if ([hardware hasPrefix:@"iPad"]) return @"iPad";
    return nil;
}

- (NSString*)hardwareSimpleDescription
{
    NSString *hardware = [self hardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([hardware isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([hardware isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([hardware isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([hardware isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([hardware isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina";
    
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"This is a device which is not listed in this category. Please visit https://github.com/inderkumarrathore/UIDevice-Hardware and add a comment there.");
    NSLog(@"Your device hardware string is: %@", hardware);
    
    if ([hardware hasPrefix:@"iPhone"]) return @"iPhone";
    if ([hardware hasPrefix:@"iPod"]) return @"iPod";
    if ([hardware hasPrefix:@"iPad"]) return @"iPad";
    
    return nil;
}


- (float)hardwareNumber:(Hardware)hardware {
    switch (hardware) {
        case IPHONE_2G: return 1.1f;
        case IPHONE_3G: return 1.2f;
        case IPHONE_3GS: return 2.1f;
        case IPHONE_4:    return 3.1f;
        case IPHONE_4_CDMA:    return 3.3f;
        case IPHONE_4S:    return 4.1f;
        case IPHONE_5:    return 5.1f;
        case IPHONE_5_CDMA_GSM:    return 5.2f;
        case IPHONE_5C:    return 5.3f;
        case IPHONE_5C_CDMA_GSM:    return 5.4f;
        case IPHONE_5S:    return 6.1f;
        case IPHONE_5S_CDMA_GSM:    return 6.2f;
            
            
        case IPHONE_SE:         return 6.3f;
            
        case IPHONE_6:         return 7.1f;
        case IPHONE_6_PLUS:    return 7.2f;
            
        case IPHONE_6S:         return 8.1f;
        case IPHONE_6S_PLUS:         return 8.2f;
        case IPHONE_7:         return 10.1f;
        case IPHONE_7_PLUS:         return 10.2f;
            
            
        case IPOD_TOUCH_1G:    return 1.1f;
        case IPOD_TOUCH_2G:    return 2.1f;
        case IPOD_TOUCH_3G:    return 3.1f;
        case IPOD_TOUCH_4G:    return 4.1f;
        case IPOD_TOUCH_5G:    return 5.1f;
            
        case IPAD:    return 1.1f;
        case IPAD_3G:    return 1.2f;
        case IPAD_2_WIFI:    return 2.1f;
        case IPAD_2:    return 2.2f;
        case IPAD_2_CDMA:    return 2.3f;
        case IPAD_MINI_WIFI:    return 2.5f;
        case IPAD_MINI:    return 2.6f;
        case IPAD_MINI_WIFI_CDMA:    return 2.7f;
        case IPAD_3_WIFI:    return 3.1f;
        case IPAD_3_WIFI_CDMA:    return 3.2f;
        case IPAD_3:    return 3.3f;
        case IPAD_4_WIFI:    return 3.4f;
        case IPAD_4:    return 3.5f;
        case IPAD_4_GSM_CDMA:    return 3.6f;
        case IPAD_AIR_WIFI:    return 4.1f;
        case IPAD_AIR_WIFI_GSM:    return 4.2f;
        case IPAD_AIR_WIFI_CDMA:    return 4.3f;
        case IPAD_MINI_RETINA_WIFI:    return 4.4f;
        case IPAD_MINI_RETINA_WIFI_CDMA:    return 4.5f;
            
        case SIMULATOR:    return 100.0f;
        case NOT_AVAILABLE:    return 200.0f;
    }
    return 200.0f; //Device is not available
}

- (BOOL)isCurrentDeviceHardwareBetterThan:(Hardware)hardware {
    float otherHardware = [self hardwareNumber:hardware];
    float currentHardware = [self hardwareNumber:[self hardware]];
    return currentHardware >= otherHardware;
}

- (CGSize)backCameraStillImageResolutionInPixels
{
    switch ([self hardware]) {
        case IPHONE_2G:
        case IPHONE_3G:
            return CGSizeMake(1600, 1200);
            break;
        case IPHONE_3GS:
            return CGSizeMake(2048, 1536);
            break;
        case IPHONE_4:
        case IPHONE_4_CDMA:
        case IPAD_3_WIFI:
        case IPAD_3_WIFI_CDMA:
        case IPAD_3:
        case IPAD_4_WIFI:
        case IPAD_4:
        case IPAD_4_GSM_CDMA:
            return CGSizeMake(2592, 1936);
            break;
        case IPHONE_4S:
        case IPHONE_5:
        case IPHONE_5_CDMA_GSM:
        case IPHONE_5C:
        case IPHONE_5C_CDMA_GSM:
            return CGSizeMake(3264, 2448);
            break;
            
        case IPOD_TOUCH_4G:
            return CGSizeMake(960, 720);
            break;
        case IPOD_TOUCH_5G:
            return CGSizeMake(2440, 1605);
            break;
            
        case IPAD_2_WIFI:
        case IPAD_2:
        case IPAD_2_CDMA:
            return CGSizeMake(872, 720);
            break;
            
        case IPAD_MINI_WIFI:
        case IPAD_MINI:
        case IPAD_MINI_WIFI_CDMA:
            return CGSizeMake(1820, 1304);
            break;
        default:
            NSLog(@"We have no resolution for your device's camera listed in this category. Please, make photo with back camera of your device, get its resolution in pixels (via Preview Cmd+I for example) and add a comment to this repository on GitHub.com in format Device = Hpx x Wpx.");
            NSLog(@"Your device is: %@", [self hardwareDescription]);
            break;
    }
    return CGSizeZero;
}

- (BOOL)isIphoneWith4inchDisplay
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        double height = [[UIScreen mainScreen] bounds].size.height;
        if (fabs(height-568.0f) < DBL_EPSILON) {
            return YES;
        }
    }
    return NO;
}


+ (NSString *)macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = (char*)malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - sysctl utils

+ (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, static_cast<int>(typeSpecifier)};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

#pragma mark - memory information
+ (NSUInteger)cpuFrequency {
    return [self getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)busFrequency {
    return [self getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ramSize {
    return [self getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)cpuNumber {
    return [self getSysInfo:HW_NCPU];
}


+ (NSUInteger)totalMemoryBytes
{
    return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

#pragma mark - disk information

+ (long long)freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}
//获取运营商名称
+ (NSString *)getCarrierName{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *carrierName = [carrier carrierName];

    if ([NSString isNULL:carrierName]) {
        carrierName = @"";
    }
//    NSLog(@"getCarrierInfo----[carrier carrierName]==%@,[carrier mobileCountryCode]==%@,[carrier mobileNetworkCode]==%@,[carrier isoCountryCode]==%@,[carrier allowsVOIP]==%d",[carrier carrierName],[carrier mobileCountryCode],[carrier mobileNetworkCode],[carrier isoCountryCode],[carrier allowsVOIP]);
    
    return carrierName;
};

//获取运营商code
+ (NSString *)getCarrierCode{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString * mobileCountryCode = [carrier mobileCountryCode];
    NSString * mobileNetworkCode = [carrier mobileNetworkCode];

    NSString *carrierCode =[NSString stringWithFormat:@"%@%@",mobileCountryCode,mobileNetworkCode];
//    NSLog(@"getCarrierInfo----[carrier carrierName]==%@,[carrier mobileCountryCode]==%@,[carrier mobileNetworkCode]==%@,[carrier isoCountryCode]==%@,[carrier allowsVOIP]==%d",[carrier carrierName],[carrier mobileCountryCode],[carrier mobileNetworkCode],[carrier isoCountryCode],[carrier allowsVOIP]);
    if ([NSString isNULL:mobileCountryCode] || [NSString isNULL:mobileNetworkCode] || [mobileNetworkCode isEqual:@"65535"] || [mobileNetworkCode isEqual:@"65535"]) {
        carrierCode = @"";
    }
    return carrierCode;
};

//获取运营商isoCountryCode
+ (NSString *)getisoCountryCode{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *isoCountryCode = [NSString stringWithFormat:@"%@",[carrier isoCountryCode]];
    if ( [NSString isNULL:isoCountryCode]) {
        isoCountryCode = @"";
    }
    return isoCountryCode;
};

//获取时区
+ (NSString *)getTimeZone{
    NSTimeZone* timeZone = [NSTimeZone localTimeZone] ;
    return [timeZone name];
};

@end
