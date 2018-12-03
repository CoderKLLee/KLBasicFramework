//
/*******************************************************************************
        Copyright © 2018年 Ferryman. All rights reserved.
        
        File name:     CYUrlArgumentsFilter.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/26: File created.
        
********************************************************************************/


#import <Foundation/Foundation.h>
#import <YTKNetworkConfig.h>
@interface KLUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (KLUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

@end
