//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CYAPIManager.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/4: File created.
        
********************************************************************************/


#import "YTKRequest.h"


@interface KLRequest : YTKRequest


/**
 总页数
 */
@property (nonatomic, readwrite, assign) NSInteger totalpage;

/**
 错误信息
 */
@property (nonatomic, readwrite, strong) NSString *errorMsg;

/**
 接口日志输出
 */
- (void)APILog;


- (void)tokenError;

@end
