//
//  UserModel.swift
//  swift
//
//  Created by 7x on 2023/12/15.
//

import HandyJSON

class HeaderModel : HandyJSON {
    
    var platform:String = ""
    var channel: String = ""
    var language: String = ""
    var version: String = ""
    var token: String = ""
    var url: String = ""
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< platform <-- "Manplatform"
        mapper <<< channel <-- "Manchannel"
        mapper <<< language <-- "Manlanguage"
        mapper <<< version <-- "Manversion"
        mapper <<< token <-- "Mantoken"
        mapper <<< url <-- "Manurl"
    }
}

class DeviceLoginModel : HandyJSON {
    
    var display_fb: Int = 0         // 是否隐藏facebook 1 隐藏 0 不隐藏
    var login_type: Int = 0         //  0 没有绑定第三方登录
    var token: String = ""          //  token
    var LogoutAt: Int64 = 0         //  账号删除时间，大于0不让进去
    var id: Int64 = 0
    var login_status: Int = 0         //  1-表示游客登录
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< display_fb <-- "Mandisplay_fb"
        mapper <<< login_type <-- "Manlogin_type"
        mapper <<< token <-- "Mantoken"
        mapper <<< LogoutAt <-- "ManLogoutAt"
        mapper <<< id <-- "Manid"
        mapper <<< login_status <-- "Manlogin_status"
    }
}

class AdModel : HandyJSON {
    
    var type:Int = 0  // 1穿山甲，2谷歌，3applovin
    var id: String = ""// 默认广告位ID
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< type <-- "Mantype"
        mapper <<< id <-- "Manid"
    }
}

class UserModel : HandyJSON {
    
    var MonetaryUnit: String = ""// 现金单位
    var homeId: Int64 = 0 //用户ID
    var USDExchangRate: String = ""// 美元汇率
    var invite_id: Int64 = 0
    var InviteID: Int64 = 0 // 大于0表示有上级
    var money: Float = 0// 用户现金
    var gold: Int64 = 0// 用户金币
    var level: Int64 = 0// 用户等级
    var avatar: String = ""// 用户头像
    var nickname: String = ""// 用户昵称
    // 用户冻结的钞票
    var MoneyLock: Float?  = 0
    var UpdateVersionRewardGold: Int64 = 0 // 更新版本奖励
    // VIP 等级
    var VIPLevel: Int64 = 0
    var OfflineReward: Int64 = 0// 是否离线奖励，0-否，1-是
    var OfflineRewardBase: Int64 = 0// 离线奖励不看视频奖励值，后面需要传到领取的接口
    var OfflineRewardHigh: Int64 = 0// 离线奖励看视频奖励值，后面需要传到领取的接口
    // 更新升级
    var UpdateSwitch: Int = 0 // 1 开 0 关
    var VersionUpgradeDesc: String = ""
    var VersionUpgradeDesc2: String = ""
    var LatestVersion: String = ""
    var MustUpdateVersionStatus: Int = 0
    var RewardPerPerson: Float = 0// 邀请一个人奖励金额(仅提供给我的 页面使用)
    var RewardCashPerPerson: Float = 0// 邀请一个人奖励余额(仅提供给我的 页面使用)
    var share_url: String = ""// 分享url
    var login_status: Int = 0         //  1-表示游客登录
    var ReviewVersion: Int = 0  // 审核版本（1表示是审核版本）
    // 国家id
    var country: Int = 0
    // 金币提现兑换比例
    var GoldPrice: Int64 = 0
    // 最小体现金额
    var Banknote1: Int64 = 0
    //每天最多提现次数
    var MaxWithdrawalTimesPerDay: Int = 0
    // 累计提现
    var WithdrawMoney: Float = 0
    // 提现会广播的最小金额
    var BroadcastMinCash: Float = 0
    var login_type: String = ""//“facebook”、“google”登录类型
    var FBCustomerServiceNumber: String = ""//FB客服号
    var InvitationLevelReward: String = ""// 邀请规则分段奖励
    var SendEvaluate: Int64 = 0// 评价弹窗开关 1 开 0 关
    var FullVideoIdFinal: AdModel = AdModel() // 插屏默认广告位
    var VideoIdFinal: AdModel = AdModel()// 激励视频默认广告
    var af_ads_config: String = ""// 视频次数打点配置
    var af_island_config: String = ""// 过关打点
    /**
     * 谷歌广告限制时间戳
     */
    var google_block_at: Int64 = 0
    var MaxVideoAd: Int64 = 0
    
    // 游戏
    var ProbabilitySpecialEvents: Int = 0
    var DailyStars: Int = 0
    var MaxEnergy: Int = 0
    var EnergyInterval: Int = 0
    var BindingReward: Int64 = 0
    var RobStatus: Int = 0
    var diamond: Int64 = 0
    var AchievementStars: Int64 = 0
    var PointRaceCash: Int64 = 0
    var VIPCash: Int64 = 0
    var CirculateLevel: Int = 0
    
