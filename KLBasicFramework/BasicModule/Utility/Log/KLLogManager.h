//
/*******************************************************************************
        
        File name:     KLLogManager.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/10/26: File created.
        
********************************************************************************/
    

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/DDLogMacros.h>

#if DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelDebug;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#define KLLog(frmt, ...)            DDLogInfo(frmt, ...)

#define KLLogError(...)             DDLogError(@"%@",[NSString stringWithFormat:__VA_ARGS__]);

#define KLlogWarn(...)              DDLogWarn(@"%@",[NSString stringWithFormat:__VA_ARGS__]);

#define KLLogInfo(...)              DDLogInfo(@"%@",[NSString stringWithFormat:__VA_ARGS__]);

#define KLLogDebug(...)             DDLogDebug(@"%@",[NSString stringWithFormat:__VA_ARGS__]);


NS_ASSUME_NONNULL_BEGIN

@interface KLLogManager : NSObject

+ (KLLogManager *)shareInstance;

/**
 初始化
 */
- (void)config;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
