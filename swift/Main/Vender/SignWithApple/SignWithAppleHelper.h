//
//  SignWithAppleHelper.h
//  lky4CustIntegClient
//
//  Created by Kevin on 2019/12/6.
//  Copyright © 2019 Beijing Wanxuantong Network Tech Co., Ltd. - Chengdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AuthenticationServices/AuthenticationServices.h>
NS_ASSUME_NONNULL_BEGIN

@interface SignWithAppleHelper : NSObject
+ (SignWithAppleHelper *)defaultSignInWithAppleModel;
+ (void)attempDealloc;
+ (void)signInWithAppleWithButtonRect:(CGRect)rect
        withSupView:(UIView *)superView                    withType:(ASAuthorizationAppleIDButtonType)type withStyle:(ASAuthorizationAppleIDButtonStyle)style success:(void(^)(ASAuthorization *authorization,NSString *user))success
    failure:(void (^)(NSError *err))failure;
@end

NS_ASSUME_NONNULL_END
