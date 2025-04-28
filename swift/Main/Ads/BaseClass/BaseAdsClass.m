//
//  BaseAdsClass.m
//  TestAA-mobile
//
//  Created by qf on 2020/12/2.
//

#import "BaseAdsClass.h"
#pragma 反射类 需要的参数 --start
NSString *const Google_TypeName   = @"2";
NSString *const CSJ_TypeName      = @"1";
NSString *const AppLovin_TypeName = @"3";
NSString *const FaceBook_TypeName = @"5";

//广告类型
NSString *const Reward_Type     = @"RewardVideo"; //激励视频
NSString *const FullScreenVideo_Type   = @"FullScreenVideo"; // 全屏广告

//类名前缀（广告平台）
NSString *const Base_Platfrom     = @"Base";
NSString *const Google_Platfrom   = @"Google";
NSString *const CSJ_Platfrom      = @"CSJ";
NSString *const AppLovin_Platfrom = @"AppLovin";
NSString *const FaceBook_Platfrom = @"FaceBook";


@implementation BaseAdsClass

-(id)initWithObj
{
    self = [super init];
    if (self) {

        //获取反射类前缀
        if ([self.adType isEqualToString:Google_TypeName])
        {
            self.platformType = Google_Platfrom;
        }
        else if ([self.adType isEqualToString:CSJ_TypeName])
        {
            self.platformType = CSJ_Platfrom;
        }
        else if ([self.adType isEqualToString:AppLovin_TypeName])
        {
            self.platformType = AppLovin_Platfrom;
        }
        
    }
    return self;
}

//
+(void)FactoryWithAdPlatfrom:(NSString *)platfrom andType:(NSString *)type andIsShow:(BOOL)isShowFuc andParameter:(NSString *)parameter andVC:(UIViewController *)vc
{
    //添加是否为show方法判断参数，来区别是否自动展示
    NSDictionary * dict = [parameter StringOfJsonConversionDictionary];
    [dict setValue:@(isShowFuc) forKey:@"isShowFuc"];
    [dict setValue:@"" forKey:@"cpmStr"];
    parameter = [dict DictionaryConversionStringOfJson];
    
    NSString * classStr = [NSString stringWithFormat:@"%@%@",platfrom,type];
    id obj = [[NSClassFromString(classStr) alloc]init];
    [obj ReflexSetValueParameter:parameter andVC:vc];
    [obj initWithObj];
    NSLog(@"BaseAdsClass-----platfrom:-%@----type:-%@---parameter:-%@------obj:%@ ------",platfrom,type,parameter,obj);
}

//反射赋值
-(void)ReflexSetValueParameter:(NSString *)parameter andVC:(UIViewController *)vc
{
    self.json = parameter;
    self.vc   = vc;
    //反射 遍历类属性 赋值
    if (![NSString isNULL:parameter]) {
        NSDictionary * dict = [parameter StringOfJsonConversionDictionary];
        NSArray * PropertyList = getAllProperty([self class], [NSObject class]);
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString * value, BOOL * _Nonnull stop) {
            for (int i = 0; i < PropertyList.count; i ++ ) {
                if ([key isEqualToString:PropertyList[i]] && value != nil) {
                    NSLog(@"ReflexSetValueParameter-self:-%@--key--%@---value--%@",self,key,value);
                    [self setValue:value forKey:key];
                }
            }
        }];
        NSLog(@"BaseAdsClass-----platfrom:-%@-----------self:%@ ------",parameter,self);
    }
}

/**
 获取指定类（以及其父类）的所有属性
 
 @param cls 被获取属性的类
 @param until_class 当查找到此类时会停止查找，当设置为 nil 时，默认采用 [NSObject class]
 @return 属性名称 [NSString *]
 */
NSArray * getAllProperty(Class cls, Class until_class) {
    
    Class stop_class = until_class ?: [NSObject class];
    
    //当前类 == NSobject 直接return
    if (cls == stop_class) return @[];
    
    NSMutableArray * all_p = [NSMutableArray array];
    
    [all_p addObjectsFromArray:getClassProperty(cls)];
    
    if (class_getSuperclass(cls) == stop_class) {
        return [all_p copy];
    } else {
        [all_p addObjectsFromArray:getAllProperty([cls superclass], stop_class)];
    }
    
    return [all_p copy];
}

/**
 获取指定类的属性
 
 @param cls 被获取属性的类
 @return 属性名称 [NSString *]
 */
NSArray * getClassProperty(Class cls) {
    
    if (!cls) return @[];
    
    NSMutableArray * all_p = [NSMutableArray array];
    
    unsigned int a;
    
    objc_property_t * result = class_copyPropertyList(cls, &a);
    
    for (unsigned int i = 0; i < a; i++) {
        objc_property_t o_t =  result[i];
        [all_p addObject:[NSString stringWithFormat:@"%s", property_getName(o_t)]];
    }
    
    free(result);
    
    return [all_p copy];
}

@end
