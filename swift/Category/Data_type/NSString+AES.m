//
//  NSString+AES.m
//  BasicFramework
//
//  Created by 7x on 2022/2/7.
//  Copyright © 2022 Rainy. All rights reserved.
//

#import "NSString+AES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonRandom.h>
#import "GTMBase64.h"
// 这里的偏移量也需要跟后台一致，一般跟key一样就行
static NSString *const AES_IV_PARAMETER = @"";
static NSString *const AES_PSW_AES_KEY = @"SbcfzESStd7bGtdsQEC3cM9pGdR38Jsd";

@implementation NSString (AES)

//利用CCRandomGenerateBytes实现随机字符串的生成
- (NSString *)randomString:(NSInteger)length {
    length = length/2;
    unsigned char digest[length];
    CCRNGStatus status = CCRandomGenerateBytes(digest, length);
    NSString *s = nil;
    if (status == kCCSuccess) {
        s = [self stringFrom:digest length:length];
    } else {
        s = self;
    }
    return s;
}

//将bytes转为字符串
- (NSString *)stringFrom:(unsigned char *)digest length:(NSInteger)leng {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < leng; i++) {
        [string appendFormat:@"%02x",digest[i]];
    }
    return string;
}

/**<固定IV 加密方法 */
- (NSString*)encryptAESStaticIV
{
    NSData   * encData = [self encryptAESStaticIV:[self dataUsingEncoding:NSUTF8StringEncoding] key:AES_PSW_AES_KEY iv:AES_IV_PARAMETER];
    NSString * encStr  = [[NSString alloc] initWithData:[GTMBase64 encodeData:encData] encoding:NSUTF8StringEncoding];
    return encStr;
}

/**< 固定IV 解密方法 */
- (NSString*)decryptAESStaticIV
{
    NSData * decData  = [self decryptAESStaticIV:[GTMBase64 decodeString:self] key:AES_PSW_AES_KEY iv:AES_IV_PARAMETER];
    NSString * decStr = [[NSString alloc] initWithData:decData encoding:NSUTF8StringEncoding];
    return decStr;
}

/**<动态IV 加密方法 */
- (NSString*)encryptAESDynamicIV
{
    // 随机生成16字节字符串
    NSString * ivstr = [self randomString:16];
    // 字符串编码 作为IV
    NSData * ivstrdata = [ivstr dataUsingEncoding:NSUTF8StringEncoding];
    NSData * encData =  [self encryptAESDynamicIV:[self dataUsingEncoding:NSUTF8StringEncoding] key:AES_PSW_AES_KEY iv:ivstrdata];
    // IV 和 数据进行拼接
    NSMutableData * mData = [NSMutableData dataWithData:ivstrdata];
    [mData appendData:encData];
    NSString *encStr = [GTMBase64 stringByEncodingData:mData];
    return encStr;
}

/**< 动态IV 解密方法 */
- (NSString*)decryptAESDynamicIV
{
    // base64 解码转data
    NSData * baseData  = [GTMBase64 decodeString:self];
    // 获取前16位字节（IV）
    NSData * iv = [baseData subdataWithRange:NSMakeRange(0, 16)];
    // 获取剩余字节（Data）
    NSData * data = [baseData subdataWithRange:NSMakeRange(16, baseData.length - 16)];
    // 进行解密
    NSData * decData = [self decryptAESDynamicIV:data key:AES_PSW_AES_KEY iv:iv];
    NSString *decStr = [[NSString alloc] initWithData:decData encoding:NSUTF8StringEncoding];
    return decStr;
}

/**
 *  AES固定IV加密算法
 *
 *  @param plainText      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 */
