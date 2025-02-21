//
//  NSString+Extension.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//
#if TARGET_IPHONE_SIMULATOR
#define kAppleLanguages(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-US"] ? Chinese : English
#elif TARGET_OS_IPHONE
#define kAppleLanguages(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"] ? Chinese : English
#endif

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import "OCProgressHUD.h"
@implementation NSString (Extension)
+(NSString *)ResetAmount:(NSString *)Amount_str segmentation_index:(int)segmentation_index segmentation_str:(NSString *)segmentation_str
{
    if ([NSString isNULL:Amount_str]) {
        return Amount_str;
    }
    
    NSArray *array_str = [Amount_str componentsSeparatedByString:@"."];
    
    NSString *num_str = array_str.count > 1 ? array_str[0] : Amount_str;
    
    int count = 0;
    long long int a = num_str.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num_str];
    NSMutableString *newstring = [NSMutableString string];
    while (count > segmentation_index) {
        count -= segmentation_index;
        NSRange rang = NSMakeRange(string.length - segmentation_index, segmentation_index);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:segmentation_str atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    
    return array_str.count > 1 ? [NSString stringWithFormat:@"%@.%@",newstring,array_str[1]] : newstring;
}

-(NSAttributedString *)AddRemoveLineOnStringRange:(NSRange )range lineWidth:(NSInteger )lineWidth {
    
    NSMutableAttributedString *temp_attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    [temp_attributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSString stringWithFormat:@"%ld",(long)lineWidth] range:range];
    return temp_attributedStr;
}

/*
 获取当前系统语言
 */
+(NSString *)getSystemLanguage
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    NSLog(@"getSystemLanguage----%@",preferredLang);
    return preferredLang;
}

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
- (NSString *)StringReverse
{
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [self length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[self substringWithRange:subStrRange]];
    }
    return reverseString;
}

-(NSString *)EncodingString
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
}
-(NSString *)RemovingEncoding
{
    return [self stringByRemovingPercentEncoding];
    
}

- (NSDictionary *)StringOfJsonConversionDictionary {
    
    if ([NSString isNULL:self]) {
        
        return nil;
        
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError;
    
    NSDictionary *Dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&parseError];
    
    if(parseError) {
        
        return nil;
    }
    
    return Dictionary;
    
}



- (NSString *)MD5string
{
    if ([NSString isNULL:self]) {
        return @"";
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    //CC_MD5(value, strlen(value), outputBuffer);
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}


-(NSMutableAttributedString *)setOtherColor:(UIColor *)Color font:(UIFont*)font forStr:(NSString *)forStr
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]init];
    
    if (![NSString isNULL:self]) {
        
        NSMutableString *temp = [NSMutableString stringWithString:self];
        
        NSRange range = [temp rangeOfString:forStr];
        
        str = [[NSMutableAttributedString alloc] initWithString:temp];
        [str addAttribute:NSForegroundColorAttributeName value:Color range:range];
        if (font) {
            
            [str addAttribute:NSFontAttributeName value:font range:range];
        }
        
    }
    return str;
    
    
}

-(NSMutableAttributedString *)insertImg:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect
{
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self];
    
    if (![NSString isNULL:self] && index <= self.length - 1) {
        
        NSTextAttachment *attatchment = [[NSTextAttachment alloc] init];
        attatchment.image = Img;
        attatchment.bounds = IMGrect;
        [attributedText insertAttributedString:[NSAttributedString attributedStringWithAttachment:attatchment] atIndex:index];
    }
    
    return attributedText;
    
    
}




- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
- (NSString *)pinyin
{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)pinyinInitial
{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSArray *word = [str componentsSeparatedByString:@" "];
    NSMutableString *initial = [[NSMutableString alloc] initWithCapacity:str.length / 3];
    for (NSString *str in word) {
        [initial appendString:[str substringToIndex:1]];
    }
    return initial;
}
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
    
    
}
- (CGSize)sizeWithFont:(UIFont *)font andMaxW:(CGFloat)maxW
{
    return [self sizeWithFont:font maxW:maxW];
    
    
}


