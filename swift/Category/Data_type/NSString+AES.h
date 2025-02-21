//
//  NSString+AES.h
//  BasicFramework
//
//  Created by 7x on 2022/2/7.
//  Copyright © 2022 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)

/**<固定IV 加密方法 */
- (NSString*)encryptAESStaticIV;

/**< 固定IV 解密方法 */
- (NSString*)decryptAESStaticIV;

/**<动态IV 加密方法 */
- (NSString*)encryptAESDynamicIV;

/**< 动态IV 解密方法 */
- (NSString*)decryptAESDynamicIV;

// 生成指定长度随机字符
- (NSString *)randomString:(NSInteger)length ;


@end

NS_ASSUME_NONNULL_END
