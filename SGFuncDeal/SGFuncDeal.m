//
//  FuncDeal.m
//  FuncInput函数输入类
//
//  Created by Soulghost on 2/22/15.
//  Copyright (c) 2015 soulghost. All rights reserved.
//

#import "SGFuncDeal.h"
#import "SGStack.h"

@implementation SGFuncDeal

BOOL isnum(unichar c){
    NSString *table = @"0123456789.xXyY";
    BOOL result = NO;
    for (int i = 0; i < table.length; i++) {
        if (c == [table characterAtIndex:i]) {
            result = YES;
            break;
        }
    }
    return result;
}

BOOL isConst(unichar c){
    NSString *table = @"pe";
    BOOL result = NO;
    for (int i = 0; i < table.length; i++) {
        if (c == [table characterAtIndex:i]) {
            result = YES;
            break;
        }
    }
    return result;
}

BOOL isVar(unichar c){
    NSString *table = @"xXyY";
    BOOL result = NO;
    for (int i = 0; i < table.length; i++) {
        if (c == [table characterAtIndex:i]) {
            result = YES;
            break;
        }
    }
    return result;
}

BOOL isClearNum(unichar c){
    NSString *table = @"0123456789.";
    BOOL result = NO;
    for (int i = 0; i < table.length; i++) {
        if (c == [table characterAtIndex:i]) {
            result = YES;
            break;
        }
    }
    return result;
}

BOOL isinTable(NSString *table, unichar c){
    BOOL result = NO;
    for (int i = 0; i < table.length; i++) {
        if (c == [table characterAtIndex:i]) {
            result = YES;
            break;
        }
    }
    return result;
}

BOOL isBigger(unichar stack_c, unichar new_c){
    BOOL result = NO;
    if (new_c == '(') {
        result = YES;
    }else if (isinTable(@"*/", new_c)){
        if (isinTable(@"*/", stack_c)) result = NO;
        else result = YES;
    }else if (isinTable(@"+-", new_c)){
        if (stack_c != '(')
            result = NO;
        else
            result = YES;
    }
    return result;
}

NSString * replaceXY(NSString *origin, float x, float y){
    
    NSMutableString *final = [NSMutableString string];
    
    for (int i = 0;i < origin.length; i++) {
        
        unichar c = [origin characterAtIndex:i];
        switch (c) {
            case 'x':
            case 'X':
                [final appendFormat:@"%f",x];
                break;
            case 'e':
                [final appendFormat:@"%f ",M_E];
                break;
            case 'p':
                [final appendFormat:@"%f ",M_PI];
                break;
            case 'y':
            case 'Y':
                [final appendFormat:@"%f",y];
                break;
            default:
                [final appendFormat:@"%c",c];
                break;
        }
        
        
    }
    
    return final;
    
}

+ (NSString *)fixMissingProduct:(NSString *)input{
    
    NSMutableString *result = [NSMutableString string];
    
    for (int i = 0; i < input.length - 1; i++) {
        unichar now = [input characterAtIndex:i];
        unichar next = [input characterAtIndex:i+1];
        if ( (isClearNum(now) && isalpha(next)) || (isnum(now) && isalpha(next)) || (isConst(now) && isalpha(next)) ) {
            [result appendFormat:@"%c*",now];
        }else{
            [result appendFormat:@"%c",now];
        }

    }
    
    [result appendFormat:@"%c",[input characterAtIndex:input.length-1]];
    return result;
    
}

+ (NSString *)addZeroBeforeNeg:(NSString *)input{
    
    NSMutableString *result = [NSMutableString string];
    
    for (int i = 0; i < input.length - 1; i++) {
        
        unichar now = [input characterAtIndex:i];
        unichar next = [input characterAtIndex:i+1];
        
        if (i == 0 && now == '-') {
            result = [NSMutableString stringWithFormat:@"0%@",input];
            return result;
        }
        
        if (now == '(' && next == '-') {
            [result appendFormat:@"(0"];
        }else{
            [result appendFormat:@"%c",now];
        }
        
    }
    
    [result appendFormat:@"%c",[input characterAtIndex:input.length - 1]];
    
    return result;
    
}

