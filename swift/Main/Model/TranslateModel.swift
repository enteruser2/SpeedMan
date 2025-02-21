//
//  TranslateModel.swift
//  swift
//
//  Created by 7var X on 2023/12/16.
//

import HandyJSON

class TranslateModel : HandyJSON {
    
    var t101:String = "" //登录
    var t102:String = "" //FaceBook登录
    var t103:String = "" //Google登录
    
    //我的
    var Cutt2110:String = "" //我的
    var Cutt2101:String = "" //提款
    var Cutt2102:String = "" //每邀请一个好友
    var Cutt2103:String = "" //可获得奖励：
    var Cutt2104:String = "" //余额明细
    var Cutt2106:String = "" //我的邀请
    var Cutt2107:String = "" //联系客服
    var Cutt2108:String = "" //语言设置
    var Cutt2109:String = "" //关于我们
    
    //语言设置
    var Cutt2201:String = "" //语言设置
    var Cutt2202:String = "" //英语
    var Cutt2203:String = "" //葡萄牙语
    var Cutt2204:String = "" //菲律宾语
    var Cutt2205:String = "" //土耳其语
    var Cutt2206:String = "" //印尼语
    var Cutt2207:String = "" //越南语
    var Cutt2208:String = "" //马来西亚
    var Cutt2209:String = "" //西班牙语
    var Cutt2210:String = "" //泰语
    var Cutt2211:String = "" //阿拉伯语语
    var Cutt2212:String = "" //巴基斯坦 乌尔都语
    var Cutt2221:String = "" //确定
    
    //关于我们
    var Cutt2301:String = "" //关于我们
    var Cutt2302:String = "" //当前版本
    var Cutt2303:String = "" //登录账号
    var Cutt2304:String = "" //尚未绑定
    var t2305:String = "" //隐私政策
    
    //反馈
    var Cutt2401:String = "" //反馈
    var Cutt2402:String = "" //如果您遇到任何问题，请给我们留言
    var Cutt2403:String = "" //联系方式
    var Cutt2404:String = "" //提交
    var Cutt2405:String = "" //反馈详情
    var Cutt2406:String = "" //继续反馈
    var Cutt2407:String = "" //反馈明细
    var Cutt2408:String = "" //未回复
    var Cutt2409:String = "" //已回复
    var Cutt2410:String = "" //这里是底线了
    var Cutt2411:String = "" //我的反馈
    var Cutt2412:String = "" //现在反馈
    var Cutt2413:String = "" //内容不能为空
    var Cutt2414:String = "" //联系方式不能为空
    
    //提现
    var Cutt401:String = "" //钻石提款
    var Cutt403:String = "" //可提款
    var Cutt406:String = "" //提款方式
    var Cutt407:String = "" //邀请赚钱
    var Cutt408:String = "" //全部提款
    var Cutt409:String = "" //提现规则
    var Cutt410:String = "" //1，全部提现将扣除全部余额，并将可提现余额转入您指定的账号\\n2，到账时间在1分钟到24小时内，如果出现问题，也会在3个工作日内处理好\\n3，每天最多可以提现%d次\\n4，根据每个平台要求，有各自最小提现金额限制，如果金额不足，可以试试换一种提现方式
    
    //提现方式弹窗
    var Cutt411:String = "" //确认
    var Cutt412:String = "" //提现到%d
    var Cutt413:String = "" //将提现到%d，请输入以下信息
    var Cutt414:String = "" //%d账号
    var Cutt415:String = "" //姓名
    var Cutt416:String = "" //提现
    var Cutt417:String = "" //绑定账号类型
    var Cutt418:String = "" //C：CPF/CNPJ
    var Cutt419:String = "" //E：Email
    var Cutt420:String = "" //P：Phone
    var Cutt421:String = "" //B：EVP
    
    //余额不足提示
    var Cutt422:String = "" //提示
    var Cutt423:String = "" //提现到%d的最低金额为%d，请继续努力！
    var t424:String = "" //我知道了
    
    //提现成功弹窗
    var Cutt425:String = "" //提现成功
    var Cutt426:String = "" //给您发来现金
    var Cutt427:String = "" //已到账
    var Cutt428:String = "" //开心收下
    
