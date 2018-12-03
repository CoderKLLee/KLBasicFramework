//
/*******************************************************************************
        
        File name:     KLLogFormatter.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/10/26: File created.
        
********************************************************************************/
    

#import "KLLogFormatter.h"
#import <CocoaLumberjack/DDLog.h>

static NSString *_processName;

@interface KLLogFormatter ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;


@end

@implementation KLLogFormatter

+ (void)initialize {
    if (self == [KLLogFormatter class]) {
        _processName = [[NSProcessInfo processInfo] processName];
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    
    self.dateFormatter = NSDateFormatter.new;
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"❌ Error  "; break;
        case DDLogFlagWarning  : logLevel = @"⚠️ Warning  "; break;
        case DDLogFlagInfo     : logLevel = @"📚 Info  "; break;
        case DDLogFlagDebug    : logLevel = @"☁️ Debug  "; break;
        default                : logLevel = @"⚡️ Default  "; break;
    }
    
    return [NSString stringWithFormat:@"%@ %@(%@) %@(%@) %@ %@",
            [self.dateFormatter stringFromDate:logMessage.timestamp],
            _processName,
            [self queueThreadLabelForLogMessage:logMessage],
            logMessage->_function,
            @(logMessage->_line),
            logLevel,
            logMessage->_message];
}

//- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
//
//    NSString *logLevel;
//    switch (logMessage->_flag) {
//        case DDLogFlagError    : logLevel = @"❌ Error   "; break;
//        case DDLogFlagWarning  : logLevel = @"⚠️ Warning "; break;
//        case DDLogFlagInfo     : logLevel = @"📚 Info    "; break;
//        case DDLogFlagDebug    : logLevel = @"⚡️ Debug   "; break;
//        default                : logLevel = @"☁️ Default "; break;
//    }
//
//    NSString *dateAndTime = [[[NSDateFormatter alloc] init] stringFromDate:(logMessage->_timestamp)];
//
//    NSString *formatLog = [NSString stringWithFormat:@"%@[%@ %@][line %ld] %@",
//                           logLevel, logMessage->_fileName, logMessage->_function,
//                           logMessage->_line, logMessage->_message];
//
//    return formatLog;
//}

@end
