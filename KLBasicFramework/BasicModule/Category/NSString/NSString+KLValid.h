//
/*******************************************************************************
        
        File name:     NSString+KLValid.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/10/29: File created.
        
********************************************************************************/
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KLValid)

/**
 是否为空
 
 @return return value description
 */
- (BOOL)kl_isEmpty;


/**
 是否含有空格
 
 @return return value description
 */
- (BOOL)kl_isHaveEmptyString;


/**
 检测字符串是否包含中文

 @return return value description
 */
-( BOOL)kl_isContainChinese;

/**
 是否是整形

 @return return value description
 */
- (BOOL)kl_isPureInt;


/**
 是否是浮点型

 @return return value description
 */
- (BOOL)kl_isPureFloat;

/**
 是否是纯数字

 @return return value description
 */
- (BOOL)kl_isPureDigitCharacters;


/**
 是否是字母或者数字

 @return return value description
 */
- (BOOL)kl_isValidCharacterOrNumber;
@end

NS_ASSUME_NONNULL_END
