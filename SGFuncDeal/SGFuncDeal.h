//
//  FuncDeal.h
//  FuncInput函数输入类
//
//  Created by Soulghost on 2/22/15.
//  Copyright (c) 2015 soulghost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGFuncDeal : NSObject

/**
 --------------------------
         函数对照表：
 --------------------------
 函数名     书写方法     记法
 sin       sin         s
 cos       cos         c
 tan       tan         t
 arcsin    arcsin      a
 arccos    arccos      b
 arctan    arctan      d
 sqrt      sqrt        f
 log2      log         g
 log10     lg          h
 ln(loge)  ln          k
 abs       abs         l
 pow       ^()         ^()
 --------------------------
 --------------------------
         常量对照表：
 --------------------------
 常量名     书写方法     记法
 PI        p           p
 e         e           e
 --------------------------
 */

/**
 *  中缀表达式转后缀表达式
 *
 *  @param infix 中缀表达式
 *
 *  @return 后缀表达式
 */
+ (NSString *)makePostfixWithInfixString:(NSString *)infix;

/**
 *  后缀表达式求值（可带变量x）
 * 
 *  @param postfix 后缀表达式
 *  @param x 变量x
 *
 *  @return 表达式的值
 */

+ (float)calculateWithPostfixString:(NSString *)postfix variable:(float)x;


/**
 *
 *  为兼容以前版本保留，请忽视
 *
 */
+ (NSString *)transferMtoBWithString:(NSString *)func;
+ (float)computeWithBackmodefunc:(NSString *)bfunc andX:(float)x andY:(float)y;

@end
