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
        mapper <<< platform <-- "Cutplatform"
        mapper <<< channel <-- "Cutchannel"
        mapper <<< language <-- "Cutlanguage"
        mapper <<< version <-- "Cutversion"
        mapper <<< token <-- "Cuttoken"
        mapper <<< url <-- "Cuturl"
    }
}

class DeviceLoginModel : HandyJSON {
    
    var IsCheckVersion: Int = 1     // 判断是否审核版本，0-否，1-是
    var display_fb: Int = 0         // 是否隐藏facebook 1 隐藏 0 不隐藏
    var login_type: Int = 0         //  0 没有绑定第三方登录
    var token: String = ""          //  token
    var LogoutAt: Int64 = 0         //  账号删除时间，大于0不让进去
    var id: Int64 = 0
    var login_status: Int = 0         //  1-表示游客登录
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< IsCheckVersion <-- "CutIsCheckVersion"
        mapper <<< display_fb <-- "Cutdisplay_fb"
        mapper <<< login_type <-- "Cutlogin_type"
        mapper <<< token <-- "Cuttoken"
        mapper <<< LogoutAt <-- "CutLogoutAt"
        mapper <<< id <-- "Cutid"
        mapper <<< login_status <-- "Cutlogin_status"
    }
}

class AdModel : HandyJSON {
    
    var type:Int = 0  // 1穿山甲，2谷歌，3applovin
    var id: String = ""// 默认广告位ID
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< type <-- "Cuttype"
        mapper <<< id <-- "Cutid"
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
    
    var CutInvitationCodeReward: Int = 0
    var CutLevelStar: String = ""// 关卡星星
    var CutGetPointsStars: Int = 0//领积分所需扣除星星
    var CutGetPointsFriends: Int = 0//领积分所需邀请人数
    var CutVIPUpGradeFriends: String = ""//VIP帮助人数等级对应
    var CutCashAmount: Int = 0//VIP帮助人数等级对应
    var CutRestartFriends: Int = 0//重启5倍积分活动所需邀请人数
    var CutFreeRestartTimes: Int = 0//超过重置次数需要观看视频
    var CutIx1: Int = 0//下线获得到的钻石
    var CutIx2: Int = 0//下线获得到的vip经验
    var CutGetEnergyNumber: Int = 0//每日体力可购买数
    var CutGetEnergyTimes: Int = 0//每次买到的体力
    //等于1显示弹窗
    var CutIndexPop: Int = 0
    //关卡倒计时时间
    var CutLevelTime: Int = 0
        required init() {
            
        }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< MonetaryUnit <-- "CutMonetaryUnit"
        mapper <<< USDExchangRate <-- "CutUSDExchangRate"
        mapper <<< invite_id <-- "Cutinvite_id"
        mapper <<< InviteID <-- "CutInviteID"
        mapper <<< SendEvaluate <-- "CutSendEvaluate"
        mapper <<< FBCustomerServiceNumber <-- "CutFBCustomerServiceNumber"
        mapper <<< MoneyLock <-- "CutMoneyLock"
        mapper <<< VIPLevel <-- "CutVIPLevel"
        mapper <<< homeId <-- "Cutid"
        mapper <<< money <-- "Cutmoney"
        mapper <<< gold <-- "Cutgold"
        mapper <<< level <-- "Cutlevel"
        mapper <<< avatar <-- "Cutavatar"
        mapper <<< nickname <-- "Cutnickname"
        mapper <<< OfflineReward <-- "CutOfflineReward"
        mapper <<< OfflineRewardBase <-- "CutOfflineRewardBase"
        mapper <<< OfflineRewardHigh <-- "CutOfflineRewardHigh"
        mapper <<< UpdateSwitch <-- "CutUpdateSwitch"
        mapper <<< VersionUpgradeDesc <-- "CutVersionUpgradeDesc"
        mapper <<< VersionUpgradeDesc2 <-- "CutVersionUpgradeDesc2"
        mapper <<< LatestVersion <-- "CutLatestVersion"
        mapper <<< MustUpdateVersionStatus <-- "CutMustUpdateVersionStatus"
        mapper <<< RewardPerPerson <-- "CutRewardPerPerson"
        mapper <<< InvitationLevelReward <-- "CutInvitationLevelReward"
        mapper <<< share_url <-- "Cutshare_url"
        mapper <<< login_type <-- "Cutlogin_type"
        mapper <<< ReviewVersion <-- "CutReviewVersion"
        mapper <<< country <-- "Cutcountry"
        mapper <<< GoldPrice <-- "CutGoldPrice"
        mapper <<< Banknote1 <-- "CutBanknote1"
        mapper <<< MaxWithdrawalTimesPerDay <-- "CutMaxWithdrawalTimesPerDay"
        mapper <<< WithdrawMoney <-- "CutWithdrawMoney"
        mapper <<< BroadcastMinCash <-- "CutBroadcastMinCash"
        mapper <<< FullVideoIdFinal <-- "CutFullVideoIdFinal"
        mapper <<< BroadcastMinCash <-- "CutVideoIdFinal"
        mapper <<< af_ads_config <-- "Cutaf_ads_config"
        mapper <<< af_island_config <-- "Cutaf_island_config"
        mapper <<< MaxVideoAd <-- "CutMaxVideoAd"
        mapper <<< UpdateVersionRewardGold <-- "CutUpdateVersionRewardGold"
        
        
        mapper <<< ProbabilitySpecialEvents <-- "CutProbabilitySpecialEvents"
        mapper <<< DailyStars <-- "CutDailyStars"
        mapper <<< MaxEnergy <-- "CutMaxEnergy"
        mapper <<< EnergyInterval <-- "CutEnergyInterval"
        mapper <<< BindingReward <-- "CutBindingReward"
        mapper <<< RobStatus <-- "CutRobStatus"
        mapper <<< diamond <-- "Cutdiamond"
        mapper <<< AchievementStars <-- "CutAchievementStars"
        mapper <<< PointRaceCash <-- "CutPointRaceCash"
        mapper <<< VIPCash <-- "CutVIPCash"
        mapper <<< CirculateLevel <-- "CutCirculateLevel"
    }
}









