//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CYAPIManager.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/4: File created.
        
********************************************************************************/


#import "KLRequest.h"


@interface KLRequest ()


@end

@implementation KLRequest

- (NSString *)requestUrl {
    return @"/api.php";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 10;
}

- (id)jsonValidator {
    
    // code获取的代码
//    NSInteger code = ...
//
//    BOOL isError = code != 1000;
//    if (isError) {
//        // 用这个结构去验证 -> 验证失败 -> 调用failure block
//        return @{ @"someKeyYouWillNeverUse":[NSObject class] };
//    }
    
    [self APILog];

    NSInteger status = [[self.responseJSONObject objectForKey:@"status"]integerValue];
    
    if (status == -2000) {  // token 失效
        
        [self tokenError];
       
        return @{ @"errorKey":[NSObject class] };
        
    }
    
    if (!(status == 1)) {
        self.errorMsg = [NSString stringWithFormat:@"%@",[self.responseJSONObject objectForKey:@"msg"]];
         return @{ @"errorKey":[NSObject class] };
    }
    
    
    self.totalpage = [[self.responseJSONObject objectForKey:@"totalpage"]integerValue];

    
    // 这是你的固定结构，用于验证正确返回结果的时候
    return @{
             @"status":[NSNumber class]
             };
    
    // 如有特殊的网络请求，要验证非常细致的返回结果的结构，那就在它的类中override jsonValidator方法即可
    // 这里验证大部分的网络请求返回结果
    // 在我参与的项目中并不是每一个网络请求都会验证它结果的完整结构，这种情况下就满足需求了
}


/**
 日志输入请求的API
 */
- (void)APILog {
    /*
     1.参数的拼接
     遍历参数字典,一一取出参数,按照参数格式拼接在 url 后面
     */
    NSMutableString *StrM = [NSMutableString string];
    NSMutableDictionary *parameters = (NSMutableDictionary *)self.requestArgument;
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *parametersKey = key;
        NSString *parametersValue = obj;
        [StrM appendFormat:@"%@=%@&",parametersKey,parametersValue];
    }];

    switch ([self requestMethod]) {
        case YTKRequestMethodGET:{

            KLLogDebug(@" GET URLString %@",self.currentRequest.URL.absoluteString);
            
            break;
        }
        case YTKRequestMethodPOST:{
            NSString *URLString = [NSString stringWithFormat:@"%@",StrM];
            // 截取字符串的方法!
            URLString = [URLString substringToIndex:URLString.length - 1];
            URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            KLLogDebug(@"  POST URLString %@ \n %@",self.currentRequest.URL.absoluteString,URLString);

            break;
        }
        default:
            break;
    }
    
    NSString *responseString = [self.responseString stringByRemovingPercentEncoding];
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) {
        KLLogError(@" APILog Data 为空");
        return;
    }
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&error];
    if (error) {
        KLLogError(@"  Response Error %@", error);
        return;
    }
    KLLogDebug(@"  Response Parameter %@",dic);

}

- (void)tokenError {
    
//    [CYAlertView cy_showAlertViewWithTitle:@"登录过期啦" message:@"客官, 您的登录过期了, 请重新登录!" confirmTitle:@"退出登录" confirmAction:^{
//        [CYAccountManager logout];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            CYTabBarViewController *bar = (CYTabBarViewController *)APP_WINDOW.rootViewController;
//            CYNavigationController *view = [bar selectedViewController];
//            [view.topViewController.navigationController popToRootViewControllerAnimated:NO];
//        });
//    }];
}

@end

#pragma mark    ---  新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文

#ifdef DEBUG
@implementation NSArray (LOG)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (LOG)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
#endif