//+(NSString *)unitConversionNum:(CGFloat)num isUnit:(BOOL)unit isFormat:(BOOL)format
//{
//    
//    CGFloat countnum = num;
//    CGFloat value = 0;
//    NSString * result = [NSString stringWithFormat:@"%lf",countnum];
//    NSString * monetaryUnit = unit ? [LoginHelper sharedLoginHelper].userModel.MonetaryUnit : @"";
//    if (format) {
//        if (countnum < 10000) {
//            result = [NSString stringWithFormat:@"%@%@",monetaryUnit,[NSString formatFloatNumber:countnum]];
//        }
//        
//        else if (countnum < 1000000) {
//            
//            value = countnum/1000;
//            result = [NSString stringWithFormat:@"%@%@K",monetaryUnit,[NSString formatFloatNumber:value]];
//        }
//        else
//        {
//            value = countnum/1000000;
//            result = [NSString stringWithFormat:@"%@%@M",monetaryUnit,[NSString formatFloatNumber:value]];
//        }
//    }
//    else
//    {
//        result = [NSString stringWithFormat:@"%@%@",monetaryUnit,[NSString formatFloatNumber:countnum]];
//    }
//    
//    return  result;
//}
//
//+(NSString *)unitConversionNumInt:(NSInteger)num isUnit:(BOOL)unit isFormat:(BOOL)format
//{
//    NSInteger countnum = num;
//    NSInteger value = 0;
//    NSString * result = [NSString stringWithFormat:@"%ld",countnum];
//    NSString * monetaryUnit = unit ? userma : @"";
//    if (format) {
//        if (countnum < 10000) {
//            result = [NSString stringWithFormat:@"%@%ld",monetaryUnit,countnum];
//        }
//        
//        else if (countnum < 1000000) {
//            
//            value = countnum/1000;
//            result = [NSString stringWithFormat:@"%@%ldK",monetaryUnit,value];
//        }
//        else
//        {
//            value = countnum/1000000;
//            result = [NSString stringWithFormat:@"%@%ldM",monetaryUnit,value];
//        }
//    }
//    else
//    {
//        result = [NSString stringWithFormat:@"%@%@",monetaryUnit,[NSString formatFloatNumber:countnum]];
//    }
//    return  result;
//}


+ (NSString *)formatFloatNumber:(float)number {

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2]; // 设置保留的小数位数
    // 强制使用小数点作为小数分隔符
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"US"]];
//    NSString *formattedNumber = [numberFormatter stringFromNumber:@(number)];
    NSString *formattedNumber = [NSString stringWithFormat:@"%f",number];
//    if (number < 0) {
//        return @"0";
//    }

    // 去掉末尾的零
    while ([formattedNumber hasSuffix:@"0"]) {
        formattedNumber = [formattedNumber substringToIndex:formattedNumber.length - 1];
    }
    
    // 去掉末尾的小数点
    if ([formattedNumber hasSuffix:@"."]) {
        formattedNumber = [formattedNumber substringToIndex:formattedNumber.length - 1];
    }
    
    return formattedNumber;
}



/** 复制内容到粘贴板 */
+(void)copyToUIPasteboard:(NSString *)value
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = value;
}

/** 读取粘贴板*/
+(NSString *)readUIPasteboardString
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    return pasteboard.string;
}

+ (NSString *)Exchangecalculation:(float)gold rate:(int)rate unit:(NSString *)unit
{
    
    // 提现 UI 数据展示处理
    int goldToDollars = rate;
    float value = gold ;
    if (goldToDollars > 0) {
        value = gold / goldToDollars;
    }
    NSString * valuestr;
    NSString * labelText;
    if ([unit isEqualToString:@"Rp"])
    {
        valuestr = [NSString stringWithFormat:@"%.0f",value];
        labelText = [NSString stringWithFormat:@"%@%@",unit,valuestr];
        return labelText;
        
    }
    else if([unit isEqualToString:@"Shib"])
    {
        valuestr = [NSString stringWithFormat:@"%.0f",value];
        labelText = [NSString stringWithFormat:@"%@%@",unit,valuestr];
        return labelText;
    }
    
    
    // value 小数点前1位大于0 并且小数点后第一位为0 保留1位，否则取2位
    valuestr = [NSString stringWithFormat:@"%.2f",value];
    NSArray *  valueArr = [valuestr componentsSeparatedByString:@"."];
    NSString * valuestr1= valueArr[0];
    NSString * valuestr2= valueArr[1];
    //    NSString* number=@"^[0-9]+[1-9]"
    //    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    
    if ([NSString validateWithRegExp:@"^[0-9][1-9]$" str:valuestr2] || [NSString validateWithRegExp:@"^[1-9][1-9]$" str:valuestr2]) {
        
        labelText = [NSString stringWithFormat:@"%@",valuestr];
    }
    else if([NSString validateWithRegExp:@"^[1-9]0$" str:valuestr2])
    {
        labelText = [NSString stringWithFormat:@"%.1f",value];
    }
    else if([NSString validateWithRegExp:@"^00$" str:valuestr2])
    {
        labelText = [NSString stringWithFormat:@"%.0f",value];
    }
    
    //    if ([valuestr1 intValue] > 1 && [valuestr2 intValue] > 1) {
    //        if ([valuestr2 intValue] == 10)
    //        {
    //            labelText = [NSString stringWithFormat:@"%@%.1f",unit,value];
    //        }
    //        else
    //        {
    //            labelText = [NSString stringWithFormat:@"%@%@",unit,valuestr];
    //        }
    //    }
    //    else if ([valuestr1 intValue] < 1 && [valuestr2 intValue] > 1)
    //    {
    //
    //        labelText = [NSString stringWithFormat:@"%@%@",unit,valuestr];
    //    }
    //    else
    //    {
    //        labelText = [NSString stringWithFormat:@"%@%.0f",unit,value];
    //    }
    
    return [NSString stringWithFormat:@"%@%@",unit,labelText];
}