    //提现记录
    var Cutt439:String = "" //提现记录
    var Cutt440:String = "" //提款
    var Cutt441:String = "" //提现中
    var Cutt442:String = "" //提现成功
    var Cutt443:String = "" //提现失败
    var Cutt444:String = "" //账号错误
    var Cutt445:String = "" //账号绑定
    var Cutt446:String = "" //从PagSmile获取您的帐户ID
    var Cutt447:String = "" //账号绑定失败，请重试
    var t448:String = "" //暂无记录
    
    
    // 评价
    var Cutt449:String = "" //评价
    var Cutt450:String = "" //Crazy Bird可以获得几颗星？
    var Cutt451:String = "" //确定
    
    var Cutt452:String = "" //地址
    var Cutt453:String = "" //IFSC Code
    var Cutt454:String = "" //Phone
    var Cutt455:String = "" //Email
    var Cutt456:String = "" //可提款
    var Cutt457:String = "" //总提现
    var Cutt458:String = "" //地址
    var Cutt459:String = "" //银行编码
    var Cutt460:String = "" //账号格式错误
    
    var Cutt462:String = "" //提示
    var Cutt463:String = "" //请确认您的账号
    var Cutt464:String = "" //账号：
    var Cutt465:String = "" //金额：
    var Cutt466:String = "" //取消
    var Cutt467:String = "" //确认
    
    
    //通用奖励
    var Cutt506:String = "" //恭喜获得
    var Cutt507:String = "" //开心收下
    
    //互动任务
    var Cutt1001:String = "" //互动任务
    
    //任务未完成弹窗
    var Cutt1015:String = "" //任务未完成
    var Cutt1016:String = "" //没有完成任务，确定要返回吗？
    var Cutt1017:String = "" //任务进度
    var Cutt1018:String = "" //继续任务
    var Cutt1019:String = "" //仍然返回
    var Cutt1020:String = "" //去完成
    var Cutt1021:String = "" //已完成
    var Cutt1022:String = "" //下载并试玩
    
    
    
    // 每日任务
    var Cutt1601:String = "" //每日任务
    var Cutt1603:String = "" //下载并试玩
    var Cutt1604:String = "" //看视频领福利
    var Cutt1605:String = "" //完成互动任务
    var Cutt1606:String = "" //通过关卡
    var Cutt1607:String = "" //在线时长
    var Cutt1609:String = "" //去试玩
    var Cutt1610:String = "" //去完成
    var Cutt1611:String = "" //立即领取
    var Cutt1612:String = "" //已领取
    
    // 更多奖励
    var Cutt1613:String = "" //下载试玩
    var Cutt1614:String = "" //下载应用程序并打开
    var Cutt1615:String = "" //任务要求：查看视频广告，下载应用程序并试用不少于2分钟
    var Cutt1616:String = "" //现在下载
    var Cutt1617:String = "" //不屑接受
    var Cutt1620:String = "" //邀请朋友
    var Cutt1621:String = "" //分享
    
    // 活跃宝箱
    var Cutt1622:String = "" //邀请朋友
    var Cutt1624:String = "" //去邀请
    var Cutt1625:String = "" //重置倒计时
    var Cutt1629:String = "" //奖励
    var Cutt1630:String = "" //未达成
    var Cutt1631:String = "" //领取
    var Cutt1632:String = "" //已领取
    var Cutt1633:String = "" //累计视频
    
    
    
    // 邀请弹窗
    var Cutt1701:String = "" //邀请
    var Cutt1702:String = "" //每邀请一人奖励
    var Cutt1703:String = "" //我的邀请ID
    var Cutt1704:String = "" //立即邀请
    var Cutt1705:String = "" //规则说明：
    var Cutt1706:String = "" //1.好友通过%d关，你将获得%d\n2.好友通过%d关，你将获得%d\n3.好友通过%d关，你将获得%d\n4.好友通过%d关，你将获得%d
    var Cutt1707:String = "" //已获得奖励：
    var Cutt1708:String = "" //已奖励好友：
    var Cutt1709:String = "" //未奖励好友：
    var Cutt1710:String = "" //我的邀请者：
    var Cutt1711:String = "" //无
    var Cutt1712:String = "" //填写邀请ID
    var Cutt1713:String = "" //他已经获得：
    var Cutt1714:String = "" //邀请朋友
    var Cutt1715:String = "" //分享推荐内容
    var Cutt1719:String = "" //复制内容
    var Cutt1720:String = "" //换一条
    var Cutt1721:String = "" //分享到
    var Cutt1722:String = "" //邀请二维码
    
