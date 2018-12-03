//
/*******************************************************************************
        
        File name:     NSString+KLValid.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/10/29: File created.
        
********************************************************************************/
    

#import "NSString+KLValid.h"

@implementation NSString (KLValid)

- (BOOL)kl_isEmpty {
    if (self == nil) {
        return YES;
        
    }
    if (self == NULL) {
        return YES;
        
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
        
    }
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
        
    }
    
    if ([self isEqualToString:@"null"] || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"]) {
        return YES;
    }
    
    
    return NO;
    
}

- (BOOL)kl_isHaveEmptyString {
    
    NSRange range = [self rangeOfString:@" "];
    
    if (range.location != NSNotFound) {
        
        return YES;
        
    }
    
    else {
        
        return NO;
        
    }
    
}

- (BOOL)kl_isContainChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

/// 整形
- (BOOL)kl_isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/// 浮点型
- (BOOL)kl_isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/// 纯数字
- (BOOL)kl_isPureDigitCharacters
{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0) return NO;
    
    return YES;
}

/// 字符串为字母或者数字
- (BOOL)kl_isValidCharacterOrNumber
{
    // 编写正则表达式：只能是数字或英文，或两者都存在
    NSString *regex = @"^[a-z0－9A-Z]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}



@end
