//
//  CocosBridgeModel.h
//  AngryMan
//
//  Created by 7x on 2023/11/10.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CocosBridgeModel : JSONModel

// 事件类型 与 CocosBridgeAction 枚举匹配
@property (nonatomic, strong) NSString<Optional>  *type;
// 获取参数名称
@property (nonatomic, strong) NSString<Optional> * PrametersName;


// 互动任务需要的参数 id link interactive_reward
@property (nonatomic, strong) NSString<Optional> * id;
@property (nonatomic, strong) NSString<Optional> * link;
@property (nonatomic, strong) NSString<Optional> * interactiveReward;




@end

NS_ASSUME_NONNULL_END
