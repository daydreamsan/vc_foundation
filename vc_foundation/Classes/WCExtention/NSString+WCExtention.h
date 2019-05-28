//
//  NSString+WCExtention.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WCExtention)

- (BOOL)containChineseCharacter;

- (BOOL)containEmoji;

/**
 过滤表情
 
 @return 过滤表情后的字符串
 */
- (NSString *)filterEmoji;

- (NSString *)AES256EncryptWithPublickKey:(NSString *)publicKey;

- (NSString *)AES256DecryptWithPublickKey:(NSString *)publicKey;

- (NSString *)firstCharactor;
/**
 汉字转成拼音
 like 汉字 -> hanzi
 */
- (NSString *)getPinyinWithString;

/**
 获取字符串的首字母
 like 汉字 - > hz
 */
- (NSString *)getFirstCharactorWithString;
/**
 将时间串转为秒值, 需要具备以下格式:（分：秒：毫秒)
 @return 秒值
 */
- (NSTimeInterval)seconds;
- (NSTimeInterval)milliseconds;

+ (NSString *)timeInfoWithSeconds:(NSInteger)second;
+ (NSString *)timeHourInfoWithSeconds:(NSInteger)second;
+ (NSString *)pageviewInfoWithPageview:(NSInteger)pv;
+ (NSString *)timeStringWithSecond:(NSInteger)second;///<01:21:30

/**
 number -> hanzi
 
 @param no number
 @return hanzi
 */
+ (NSString *)chineseCharacterWithNumber:(NSInteger)no;

/**
 手机号有效性检测

 @return 有效的手机号 - YES, otherwise - NO
 */
- (BOOL)isPhoneNumber;

/**
 邮箱有效性检测

 @return 有效的邮箱 - YES, otherwise - NO
 */
- (BOOL)isEmail;

/**
 判断字符串内全为数字

 @return 全为数字 - YES 包含其他内容 - NO
 */
- (BOOL)characterContentNumber:(NSString *)str;

- (NSString *)stringByReplaceQuotation;

- (NSString *)stringByReplaceSingleQuotation;

/**
 单行文字计算
 
 @return Size
 */
-(CGSize)singleLineSizeForfont:(UIFont *)font;

/**
 多行文字计算
 
 @return Size
 */
-(CGSize)multiLineSizeForfont:(UIFont *)font width:(CGFloat)width withAttributes:(NSDictionary*)dic;


/**
 指定某个字符串中的文本添加特定的字体和颜色
 
 @return 富文本
 */
-(NSMutableAttributedString *)attributedTextForAppointText:(NSString*)appointText font:(UIFont*)font color:(UIColor*)color;

/**
 指定某个字符串中的文本添加特定的字体和颜色，字间距(整个文本的字间距)
 
 @return 富文本
 */
-(NSMutableAttributedString *)attributedTextForAppointText:(NSString*)appointText font:(UIFont*)font color:(UIColor*)color wordSpace:(CGFloat)wordSpace;

/**
 指定某个字符串中的文本添加特定的字体和颜色，字间距(整个文本的字间距)，行间距
 
 @return 富文本
 */
-(NSMutableAttributedString *)attributedTextForAppointText:(NSString*)appointText font:(UIFont*)font color:(UIColor*)color wordSpace:(CGFloat)wordSpace lineSpace:(CGFloat)lineSpace;

@end

@interface NSMutableAttributedString (WCExtention)

/**
 针对维词系App做的处理，高亮规则同高中、初中

 @param decorate 高亮规则
 @return 结果
 
 @warning 此方法采用的默认高亮字体为:kTimesWithSize(21), 高亮颜色为：kMainTintColor
 */
- (NSMutableAttributedString *)attributedStringByAddDecorate:(NSString *)decorate;

/**
 针对维词系App做的处理，高亮规则同高中、初中,可以定制高亮时显示的字体与颜色

 @param decorate 高亮规则
 @param f 高亮字体
 @param c 高亮颜色
 @return 结果
 */

- (NSMutableAttributedString *)attributedStringByAddDecorate:(NSString *)decorate highlightFont:(UIFont *)f highlightColor:(UIColor *)c;
- (NSMutableAttributedString *)attributedStringByAddDecorate:(NSString *)decorate highlightFont:(UIFont *)f highlightColor:(UIColor *)c enableShadow:(BOOL)enable;
- (NSMutableAttributedString *)attributedStringByAddWordTapEvent;

@end