    var ManInvitationCodeReward: Int = 0
    var ManLevelStar: String = ""// 关卡星星
    var ManGetPointsStars: Int = 0//领积分所需扣除星星
    var ManGetPointsFriends: Int = 0//领积分所需邀请人数
    var ManVIPUpGradeFriends: String = ""//VIP帮助人数等级对应
    var ManCashAmount: Int = 0//VIP帮助人数等级对应
    var ManRestartFriends: Int = 0//重启5倍积分活动所需邀请人数
    var ManFreeRestartTimes: Int = 0//超过重置次数需要观看视频
    var ManIx1: Int = 0//下线获得到的钻石
    var ManIx2: Int = 0//下线获得到的vip经验
    var ManGetEnergyNumber: Int = 0//每日体力可购买数
    var ManGetEnergyTimes: Int = 0//每次买到的体力
    //等于1显示弹窗
    var ManIndexPop: Int = 0
    //关卡倒计时时间
    var ManLevelTime: Int = 0
    
     // 无敌关卡
     var ManInvincibleLevel: String = ""

      //特殊任务入口显示
     var ManButtonShowGold: Int64 = 0

      //邀请页面金钱显示
     var ManRewardCashPerPerson: Float = 0

      //宝箱最佳奖励存钱罐金币
     var ManLevelBoxRewards: Int64 = 0
      //宝箱奖励钻石
     var ManLevelBoxDiamond: Int64 = 0
      //关卡钞票
     var ManLevelRewards: Float = 0
       //互动任务奖励
     var ManInteractActive: Int64 = 0
      //累计活跃总奖励
     var ManTotalActiveRewards: Int64 = 0

      //帽子皮肤
     var ManSkin: String = ""

      //鞋子皮肤
     var ManSkin2: String = ""

      //道具等级
     var ManLevelProp: Int = 0

      //砸罐能获得的金币
     var ManSmashingCansGolds: Int64 = 0

      //特殊任务见面礼金
     var ManFirstGift: Int64 = 0
    
    var ManMoneyItem: String = ""//金钱道具加成
    var ManGoldItem: String = ""//金币道具加成

      //重启时新的砸罐次数
     var ManSmashingCansNewTimes: Int = 0
        required init() {
            
        }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< MonetaryUnit <-- "ManMonetaryUnit"
        mapper <<< USDExchangRate <-- "ManUSDExchangRate"
        mapper <<< invite_id <-- "Maninvite_id"
        mapper <<< InviteID <-- "ManInviteID"
        mapper <<< SendEvaluate <-- "ManSendEvaluate"
        mapper <<< FBCustomerServiceNumber <-- "ManFBCustomerServiceNumber"
        mapper <<< MoneyLock <-- "ManMoneyLock"
        mapper <<< VIPLevel <-- "ManVIPLevel"
        mapper <<< homeId <-- "Manid"
        mapper <<< money <-- "Manmoney"
        mapper <<< gold <-- "Mangold"
        mapper <<< level <-- "Manlevel"
        mapper <<< avatar <-- "Manavatar"
        mapper <<< nickname <-- "Mannickname"
        mapper <<< OfflineReward <-- "ManOfflineReward"
        mapper <<< OfflineRewardBase <-- "ManOfflineRewardBase"
        mapper <<< OfflineRewardHigh <-- "ManOfflineRewardHigh"
        mapper <<< UpdateSwitch <-- "ManUpdateSwitch"
        mapper <<< VersionUpgradeDesc <-- "ManVersionUpgradeDesc"
        mapper <<< VersionUpgradeDesc2 <-- "ManVersionUpgradeDesc2"
        mapper <<< LatestVersion <-- "ManLatestVersion"
        mapper <<< MustUpdateVersionStatus <-- "ManMustUpdateVersionStatus"
        mapper <<< RewardPerPerson <-- "ManRewardPerPerson"
        mapper <<< InvitationLevelReward <-- "ManInvitationLevelReward"
        mapper <<< share_url <-- "Manshare_url"
        mapper <<< login_type <-- "Manlogin_type"
        mapper <<< ReviewVersion <-- "ManReviewVersion"
        mapper <<< country <-- "Mancountry"
        mapper <<< GoldPrice <-- "ManGoldPrice"
        mapper <<< Banknote1 <-- "ManBanknote1"
        mapper <<< MaxWithdrawalTimesPerDay <-- "ManMaxWithdrawalTimesPerDay"
        mapper <<< WithdrawMoney <-- "ManWithdrawMoney"
        mapper <<< BroadcastMinCash <-- "ManBroadcastMinCash"
        mapper <<< FullVideoIdFinal <-- "ManFullVideoIdFinal"
        mapper <<< BroadcastMinCash <-- "ManVideoIdFinal"
        mapper <<< af_ads_config <-- "Manaf_ads_config"
        mapper <<< af_island_config <-- "Manaf_island_config"
        mapper <<< MaxVideoAd <-- "ManMaxVideoAd"
        mapper <<< UpdateVersionRewardGold <-- "ManUpdateVersionRewardGold"
        
        
        mapper <<< ProbabilitySpecialEvents <-- "ManProbabilitySpecialEvents"
        mapper <<< DailyStars <-- "ManDailyStars"
        mapper <<< MaxEnergy <-- "ManMaxEnergy"
        mapper <<< EnergyInterval <-- "ManEnergyInterval"
        mapper <<< BindingReward <-- "ManBindingReward"
        mapper <<< RobStatus <-- "ManRobStatus"
        mapper <<< diamond <-- "Mandiamond"
        mapper <<< AchievementStars <-- "ManAchievementStars"
        mapper <<< PointRaceCash <-- "ManPointRaceCash"
        mapper <<< VIPCash <-- "ManVIPCash"
        mapper <<< CirculateLevel <-- "ManCirculateLevel"
    }
}









