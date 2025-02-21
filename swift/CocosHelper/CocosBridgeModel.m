//
//  CocosBridgeModel.m
//  AngryMan
//
//  Created by 7x on 2023/11/10.
//

#import "CocosBridgeModel.h"
@implementation CocosBridgeModel

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dict];
    self = [super initWithDictionary:dic error:err];
    if (self) {
        
    }
    return  self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    [self setValue:@(0.f) forKey:@"addmoney"];
//    [self setValue:@(0.f) forKey:@"reducemoney"];
//    [self setValue:@(0.f) forKey:@"vip_money"];
}

@end