    // 我的邀请
    var Cutt1723:String = "" //我的邀请
    var Cutt1724:String = "" //已奖励
    var Cutt1725:String = "" //未奖励
    
    // 邀请ID
    var Cutt1726:String = "" //邀请ID
    var Cutt1727:String = "" //输入朋友的邀请ID
    var Cutt1728:String = "" //提交
    var Cutt2620:String = "" // 填写邀请id立即获得奖励
    var Cutt2621:String = "" // 已填写
    
    //分享文本
    var Cutt1729:String = "" // 我发现了一款又好玩又能赚钱的应用CrazyBird，快来和我一起赚钱吧，输入邀请id{homeID}可以立即获得启动资金%d。|这款新应用CrazyBird，赚钱超快，输入邀请id{homeID}还可以获得奖励%d。|要赚钱就安装CrazyBird，来得越早赚得越多，输入这个id{homeID}可以领取福利%d。|目前为止赚钱最快的应用CrazyBird，不来就亏了，输入id{homeID}马上领现金%d。|到账超快的赚钱应用CrazyBird，你还没有安装吗，只要输入邀请id{homeID}就能领取%d。
    var Cutt1730:String = "" // 我已在CrazyBird提款%d，这个应用赚钱超快，快来试试吧，输入邀请id{homeID}可以立即获得启动资金%d。|玩游戏就能赚钱，我已经在CrazyBird赚了%d，你也快来吧，输入邀请id{homeID}还能额外获得%d。
    
    // 提示
    var Cutt1901:String = "" //邀请ID不能为空
    var Cutt1902:String = "" //无网络，点击重试
    var Cutt1903:String = "" //邀请ID设置成功
    var t1904:String = "" //复制成功
    var Cutt1906:String = "" //次数不足
    var t1907:String = "" //请先安装Twitter应用
    var Cutt1908:String = "" //下载
    var Cutt1909:String = "" //网络异常，请点击重试
    var Cutt1910:String = "" //再点一次退出
    var Cutt1911:String = "" //登录失败
    var Cutt1913:String = "" //ID
    var Cutt1914:String = "" //Mail
    var Cutt1915:String = "" //Account
    var Cutt1917:String = "" // 网络繁忙
    var Cutt1918:String = "" // 加速成功
    var Cutt1919:String = "" // 此处广告已用尽，请换位置或明天再试
    var t1920:String = "" // 今日广告已用尽，请明天再试
    var Cutt1921:String = "" // 网络繁忙
    var Cutt1922:String = "" // 广告加载失败，请稍后再试
    var Cutt1923:String = "" // 当前状态无法返回上一步
    var Cutt1924:String = "" // 这个账号已被使用
    var Cutt1925:String = "" // 钻石不足
    
    // 更新
    var Cutt2001:String = "" //发现新版本
    var Cutt2002:String = "" //当前版本
    var Cutt2003:String = "" //1，优化租房相关动画表现\n2，修改已知的bug
    var Cutt2004:String = "" //立即更新
    var Cutt2005:String = "" //残忍拒绝
    
    
    // 首页
    var Cutt2601:String = "" // 第%d关
    var Cutt2604:String = "" // 快速提款
    var Cutt2605:String = "" // 开始游戏
    var Cutt2615:String = "" // 全部关卡
    var Cutt2616:String = "" // 任务
    var Cutt2617:String = "" // 成就
    var Cutt2618:String = "" // 邀请
    
    // 关卡
    var Cutt2651:String = "" // 步数
    var Cutt2652:String = "" // 第%d关
    var Cutt2653:String = "" // 提示
    var Cutt2654:String = "" // 提示
    var Cutt2655:String = "" // 跳过
    
    
    // 战斗胜利
    var Cutt2801:String = "" // 恭喜通关
    var Cutt2802:String = "" // 分享
    var Cutt2803:String = "" // 下一关
    