+ (NSString *)transferMtoBWithString:(NSString *)func{
    
    if ([func isEqualToString:@""]) {
        return @"0";
    }

    func = [self addZeroBeforeNeg:func];
    
    func = [self fixMissingProduct:func];
    
    SGStack *stack = [[SGStack alloc] initWithEmptyStack];
    
    NSMutableString *buffer = [NSMutableString string];
    
    NSMutableString *funcBuffer = [NSMutableString string];
    
    BOOL lastIsNum = YES;
    
    BOOL startWithleft = [func characterAtIndex:0] == '(';
    
    BOOL findFunc = NO;
    
    NSMutableArray *funcNameArray = [NSMutableArray array];
    
    int stage = 0;
    
    NSMutableDictionary *isFunc = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < func.length; i++) {
        
        unichar c = [func characterAtIndex:i];
        if (c == ' ') continue;
        if (isnum(c)) {
            if (NO == lastIsNum) {
                
                if (NO == startWithleft) {
                    [buffer appendString:@" "];
                }else{
                    startWithleft = NO;
                }
                
            }
            [buffer appendFormat:@"%c",c];
            lastIsNum = YES;
        }else if(isalpha(c)||c == '^'){
            
            switch (c) {
                case 'e':
                    [buffer appendFormat:@" %c",'e'];
                    continue;
                    break;
                case 'p':
                    [buffer appendFormat:@" %c",'p'];
                    continue;
                    break;
                default:
                    break;
            }
            [funcBuffer appendFormat:@"%c",c];
            NSString *funcName = [NSString string];
            if ([funcBuffer isEqualToString:@"log"]) {
                funcName = [NSString stringWithFormat:@" g"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"lg"]){
                funcName = [NSString stringWithFormat:@" h"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"ln"]){
                funcName = [NSString stringWithFormat:@" k"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"sqrt"]){
                funcName = [NSString stringWithFormat:@" f"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"cos"]){
                funcName = [NSString stringWithFormat:@" c"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"sin"]){
                funcName = [NSString stringWithFormat:@" s"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"^"]){
                funcName = [NSString stringWithFormat:@" ^"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"tan"]){
                funcName = [NSString stringWithFormat:@" t"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"arcsin"]){
                funcName = [NSString stringWithFormat:@" a"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"arccos"]){
                funcName = [NSString stringWithFormat:@" b"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"arctan"]){
                funcName = [NSString stringWithFormat:@" d"];
                findFunc = YES;
            }else if([funcBuffer isEqualToString:@"abs"]){
                funcName = [NSString stringWithFormat:@" l"];
                findFunc = YES;
            }
            if (YES == findFunc) {
                findFunc = NO;
                [funcNameArray addObject:funcName];
                funcBuffer = [NSMutableString string];
                stage ++;
                [isFunc setValue:@(YES) forKey:[NSString stringWithFormat:@"%d",stage]];
            }
            continue;
            
        }else{
            lastIsNum = NO;
            if (c == ')') {
                
                unichar stack_c = [stack pop];
                
                while (stack_c != '(') {
                    [buffer appendString:@" "];
                    [buffer appendFormat:@"%c",stack_c];
                    stack_c = [stack pop];
                    if (stack_c == 0) {
                        return @"0";
                    }
                }
                [buffer appendFormat:@"%@",[funcNameArray lastObject]];
                [funcNameArray removeLastObject];
                
                stage --;
                
                continue;
            }
            
            if (![stack isNotEmpty] && c == '(' && i == 0) {
                [funcNameArray addObject:@""];
            }
            
            if ([stack isNotEmpty]) {
                while ([stack isNotEmpty]) {
                    unichar stack_c = [[stack.stack lastObject] integerValue];
                    if (isBigger(stack_c, c)) {
                        if (c == '(') {
                            if (i > 0) {
                                if (!isalpha([func characterAtIndex:i-1])&&[func characterAtIndex:i-1]!='^') {
                                    [funcNameArray addObject:@""];
                                }
                            }else{
                                [funcNameArray addObject:@""];
                            }
                            stage ++;
                            [isFunc setValue:@(NO) forKey:[NSString stringWithFormat:@"%d",stage]];
                        }
                        [stack pushWithUnichar:c];
                        break;
                    }else{
                        [buffer appendString:@" "];
                        [buffer appendFormat:@"%c",stack_c];
                        [stack pop];
                    }
                    if (![stack isNotEmpty]) {
                        [stack pushWithUnichar:c];
                        break;
                    }
                }
            }else{
                [stack pushWithUnichar:c];
            }
        }
    }
    while ([stack isNotEmpty]) {
        [buffer appendString:@" "];
        [buffer appendFormat:@"%c",[stack pop]];
    }
    
    return buffer;
    
}

