
/**
 *  user
 */
#define USER_ID_KEY [FileCacheManager getValueInMyLocalStoreForKey:kUSER_ID_KEY]
/**
 *  Bounds
 */
#define kWindow [UIApplication sharedApplication].keyWindow
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
#define ScreenScale   kScreenWidth/375
#define ScreenHScale  kScreenWidth/375
//#define ScreenHScale  kScreenHeight/667
/**
 *  Version
 */
#define kVersion [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
#define kSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
/**
 *  Network
 */
#define kNetworkType [AppUtility getNetworkType]


/**
 *  lazy
 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/**
 *  iPhone or iPad
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
/**
 *  NSLog
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

/**
 *  Color
 */
#define zzColor(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define zzColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define zzRandomColor  zzColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//NSCoding协议遵循
#define kObjectCodingAction  -(id)initWithCoder:(NSCoder *)aDecoder\
{\
self = [super init];\
if (self) {\
[self autoDecode:aDecoder];\
\
}\
return self;\
}\
-(void)encodeWithCoder:(NSCoder *)aCoder\
{\
[self autoEncodeWithCoder:aCoder];\
}\
-(void)setValue:(id)value forUndefinedKey:(NSString *)key\
{\
\
}
/**
 *  @param instead 需要给用户提醒的话,例子：XMCDeprecated("此方法已经过期")
 */
#define XMCDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

/**
 *  多语言切换
 */
#define Localized(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:KAPPLANGUAGE_KEY]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Language"]

#define isRTL() [[[[NSBundle mainBundle] preferredLocalizations] firstObject] hasPrefix:@"ar"]


//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
//
//#endif