    var Cutt2901:String = "" // 填写邀请码
    var Cutt2902:String = "" // 填写邀请码将立即获得奖励
    var Cutt2903:String = "" // 请输入邀请码
    var Cutt2904:String = "" // 提交
    var Cutt2905:String = "" // 邀请码错误请确认后再试
    var Cutt2906:String = "" // 不能填写自己的邀请码
    var Cutt2907:String = "" // 已填写邀请码，奖励已发放
    var Cutt2908:String = "" // 已填写
    
    
    // 失败
    var Cutt3301:String = "" // 失败
    var Cutt3302:String = "" // 挑战失败，请继续努力！
    
    
    var Cutt3311:String = "" // 提示
    var Cutt3312:String = "" // 你确定要退出本关卡吗？
    var Cutt3313:String = "" // 确定
    var Cutt3314:String = "" // 取消
    
    
    // 体力不足
    var Cutt3401:String = "" // 体力补给
    var Cutt3402:String = "" // 补充一下体力吧！
    var Cutt3403:String = "" // 免费领取
    var Cutt3404:String = "" // 体力不足
    var Cutt3405:String = "" // 每天最多补充%d，剩余%d次
    
    
    // 二类博主相关
    var Cutt4101:String = "" // 领取
    var Cutt4102:String = "" // 解锁
    var Cutt4103:String = "" // 未达成
    var Cutt4104:String = "" // VIP规则：
    var Cutt4105:String = "" // 1，VIP每升级1次，可以领取1次奖励，最高15级\n2，集满VIP经验，等级会自动提升\n3，邀请朋友，完成日常任务，参加活动都可以获得VIP经验\n4，VIP升级后还可以解冻部分已冻结的资金
    var Cutt4106:String = "" // 解锁VIP奖励
    var Cutt4107:String = "" // VIP6以上奖励需要联系机器人解锁，总共只需解锁1次！
    var Cutt4108:String = "" // 复制
    var Cutt4109:String = "" // 复制成功
    var Cutt4110:String = "" // 添加机器人时，需添加FaceBook好友并提供如下信息进行验证，验证后3个工作日以内解锁奖励。
    var Cutt4111:String = "" // Crazy Bird VIP -
    
    var Cutt4112:String = "" // 如何升级
    var Cutt4113:String = "" // VIP升级方法
    var Cutt4114:String = "" // 开启活跃宝箱
    
    
    // 成就
    var Cutt4201:String = "" // 成就
    var Cutt4202:String = "" // 总奖励
    var Cutt4203:String = "" // 待领取
    var Cutt4204:String = "" // 已领取
    var Cutt4205:String = "" // 累计邀请
    var Cutt4206:String = "" // 累计视频
    var Cutt4207:String = "" // 累计互动
    var Cutt4208:String = "" // 累计过关
    var Cutt4209:String = "" // 去邀请
    var Cutt4210:String = "" // 去完成
    var Cutt4211:String = "" // 领取
    var Cutt4212:String = "" // 已完成
    var Cutt4213:String = "" // 累计星星
    
    
    // 钞票提款
    var Cutt4301:String = "" // 钞票提款
    var Cutt4302:String = "" // 冻结钞票
    var Cutt4303:String = "" // 解冻
    var Cutt4304:String = "" // 可提款钞票
    var Cutt4305:String = "" // 选择金额
    var Cutt4306:String = "" // 提款方式
    var Cutt4307:String = "" // 提款
    var Cutt4308:String = "" // 提款中：%d
    var Cutt4309:String = "" // 提款中
    var Cutt4312:String = "" // 提款规则：
    var Cutt4313:String = "" // 1，每天最多提款1次\n2，将在1-3个工作日内到账\n3，金额越高，审核速度越慢\n4，如果出现使用工具等作弊行为，提款会被平台拒绝
    
    
    // 解冻
    var Cutt4331:String = "" // 钞票解冻
    var Cutt4332:String = "" // 我的VIP等级
    var Cutt4333:String = "" // 冻结资金
    var Cutt4334:String = "" // 解冻
    var Cutt4335:String = "" // 未达到
    var Cutt4336:String = "" // 解冻规则：
    var Cutt4337:String = "" // 1，VIP等级达到后，可解冻对应额度的冻结资金\n2，达到VIP15后，可无限解冻
    var Cutt4338:String = "" // 解冻成功
    var Cutt4339:String = "" // 剩余冻结资金
    var Cutt4340:String = "" // 我知道了
    