+ (NSString *)fixSpaces:(NSString *)input{
    
    NSMutableString *result = [NSMutableString string];
    
    for (int i = 0; i < input.length - 1; i++) {
        
        unichar now = [input characterAtIndex:i];
        unichar next = [input characterAtIndex:i+1];
        if (now == ' ' && next == ' ') {
            [result appendString:@" "];
            i++;
        }else{
            [result appendString:[NSString stringWithFormat:@"%c",now]];
        }
        
    }
    
    [result appendFormat:@"%c",[input characterAtIndex:input.length-1]];
    return result;
    
}

+ (float)computeWithBackmodefunc:(NSString *)bfunc andX:(float)x andY:(float)y{

    float result = 0;
    
    SGStack *stack = [[SGStack alloc] initWithEmptyStack];
    
    if ([bfunc hasPrefix:@" "]) {
        bfunc = [bfunc substringFromIndex:1];
    }
    
    NSString *new = replaceXY(bfunc, x, y);
    
    new = [self fixSpaces:new];
    
    NSArray *strs = [new componentsSeparatedByString:@" "];
    
    for (int i = 0; i < strs.count; i++) {
        if ([strs[i] floatValue] || [strs[i] isEqualToString:@"0"]) {
            [stack addToBufferWithFloat:[strs[i] floatValue]];
        }else{
            NSString *checkStr = strs[i];
            if (checkStr.length < 1) {
                return 0;
            }
            if(isalpha([strs[i] characterAtIndex:0])){
                
                unichar c = [strs[i] characterAtIndex:0];
                
                float value = [stack popFromBuffer];
                
                switch (c) {
                    case 's':
                        result = sin(value);
                        break;
                    case 'c':
                        result = cos(value);
                        break;
                    case 't':
                        result = tan(value);
                        break;
                    case 'a':
                        result = asin(value);
                        break;
                    case 'b':
                        result = acos(value);
                        break;
                    case 'd':
                        result = atan(value);
                        break;
                    case 'f':
                        result = sqrt(value);
                        break;
                    case 'g':
                        result = log2(value);
                        break;
                    case 'h':
                        result = log10(value);
                        break;
                    case 'k':
                        result = log(value);
                        break;
                    case 'l':
                        result = fabs(value);
                        break;
                    default:
                        break;
                }
                [stack addToBufferWithFloat:result];
                result = 0;
                
                continue;
            }
            float value1 = [stack popFromBuffer];
            float value2 = [stack popFromBuffer];
            unichar c = [strs[i] characterAtIndex:0];
            switch (c) {
                case '+':
                    result = value2 + value1;
                    break;
                case '-':
                    result = value2 - value1;
                    break;
                case '*':
                    result = value2 * value1;
                    break;
                case '/':
                    result = value2 / value1;
                    break;
                case '^':
                    result = pow(value2, value1);
                    break;
                default:
                    break;
            }
            [stack addToBufferWithFloat:result];
            result = 0;
        }
    }
    if (stack.numBuffer.count != 1) {
        return 0;
    }
    return [stack popFromBuffer];
    
}

+ (NSString *)makePostfixWithInfixString:(NSString *)infix{
    return [self transferMtoBWithString:infix];
}

+ (float)calculateWithPostfixString:(NSString *)postfix variable:(float)x{
    return [self computeWithBackmodefunc:postfix andX:x andY:0];
}

@end