- (NSData *)encryptAESStaticIV:(NSData *)plainText key:(NSString *)key  iv:(NSString *)iv {
    char keyPointer[kCCKeySizeAES256+2],// room for terminator (unused) ref: https://devforums.apple.com/message/876053#876053
    ivPointer[kCCBlockSizeAES128+2];
    BOOL patchNeeded;
    bzero(keyPointer, sizeof(keyPointer)); // fill with zeroes for padding
    //key = [[StringEncryption alloc] md5:key];
    patchNeeded= ([key length] > kCCKeySizeAES256+1);
    if(patchNeeded)
    {
        key = [key substringToIndex:kCCKeySizeAES256]; // Ensure that the key isn't longer than what's needed (kCCKeySizeAES256)
    }
    
    //NSLog(@"md5 :%@", key);
    [key getCString:keyPointer maxLength:sizeof(keyPointer) encoding:NSUTF8StringEncoding];
    [iv getCString:ivPointer maxLength:sizeof(ivPointer) encoding:NSUTF8StringEncoding];
    
    if (patchNeeded) {
        keyPointer[0] = '\0';  // Previous iOS version than iOS7 set the first char to '\0' if the key was longer than kCCKeySizeAES256
    }
    
    NSUInteger dataLength = [plainText length];
    
    //see https://developer.apple.com/library/ios/documentation/System/Conceptual/ManPages_iPhoneOS/man3/CCryptorCreateFromData.3cc.html
    // For block ciphers, the output size will always be less than or equal to the input size plus the size of one block.
    size_t buffSize = dataLength + kCCBlockSizeAES128;
    void *buff = malloc(buffSize);
    
    size_t numBytesEncrypted = 0;
    // 设置加密参数
    /**
        这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
    */
    //refer to http://www.opensource.apple.com/source/CommonCrypto/CommonCrypto-36064/CommonCrypto/CommonCryptor.h
    //for details on this function
    //Stateless, one-shot encrypt or decrypt operation.
    CCCryptorStatus status = CCCrypt(kCCEncrypt, /* kCCEncrypt, etc. */
                                     kCCAlgorithmAES128, /* kCCAlgorithmAES128, etc. */
                                     kCCOptionPKCS7Padding, /* kCCOptionPKCS7Padding, etc. */
                                     keyPointer, kCCKeySizeAES256, /* key and its length */
                                     ivPointer, /* initialization vector - use random IV everytime */
                                     [plainText bytes], [plainText length], /* input  */
                                     buff, buffSize,/* data RETURNED here */
                                     &numBytesEncrypted);
    if (status == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buff length:numBytesEncrypted];
    }
    
    free(buff);
    return nil;
}

/**
 *  AES固定IV解密算法
 *
 *  @param plainText      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 */
-(NSData *)decryptAESStaticIV:(NSData *)encryptedText key:(NSString *)key iv:(NSString *)iv {
    char keyPointer[kCCKeySizeAES256+2],// room for terminator (unused) ref: https://devforums.apple.com/message/876053#876053
    ivPointer[kCCBlockSizeAES128+2];
    BOOL patchNeeded;
  
    patchNeeded = ([key length] > kCCKeySizeAES256+1);
    if(patchNeeded)
    {
        key = [key substringToIndex:kCCKeySizeAES256]; // Ensure that the key isn't longer than what's needed (kCCKeySizeAES256)
    }

    [key getCString:keyPointer maxLength:sizeof(keyPointer) encoding:NSUTF8StringEncoding];
    [iv getCString:ivPointer maxLength:sizeof(ivPointer) encoding:NSUTF8StringEncoding];

    if (patchNeeded) {
        keyPointer[0] = '\0';  // Previous iOS version than iOS7 set the first char to '\0' if the key was longer than kCCKeySizeAES256
    }
    
    NSUInteger dataLength = [encryptedText length];
    
    //see https://developer.apple.com/library/ios/documentation/System/Conceptual/ManPages_iPhoneOS/man3/CCryptorCreateFromData.3cc.html
    // For block ciphers, the output size will always be less than or equal to the input size plus the size of one block.
    size_t buffSize = dataLength + kCCBlockSizeAES128;
    
    void *buff = malloc(buffSize);
    
    size_t numBytesEncrypted = 0;
    //refer to http://www.opensource.apple.com/source/CommonCrypto/CommonCrypto-36064/CommonCrypto/CommonCryptor.h
    //for details on this function
    //Stateless, one-shot encrypt or decrypt operation.
    CCCryptorStatus status = CCCrypt(kCCDecrypt,/* kCCEncrypt, etc. */
                                     kCCAlgorithmAES128, /* kCCAlgorithmAES128, etc. */
                                     kCCOptionPKCS7Padding, /* kCCOptionPKCS7Padding, etc. */
                                     keyPointer, kCCKeySizeAES256,/* key and its length */
                                     ivPointer, /* initialization vector - use same IV which was used for decryption */
                                     [encryptedText bytes], [encryptedText length], //input
                                     buff, buffSize,//output
                                     &numBytesEncrypted);
    if (status == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buff length:numBytesEncrypted];
    }
    
    free(buff);
    return nil;
}

/**
 *  AES动态IV加密算法
 *
 *  @param plainText      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 */