    // 皮肤
    var Cutt4401:String = "" // 皮肤
    var Cutt4402:String = "" // 使用中
    var Cutt4403:String = "" // 使用
    var Cutt4404:String = "" // 免费解锁
    
    // 钞票进度弹窗
    var Cutt4501:String = "" // 欢迎
    var Cutt4502:String = "" // 提款通道已升级，无需等待，达到最低金额立即打款！
    var Cutt4503:String = "" // 已赚到：%d
    var Cutt4504:String = "" // 我知道了
    var Cutt4505:String = "" // 已达到金额，快去提款吧！
    var Cutt4506:String = "" // 去提款
    
    // 系统消息跑马灯
    var Cutt4603:String = "" // %d成功提取现金%d
    
    
    // 邀请奖励弹窗
    var Cutt4701:String = "" // 邀请奖励
    var Cutt4702:String = "" // 你的朋友为你带来了如下收益
    var Cutt4703:String = "" // 我知道了
    
    
    // 帮助
    var Cutt4801:String = "" // 提示
    var Cutt4802:String = "" // 用相同颜色的纸撞击糖果
    var Cutt4803:String = "" // 我知道了
    var Cutt4804:String = "" // 让所有的纸掉下来
    var Cutt4805:String = "" // 让糖果到达指定地点
    
    // 快速提款首页
    var Cutt4901:String = "" // 快速提款
    var Cutt4902:String = "" // 提款
    var Cutt4903:String = "" // 提款中
    var Cutt4904:String = "" // 提款失败，请重试
    var Cutt4905:String = "" // 提款积分
    var Cutt4906:String = "" // 攒满积分立即提款，无其他条件
    var Cutt4907:String = "" // 已结束
    var Cutt4908:String = "" // 可重启
    var Cutt4909:String = "" // 每获得%d/%d星星，领取一次积分
    var Cutt4910:String = "" // 每邀请%d/%d个好友，领取一次积分
    var Cutt4911:String = "" // 转盘
    var Cutt4912:String = "" // 快速提款规则：
    var Cutt4913:String = "" //
    var Cutt4914:String = "" // 重新提款
    
    // 首次进入弹窗
    var Cutt4951: String = ""// 恭喜
    var Cutt4952: String = ""// 您已获得快速提款机会，集满积分立即提款，无其他条件！
    var Cutt4953: String = ""// 活动说明：
    var Cutt4954: String = ""// 1，为了帮助玩家快速提款，我们开启了加速福利\n2，福利活动持续3天，期间获得积分速度为5倍
    var Cutt4955: String = ""// 我知道了
    
    var Cutt4981: String = ""// 即将提款
    var Cutt4982: String = ""// 请再努力一下，马上就能提款了
    var Cutt4983: String = ""// 我知道了
    
    // 5倍积分
    var Cutt5001: String = ""// 5倍积分
    var Cutt5002: String = ""// 规则：
    var Cutt5003: String = ""// 1，福利活动持续5天，开启期间，每次领取积分会变为5倍\n2，积分大于等于90时，活动也会立即结束\n3，积分小于90时，可以通过邀请好友重启活动
    var Cutt5004: String = ""// 剩余时间：
    var Cutt5005: String = ""// 已结束
    var Cutt5006: String = ""// 邀请好友：
    var Cutt5007: String = ""// 去邀请
    var Cutt5008: String = ""// 我知道了
    var Cutt5009: String = ""// 重启
    
