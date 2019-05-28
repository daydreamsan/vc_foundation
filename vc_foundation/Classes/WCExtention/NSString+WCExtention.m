//
//  NSString+WCExtention.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "NSString+WCExtention.h"
#import "NSData+WCExtention.h"
#import "../VCFKBase.h"

NSString *WCDidSelectedWordNotification = @"WCDidSelectedWordNotification";
NSString *WCDidSelectedWordRectKey      = @"WCDidSelectedWordRectKey";
NSString *WCDidSelectedWordTextKey      = @"WCDidSelectedWordTextKey";
NSString *WCDidSelectedWordRangeKey     = @"WCDidSelectedWordRangeKey";
NSString *WCDidSelectedWordContainerKey = @"WCDidSelectedWordContainerKey";

@implementation NSString (WCExtention)

- (BOOL)containChineseCharacter {
    for (NSInteger i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (ch > 0x4e00 && ch < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

//判断是否有emoji
- (BOOL)containEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f9ff) {
                        returnValue = YES;
                    }
                }
            } else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue = YES;
                }
            } else {
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue = YES;
                } else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue = YES;
                } else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue = YES;
                } else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue = YES;
                } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue = YES;
                }
            }
        }
    }];
    return returnValue;
}

- (NSString *)filterEmoji {
    if (self.length == 0) {
        return nil;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
    return modifiedString;
}

- (NSString *)AES256EncryptWithPublickKey:(NSString *)publicKey {
    NSData *result = [NSData encryptAESData:self withPublicKey:publicKey];
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

- (NSString *)AES256DecryptWithPublickKey:(NSString *)publicKey {
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return [NSData decryptAESData:data withPublicKey:publicKey];
}

- (NSTimeInterval)seconds {
    return self.milliseconds / 1000.f;
}
- (NSTimeInterval)milliseconds {
    NSArray *comps = [self componentsSeparatedByString:@":"];
    NSAssert(3 == comps.count, @"时间格式错误");
    NSInteger m = [comps.firstObject integerValue];
    NSInteger s = [comps[1] integerValue];
    NSInteger ms = [comps.lastObject integerValue];
    return (m * 60 + s) * 1000 + ms;
}

+ (NSString *)timeInfoWithSeconds:(NSInteger)second {
    NSInteger s = second % 60;
    NSInteger m = second / 60 % 60;
    NSInteger h = second / 60 / 60 % 24;
    NSInteger d = second / 60 / 60 / 24;
    NSMutableString *result = [[NSMutableString alloc] init];
    if (d) {
        [result appendString:[NSString stringWithFormat:@"%zi天", d]];
    }
    if (h) {
        [result appendString:[NSString stringWithFormat:@"%zi小时", h]];
    }
    if (m) {
        [result appendString:[NSString stringWithFormat:@"%zi分钟", m]];
    }
    if (h || d) {
        return result;
    } else {
        if (m && s) {
            [result appendString:[NSString stringWithFormat:@"%zi秒", s]];
            return result;
        } else if (m && !s) {
            return result;
        } else {
            return [@(s).stringValue stringByAppendingString:@"秒"];
        }
    }
}

+ (NSString *)timeHourInfoWithSeconds:(NSInteger)second {
    NSInteger s = second % 60;
    NSInteger m = second / 60 % 60;
    NSInteger h = second / 60 / 60;
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:[NSString stringWithFormat:@"%02zi:", h]];
    [result appendString:[NSString stringWithFormat:@"%02zi′", m]];
    [result appendFormat:@"%02zi″",s];
    return result;
}

+ (NSString *)pageviewInfoWithPageview:(NSInteger)pv {
    if (pv <= 9999) {
        return @(pv).stringValue;
    } else if (pv <= 999999) {
        return [NSString stringWithFormat:@"%.1f万", pv / 10000.f];
    } else {
        return [NSString stringWithFormat:@"%@万", @(pv / 10000)];
    }
}

+ (NSString *)timeStringWithSecond:(NSInteger)second {
    NSInteger s = second % 60;
    NSInteger m = second / 60 % 60;
    NSInteger h = second / 60 / 60;
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:[NSString stringWithFormat:@"%02zi:", h]];
    [result appendString:[NSString stringWithFormat:@"%02zi:", m]];
    [result appendFormat:@"%02zi",s];
    return result;
}