- (NSData *)encryptAESDynamicIV:(NSData *)plainText key:(NSString *)key  iv:(NSData *)iv {
    char keyPointer[kCCKeySizeAES256+2];// room for terminator (unused) ref: https://devforums.apple.com/message/876053#876053
    BOOL patchNeeded;
    bzero(keyPointer, sizeof(keyPointer)); // fill with zeroes for padding
    //key = [[StringEncryption alloc] md5:key];
    patchNeeded= ([key length] > kCCKeySizeAES256+1);
    if(patchNeeded)
    {
        key = [key substringToIndex:kCCKeySizeAES256]; // Ensure that the key isn't longer than what's needed (kCCKeySizeAES256)
    }
    
    //NSLog(@"md5 :%@", key);
    [key getCString:keyPointer maxLength:sizeof(keyPointer) encoding:NSUTF8StringEncoding];
    
    if (patchNeeded) {
        keyPointer[0] = '\0';  // Previous iOS version than iOS7 set the first char to '\0' if the key was longer than kCCKeySizeAES256
    }
    
    NSUInteger dataLength = [plainText length];
    
    //see https://developer.apple.com/library/ios/documentation/System/Conceptual/ManPages_iPhoneOS/man3/CCryptorCreateFromData.3cc.html
    // For block ciphers, the output size will always be less than or equal to the input size plus the size of one block.
    size_t buffSize = dataLength + kCCBlockSizeAES128;
    void *buff = malloc(buffSize);
    
    size_t numBytesEncrypted = 0;
    //refer to http://www.opensource.apple.com/source/CommonCrypto/CommonCrypto-36064/CommonCrypto/CommonCryptor.h
    //for details on this function
    //Stateless, one-shot encrypt or decrypt operation.
    CCCryptorStatus status = CCCrypt(kCCEncrypt, /* kCCEncrypt, etc. */
                                     kCCAlgorithmAES128, /* kCCAlgorithmAES128, etc. */
                                     kCCOptionPKCS7Padding, /* kCCOptionPKCS7Padding, etc. */
                                     keyPointer, kCCKeySizeAES256, /* key and its length */
                                     [iv bytes], /* initialization vector - use random IV everytime */
                                     [plainText bytes], [plainText length], /* input  */
                                     buff, buffSize,/* data RETURNED here */
                                     &numBytesEncrypted);
    if (status == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buff length:numBytesEncrypted];
    }
    
    free(buff);
    return nil;
}

/**
 *  AES动态IV解密算法
 *
 *  @param plainText      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 */
-(NSData *)decryptAESDynamicIV:(NSData *)encryptedText key:(NSString *)key iv:(NSData *)iv {
    char keyPointer[kCCKeySizeAES256+2];// room for terminator (unused) ref: https://devforums.apple.com/message/876053#876053
    BOOL patchNeeded;
  
    patchNeeded = ([key length] > kCCKeySizeAES256+1);
    if(patchNeeded)
    {
        key = [key substringToIndex:kCCKeySizeAES256]; // Ensure that the key isn't longer than what's needed (kCCKeySizeAES256)
    }

    [key getCString:keyPointer maxLength:sizeof(keyPointer) encoding:NSUTF8StringEncoding];

    if (patchNeeded) {
        keyPointer[0] = '\0';  // Previous iOS version than iOS7 set the first char to '\0' if the key was longer than kCCKeySizeAES256
    }
    
    NSUInteger dataLength = [encryptedText length];
    
    //see https://developer.apple.com/library/ios/documentation/System/Conceptual/ManPages_iPhoneOS/man3/CCryptorCreateFromData.3cc.html
    // For block ciphers, the output size will always be less than or equal to the input size plus the size of one block.
    size_t buffSize = dataLength + kCCBlockSizeAES128;
    
    void *buff = malloc(buffSize);
    
    size_t numBytesEncrypted = 0;
    //refer to http://www.opensource.apple.com/source/CommonCrypto/CommonCrypto-36064/CommonCrypto/CommonCryptor.h
    //for details on this function
    //Stateless, one-shot encrypt or decrypt operation.
    CCCryptorStatus status = CCCrypt(kCCDecrypt,/* kCCEncrypt, etc. */
                                     kCCAlgorithmAES128, /* kCCAlgorithmAES128, etc. */
                                     kCCOptionPKCS7Padding, /* kCCOptionPKCS7Padding, etc. */
                                     keyPointer, kCCKeySizeAES256,/* key and its length */
                                     [iv bytes], /* initialization vector - use same IV which was used for decryption */
                                     [encryptedText bytes], [encryptedText length], //input
                                     buff, buffSize,//output
                                     &numBytesEncrypted);
    if (status == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buff length:numBytesEncrypted];
    }
    
    free(buff);
    return nil;
}



@end
