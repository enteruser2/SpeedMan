//
//  SignHandleKeyChain.h
//  lky4CustIntegClient
//
//  Created by Kevin on 2019/12/6.
//  Copyright © 2019 Beijing Wanxuantong Network Tech Co., Ltd. - Chengdu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignHandleKeyChain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end

NS_ASSUME_NONNULL_END
