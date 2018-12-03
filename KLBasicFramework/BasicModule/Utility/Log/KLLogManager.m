//
/*******************************************************************************
        
        File name:     KLLogManager.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/10/26: File created.
        
********************************************************************************/
    

#import "KLLogManager.h"
#import "KLLogFormatter.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <CocoaLumberjack/DDLog.h>



@implementation KLLogManager

#pragma mark    ---     Lifecycle
+ (KLLogManager *)shareInstance {
    static KLLogManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

#pragma mark    ---     OverwriteSuperClass

#pragma mark    ---     Response Mehtods

#pragma mark    ---     Delegate

#pragma mark    ---     Private Methods

#pragma mark    ---     Public Methods

/**
 初始化
 */
- (void)config {

    [DDLog addLogger:[DDTTYLogger sharedInstance]]; //add log to Xcode console
    
    // 输出的格式
    [DDTTYLogger sharedInstance].logFormatter = [[KLLogFormatter alloc] init];
    
    
}


#pragma mark    ---     Getters and Setters


@end
