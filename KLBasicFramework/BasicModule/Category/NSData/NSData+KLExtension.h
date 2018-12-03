//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     NSData+KLExtension.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import <Foundation/Foundation.h>

@interface NSData (KLExtension)

#pragma mark - Hash
/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)kl_md5String;
#pragma mark - Encode and decode

/**
 Returns string decoded in UTF8.
 */
- (nullable NSString *)kl_utf8String;

/**
 Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)kl_hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (nullable NSData *)kl_dataWithHexString:(NSString *)hexString;

/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)kl_base64EncodedString;

/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (nullable NSData *)kl_dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)kl_jsonValueDecoded;
@end
