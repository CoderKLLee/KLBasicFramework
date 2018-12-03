//
/*******************************************************************************
        
        File name:     KLNetworkManager.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/10/29: File created.
        
********************************************************************************/
    

#import "KLNetworkManager.h"
#import "KLAPIConstant.h"
#import "KLUrlArgumentsFilter.h"


#import <YTKNetworkAgent.h>
#import <YTKNetworkConfig.h>

@implementation KLNetworkManager
/**
 初始化网络配置
 */
- (void)configNetwork {
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = kHost;
    KLUrlArgumentsFilter *urlFilter = [KLUrlArgumentsFilter filterWithArguments:@{@"version": kAPIVersion, @"from": kOSType}];
    [config addUrlFilter:urlFilter];
    
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    @try {
        [agent setValue:acceptableContentTypes forKeyPath:keypath];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    } @finally {
        
    }
}

@end