- (NSMutableAttributedString *)StringWithAddIcon:(UIImage *)image andImageFrame:(CGRect)frame index:(NSInteger)index;
{
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:self];
    NSTextAttachment *attch1 = [[NSTextAttachment alloc] init];
    attch1.image = image;
    attch1.bounds = frame;
    NSAttributedString *string1 = [NSAttributedString attributedStringWithAttachment:attch1];
    [attri1 insertAttributedString:string1 atIndex:index];
    return attri1;
}

+(BOOL)validateWithRegExp:(NSString *)regExp str:(NSString *)str
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regExp];
    return [predicate evaluateWithObject:str];
}



+(BOOL)isNULL:(id)string{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}





- (BOOL)isEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)isPhoneNumber {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber error:nil];
    return [detector numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
}

- (BOOL)isDigit {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    return [alphaNums isSupersetOfSet:inStringSet];
}

- (BOOL)isNumeric {
    NSString *regex = @"([0-9])+((\\.|,)([0-9])+)?";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)isUrl {
    NSString *regex = @"https?:\\/\\/[\\S]+";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)isMinLength:(NSUInteger)length {
    return (self.length >= length);
}

- (BOOL)isMaxLength:(NSUInteger)length {
    return (self.length <= length);
}

- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max {
    return ([self isMinLength:min] && [self isMaxLength:max]);
}

- (BOOL)isEmpty {
    return (!self.length);
}

//- (NSString *)replaceString:(NSArray *)replaceStrs
//{
//    if ([NSString isNULL:self]) {
//        return @"";
//    }
//    NSMutableString * mutableStr = [NSMutableString string];
//    NSArray * strs = [self componentsSeparatedByString:@"%d"];
//    if (strs.count != replaceStrs.count+1) {
//        [OCProgressHUD showProgressTipHUDInView:[UIApplication sharedApplication].keyWindow withText:self afterDelay:2];
//        return self;
//    }
//    NSInteger index = 0;
//    [mutableStr appendString:strs[index]];
//    for (NSString * str in replaceStrs) {
//        index++;
//        [mutableStr appendString:[NSString stringWithFormat:@"%@%@",strs[index],str]];
//        
//    }
//    
//    return mutableStr;
//}


-(NSMutableAttributedString *)foregroundColorSpan:(UIColor *)Color forStr:(NSArray *)forStrs
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self];

    if (![NSString isNULL:self]) {

        NSString * message = self.lowercaseString;
        NSInteger startIndex = 0;
        NSMutableString *mStyledText = [NSMutableString stringWithString:message];
        for (NSString * appointStr in forStrs) {
            NSString * searchmessage = appointStr.lowercaseString;
            NSRange range = [[message substringFromIndex:startIndex] rangeOfString:searchmessage];
            if (range.location != NSNotFound) {
                 startIndex +=range.location;
                if (startIndex >= 0 && (startIndex + searchmessage.length) <= mStyledText.length) {

                    [str addAttribute:NSForegroundColorAttributeName value:Color range:NSMakeRange(startIndex,  range.length)];
                    startIndex =range.location + range.length;

                } else {
                    NSLog(@"String not found");
                }
            }
        }
    }
    return str;
    

    
}


@end
