//
/*******************************************************************************
        
        File name:     KLLogFormatter.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/10/26: File created.
        
********************************************************************************/
    

#import <CocoaLumberjack/DDDispatchQueueLogFormatter.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDLogFormatter;

@interface KLLogFormatter : DDDispatchQueueLogFormatter

@end

NS_ASSUME_NONNULL_END
