//
//  NSString+Emoji.h
//  CommentCell
//
//  Created by power on 2017/6/5.
//  Copyright © 2017年 powertorque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;

@end