- (NSString *)firstCharactor {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    if (!pinYin.length) {
        return nil;
    }
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}


+ (NSString *)chineseCharacterWithNumber:(NSInteger)no {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *grade = [formatter stringFromNumber:[NSNumber numberWithInteger:no]];
    return grade;
}

- (NSString *)getPinyinWithString {
    NSMutableString * mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef) mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    mutableString = [[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    return mutableString.lowercaseString;
}

- (NSString *)getFirstCharactorWithString {
    NSMutableString * stringM = [NSMutableString string];
    
    NSString * temp = nil;
    for (int i = 0; i < [self length]; i ++) {
        
        temp = [self substringWithRange:NSMakeRange(i, 1)];
        
        NSMutableString * mutableString = [NSMutableString stringWithString:temp];
        
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
        
        mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        
        mutableString = [[mutableString substringToIndex:1] mutableCopy];
        
        [stringM appendString:(NSString *)mutableString];
    }
    return stringM.lowercaseString;
}

- (BOOL)isPhoneNumber {
    NSString *regNumber = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regNumber];
    BOOL valid = [predicate evaluateWithObject:self];
    return valid;
}

- (BOOL)isEmail {
    return NO;
}

- (BOOL)characterContentNumber:(NSString *)str {
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

- (NSString *)stringByReplaceQuotation {
    return [self stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}

- (NSString *)stringByReplaceSingleQuotation {
    return [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

- (CGSize)singleLineSizeForfont:(UIFont *)font {
    CGSize size = [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return CGSizeMake(size.width, size.height);
    
}

- (CGSize)multiLineSizeForfont:(UIFont *)font width:(CGFloat)width withAttributes:(NSDictionary*)dic {
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading   attributes:dic context:nil].size;
}

- (NSMutableAttributedString *)attributedTextForAppointText:(NSString*)appointText font:(UIFont*)font color:(UIColor*)color {
   return  [self attributedTextForAppointText:appointText font:font color:color wordSpace:0];
}

- (NSMutableAttributedString *)attributedTextForAppointText:(NSString*)appointText font:(UIFont*)font color:(UIColor*)color wordSpace:(CGFloat)wordSpace {
  return [self attributedTextForAppointText:appointText font:font color:color wordSpace:wordSpace lineSpace:0];
}

- (NSMutableAttributedString *)attributedTextForAppointText:(NSString*)appointText font:(UIFont*)font color:(UIColor*)color wordSpace:(CGFloat)wordSpace lineSpace:(CGFloat)lineSpace {
    NSRange range;
    if (appointText.length) {
        range = [self rangeOfString:appointText];
        if (range.location == NSNotFound)
            return nil;
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName value:font  range:NSMakeRange(range.location, range.length)];
    }
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName  value:color range:NSMakeRange(range.location, range.length)];
    }
    if (wordSpace) {
        [attributedStr addAttribute: NSKernAttributeName value:@(wordSpace)  range:NSMakeRange(0, self.length)];
    }
    [attributedStr addAttribute:NSFontAttributeName value:font  range:NSMakeRange(range.location, range.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName  value:color range:NSMakeRange(range.location, range.length)];
    [attributedStr addAttribute: NSKernAttributeName value:@(wordSpace)  range:NSMakeRange(0, self.length)];
    if (lineSpace) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = lineSpace;
        [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    }
    return attributedStr;
}

@end

@implementation NSMutableAttributedString (WCExtention)

- (NSMutableAttributedString *)attributedStringByAddDecorate:(NSString *)decorate {
    return [self attributedStringByAddDecorate:decorate highlightFont:kTimesWithSize(21) highlightColor:kMainTintColor];
}

- (NSMutableAttributedString *)attributedStringByAddDecorate:(NSString *)decorate highlightFont:(UIFont *)f highlightColor:(UIColor *)c {
    return [self attributedStringByAddDecorate:decorate highlightFont:f highlightColor:c enableShadow:NO];
}
- (NSMutableAttributedString *)attributedStringByAddDecorate:(NSString *)decorate highlightFont:(UIFont *)f highlightColor:(UIColor *)c enableShadow:(BOOL)enable {
    //将特殊的空白符替换为空格
    NSString *source = [[[[self.string stringByReplacingOccurrencesOfString:@" " withString:@" "] stringByReplacingOccurrencesOfString:@" " withString:@" "] stringByReplacingOccurrencesOfString:@" " withString:@" "] stringByReplacingOccurrencesOfString:@" " withString:@" "];
    decorate = [[[[decorate.stringByTrim stringByReplacingOccurrencesOfString:@" " withString:@" "] stringByReplacingOccurrencesOfString:@" " withString:@" "] stringByReplacingOccurrencesOfString:@" " withString:@" "] stringByReplacingOccurrencesOfString:@" " withString:@" "];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
    NSArray *sperators = [decorate componentsSeparatedByCharactersInSet:set];
    __block NSMutableArray *rangeArrayM = [NSMutableArray array];
    for (NSString *indexWord in sperators) {
        NSString *word = indexWord;
        while ([word hasPrefix:@" "]) {
            word = [word substringFromIndex:1];
        }
        if (!word.length) {
            continue;
        }
        NSInteger idx = 1;
        BOOL noIdx = NO;
        NSRange range = [indexWord rangeOfString:@"_" options:NSBackwardsSearch];
        if (0 != range.length && NSNotFound != range.location) {
            NSString *idxstr = [indexWord substringFromIndex:range.location + range.length];
            idx = idxstr.integerValue;
            word = [indexWord substringToIndex:range.location];
        } else {
            noIdx = YES;
        }
        if (!word.length) {
            continue;
        }
        idx -= 1;
        __block NSInteger innerIdx = 0;
        [source enumerateSubstringsInRange:NSMakeRange(0, source.length) options:NSStringEnumerationByWords usingBlock:^(NSString * substring, NSRange substringRange, NSRange enclosingRange, BOOL * stop) {
            if ([word containsString:substring]) {
                if ([substring isEqualToString:word]) {
                    if (innerIdx == idx || noIdx) {
                        NSValue *value = [NSValue valueWithRange:substringRange];
                        [rangeArrayM addObject:value];
                    }
                    innerIdx++;
                } else {
                    //'100%'之类的特殊处理
                    if ([word hasSuffix:@"%"]) {
                        NSString *subword = [word substringToIndex:word.length-1];
                        NSNumber *subwordno = subword.numberValue;
                        NSString *rsubword = subwordno.stringValue;
                        if ([subword isEqualToString:rsubword]) {
                            if (substringRange.location + substringRange.length + 1 <= source.length) {
                                NSRange range = NSMakeRange(substringRange.location + substringRange.length, 1);
                                NSString *sp = [source substringWithRange:range];
                                if ([sp isEqualToString:@"%"]) {
                                    if (innerIdx == idx || noIdx) {
                                        NSValue *value = [NSValue valueWithRange:NSMakeRange(substringRange.location, substringRange.length + 1)];
                                        [rangeArrayM addObject:value];
                                    }
                                    innerIdx++;
                                }
                            }
                        }
                    }
                }
            } else {
                if ([substring containsString:@"'"] && [substring containsString:word]) {
                    //处理 I'm, she's he's I'll, she'll isn't 之类的情况
                    NSString *sub = [substring componentsSeparatedByString:@"'"].lastObject;
                    if ([sub isEqualToString:word]) {
                        if (innerIdx == idx || noIdx) {
                            NSRange range = NSMakeRange(substringRange.location + substringRange.length - sub.length, sub.length);
                            NSValue *value = [NSValue valueWithRange:range];
                            [rangeArrayM addObject:value];
                        }
                        innerIdx++;
                    }
                }
            }
        }];
    }
    
    //处理短语
    NSMutableArray *shortSentenceM = [NSMutableArray array];
    for (NSString *ss in sperators) {
        NSString *target = [ss stringByTrim];
        if ([target containsString:@" "] || [target containsString:@"-"]) {
            [shortSentenceM addObject:target];
        }
    }
    NSMutableArray *ssValueM = [NSMutableArray array];
    for (NSString *ss in shortSentenceM) {
        NSString *pattern = ss;
        if ([ss containsString:@"("]) {
            pattern = [ss stringByReplacingOccurrencesOfString:@"(" withString:@"\\("];
        }
        if ([ss containsString:@")"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@")" withString:@"\\)"];
        }
        if ([ss containsString:@"+"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"+" withString:@"\\+"];
        }
        if ([ss containsString:@"."]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"." withString:@"\\."];
        }
        if ([ss containsString:@"?"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"?" withString:@"\\?"];
        }
        if ([ss containsString:@"*"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"*" withString:@"\\*"];
        }
        if ([ss containsString:@"$"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"$" withString:@"\\$"];
        }
        if ([ss containsString:@"{"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"{" withString:@"\\{"];
        }
        if ([ss containsString:@"}"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"}" withString:@"\\}"];
        }
        if ([ss containsString:@"^"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"^" withString:@"\\^"];
        }
        if ([ss containsString:@"|"]) {
            pattern = [pattern stringByReplacingOccurrencesOfString:@"|" withString:@"\\|"];
        }
        NSError *e;
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionUseUnicodeWordBoundaries error:&e];
        NSArray<NSTextCheckingResult *> *results = [reg matchesInString:source options:NSMatchingReportCompletion range:NSMakeRange(0, source.length)];
        for (NSTextCheckingResult * one in results) {
            NSRange range = one.range;
            if (range.length > 0 && range.location != NSNotFound) {
                NSValue *value = [NSValue valueWithRange:range];
                [ssValueM addObject:value];
            }
        }
    }
    NSDictionary *attrDict;
    if (enable) {
        NSShadow *shadow = [NSShadow new];
        shadow.shadowBlurRadius = 0.4;
        shadow.shadowColor = [UIColor whiteColor];
        shadow.shadowOffset = CGSizeMake(0.5, 0.5);
        attrDict = @{NSForegroundColorAttributeName:c, NSFontAttributeName:f, NSStrokeWidthAttributeName:@(-4), NSStrokeColorAttributeName:[UIColor whiteColor], NSShadowAttributeName:shadow};
    } else {
        attrDict = @{NSForegroundColorAttributeName:c, NSFontAttributeName:f};
    }
    
    for (NSValue *value in rangeArrayM) {
        NSRange range = [value rangeValue];
        [self setAttributes:attrDict range:range];
    }
    
    for (NSValue *value in ssValueM) {
        NSRange range = [value rangeValue];
        [self setAttributes:attrDict range:range];
    }
    
    return self;
}

- (NSMutableAttributedString *)attributedStringByAddWordTapEvent {
    [self.string enumerateSubstringsInRange:NSMakeRange(0, self.string.length) options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL * stop) {
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 3;
        border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
        border.fillColor = [UIColor colorWithWhite:0.000 alpha:0.220];
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setBorder:border];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            NSDictionary *info = @{
                                   WCDidSelectedWordRectKey:[NSValue valueWithCGRect:rect],
                                   WCDidSelectedWordRangeKey:[NSValue valueWithRange:range],
                                   WCDidSelectedWordTextKey:text.string,
                                   WCDidSelectedWordContainerKey:containerView
                                   };
            [[NSNotificationCenter defaultCenter] postNotificationName:WCDidSelectedWordNotification object:nil userInfo:info];
        };
        [self setTextHighlight:highlight range:substringRange];
    }];
    return self;
}

@end