    // 抽奖
    var Cutt5101: String = ""// 幸运转盘
    var Cutt5102: String = ""// 立即提款
    var Cutt5103: String = ""// 神秘大奖
    var Cutt5104: String = ""// 开始抽奖
    var Cutt5105: String = ""// 超级大奖
    var Cutt5106: String = ""// 立即提款
    var Cutt5107: String = ""// 您已获得立即提款机会，原有积分已清空，可以重新攒积分赢取下一次提款机会。
    var Cutt5108: String = ""// 去提款
    var Cutt5109: String = ""// 神秘大奖
    var Cutt5110: String = ""// 再邀请%d个为您带来钻石收益的好友，下次抽奖必定抽到“立即提款”
    var Cutt5111: String = ""// 去邀请
    
    // 额外跳转
    var Cutt5201: String = ""// 额外钻石挑战
    var Cutt5202: String = ""// 恭喜您触发额外钻石挑战任务！只有0.01%的玩家会触发此任务哦，请务必完成并拿走奖金！
    var Cutt5203: String = ""// 奖金额度：
    var Cutt5204: String = ""// 领取
    var Cutt5205: String = ""// 时限：
    var Cutt5206: String = ""// 合计邀请：
    var Cutt5207: String = ""// 我的邀请：
    var Cutt5208: String = ""// 助力好友邀请：
    var Cutt5209: String = ""// 未设置
    var Cutt5210: String = ""// 去设置
    var Cutt5211: String = ""// 规则：
    var Cutt5212: String = ""// 1，挑战开启后，自己以及助力好友邀请的总人数达到目标即可领取奖励\n2，助力好友只能是挑战开启后邀请的好友，最多设置5人，且不可更改\n3，自己的邀请人数，从挑战开启后开始计算，助力好友的邀请人数，从设置为助力好友后开始计算
    
    
    
    // 设置助力好友
    var Cutt5251: String = ""// 设置助力好友
    var Cutt5252: String = ""// 填写新邀请的好友id，将其设置为助力好友
    var Cutt5253: String = ""// 请输入好友id
    var Cutt5254: String = ""// 确认
    var Cutt5255: String = ""// 这个用户不是你的好友
    var Cutt5256: String = ""// 只能设置挑战开启后邀请的好友助力
    var Cutt5257: String = ""// 这个好友已经在为你助力了
    var Cutt5258: String = ""// 设置成功
    
    
    var Cutt2701:String = ""// 账号删除提醒
    var Cutt2702:String = ""// 您正在进行账号删除操作，这一操作将导致您的所有数据被清空，并且无法找回，您确定要继续删除账号吗？
    var Cutt2703:String = ""// 继续删除
    var Cutt2704:String = ""// 账号删除提醒
    var Cutt2705:String = ""// 您的账号将进入10天冻结期，期间账号被停用，冻结期结束后才会正式清除数据。10天内再次登录可以自行取消冻结。
    var Cutt2706:String = ""// 继续删除
    var Cutt2707:String = ""// 删除账号提醒
    var Cutt2708:String = ""// 删除账号后，游戏内所有数据都将被清空，并且无法找回，您确定要继续吗？
    var Cutt2709:String = ""// 继续删除
    var Cutt2710:String = ""// 账号已停用
    var Cutt2711:String = ""// 您的账号：%d\n该账号在%d申请了删除账号，我们将于申请日起10天正式删除该账号。
    var Cutt2712:String = ""// 我知道了
    var t2713:String = ""// 账号已停用
    var t2714:String = ""// 您的账号：%d\n您的账号处于停用状态，将于%d正式删除，如您为误操作，请点击恢复账号重新进入游戏。
    var t2715:String = ""// 恢复账号
    var t2716:String = ""// 退出游戏
    var Cutt2717:String = ""// 删除账号
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< t101 <-- "Cutt101"
        mapper <<< t102 <-- "Cutt102"
        mapper <<< t103 <-- "Cutt103"
        mapper <<< t448 <-- "Cutt448"
        mapper <<< t424 <-- "Cutt424"
        mapper <<< t1920 <-- "Cutt1920"
        mapper <<< t1907 <-- "Cutt1907"
        mapper <<< t1904 <-- "Cutt1904"
        mapper <<< t2305 <-- "Cutt2305"
        
        mapper <<< t2713 <-- "Cutt2713"
        mapper <<< t2714 <-- "Cutt2714"
        mapper <<< t2715 <-- "Cutt2715"
        mapper <<< t2716 <-- "Cutt2716"
        
    }
}
