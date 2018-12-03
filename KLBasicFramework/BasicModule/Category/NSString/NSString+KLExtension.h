//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     NSString+KLExtension.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                英文注释的都是从 YYCategories 复制的. 感谢 ibireme
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, timeType){
    timeTypeMMDD,               /* 月日 */
    timeTypeMMDDHHMM,           /* 月日 小时分钟 */
    timeTypeYYMMDD,             /* 年月日 */
    timeTypeYYMMDDHHMM,         /* 年月日 小时分钟 */
    timeTypeYYMMDDHHMMSS,       /* 年月日 小时分钟秒 */
};


@interface NSString (KLExtension)


#pragma mark - Hash
/**
 Returns a lowercase NSString for md5 hash.
 */
- (nullable NSString *)kl_md5String;


#pragma mark - Encode and decode
/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)kl_base64EncodedString;

/**
 Returns an NSString from base64 encoded string.
 @param base64EncodedString The encoded string.
 */
+ (nullable NSString *)kl_stringWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 URL encode a string in utf-8.
 @return the encoded string.
 */
- (NSString *)kl_stringByURLEncode;

/**
 URL decode a string in utf-8.
 @return the decoded string.
 */
- (NSString *)kl_stringByURLDecode;

/**
 Escape commmon HTML to Entity.
 Example: "a>b" will be escape to "a&gt;b".
 */
- (NSString *)kl_stringByEscapingHTML;

#pragma mark - Drawing
/**
 Returns the size of the string if it were rendered with the specified constraints.
 
 @param font          The font to use for computing the string size.
 
 @param size          The maximum acceptable size for the string. This value is
 used to calculate where line breaks and wrapping would occur.
 
 @param lineBreakMode The line break options for computing the size of the string.
 For a list of possible values, see NSLineBreakMode.
 
 @return              The width and height of the resulting string's bounding box.
 These values may be rounded up to the nearest whole number.
 */
- (CGSize)kl_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 Returns the width of the string if it were to be rendered with the specified
 font on a single line.
 
 @param font  The font to use for computing the string width.
 
 @return      The width of the resulting string's bounding box. These values may be
 rounded up to the nearest whole number.
 */
- (CGFloat)kl_widthForFont:(UIFont *)font;

/**
 Returns the height of the string if it were rendered with the specified constraints.
 
 @param font   The font to use for computing the string size.
 
 @param width  The maximum acceptable width for the string. This value is used
 to calculate where line breaks and wrapping would occur.
 
 @return       The height of the resulting string's bounding box. These values
 may be rounded up to the nearest whole number.
 */
- (CGFloat)kl_heightForFont:(UIFont *)font width:(CGFloat)width;


#pragma mark    ---     time
/**
 当前时间戳
 
 @return return value description
 */
+ (NSString *)kl_currentDate;

/**
 时间戳转换成时间
 
 @return return value description
 */
- (NSString *)kl_timestampChangeTimeType:(timeType)timeType;

#pragma mark    ---     设备信息

/**
 获取IDFA
 
 @return return value description
 */
+ (NSString *)kl_getIDFA;

@end
