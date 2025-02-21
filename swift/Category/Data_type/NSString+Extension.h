//
//  NSString+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
/*
    给金额字符串添加分割标示，例：33，345，434.98
 */
+(NSString *)ResetAmount:(NSString *)Amount_str segmentation_index:(int)segmentation_index segmentation_str:(NSString *)segmentation_str;


/*
 获取当前系统语言
 */
+(NSString *)getSystemLanguage;
/**
 *  @brief  掉头反转字符串
 */
- (NSString *)StringReverse;
//编码反编码
-(NSString *)EncodingString;
-(NSString *)RemovingEncoding;

#pragma mark - string of size
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font andMaxW:(CGFloat)maxW;
#pragma mark - nil NULL "space"
+(BOOL)isNULL:(id)string;
#pragma md5
- (NSString *)MD5string;
/*
   把JSON格式的字符串转换成字典
 */
- (NSDictionary *)StringOfJsonConversionDictionary;
/**
 *  字符串添加图片
 */
-(NSMutableAttributedString *)insertImg:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect;
/**
 *  不同颜色不同字体大小字符串
 */
-(NSMutableAttributedString *)setOtherColor:(UIColor *)Color font:(UIFont*)font forStr:(NSString *)forStr;
/*
    在文字上添加删除线（例如过去的价格）
 */
-(NSAttributedString *)AddRemoveLineOnStringRange:(NSRange )range lineWidth:(NSInteger )lineWidth;

- (BOOL)isChinese;
- (NSString *)pinyin;
- (NSString *)pinyinInitial;

/*
单位转换
 */
+(NSString *)unitConversionNum:(CGFloat)num isUnit:(BOOL)unit isFormat:(BOOL)format;
+(NSString *)unitConversionNumInt:(NSInteger)num isUnit:(BOOL)unit isFormat:(BOOL)format;


/** 复制内容到粘贴板 */
+(void)copyToUIPasteboard:(NSString *)value;

/** 读取粘贴板*/
+(NSString *)readUIPasteboardString;

/*
多语言翻译，替换文本
 */
//- (NSString *)replaceString:(NSArray *)replacements;

// 金币兑换成钱格式计算
+ (NSString *)Exchangecalculation:(float)gold rate:(int)rate unit:(NSString *)unit;

// 字符串前添加图标
- (NSMutableAttributedString *)StringWithAddIcon:(UIImage *)image andImageFrame:(CGRect)frame index:(NSInteger)index;
-(NSMutableAttributedString *)foregroundColorSpan:(UIColor *)Color forStr:(NSArray *)forStrs;

- (BOOL)isEmail;
- (BOOL)isPhoneNumber;
- (BOOL)isDigit;
- (BOOL)isNumeric;
- (BOOL)isUrl;
- (BOOL)isMinLength:(NSUInteger)length;
- (BOOL)isMaxLength:(NSUInteger)length;
- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max;
- (BOOL)isEmpty;

@end
