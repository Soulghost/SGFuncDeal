//
//  ViewController.m
//  SGFuncDealDemo
//
//  Created by 11 on 11/11/15.
//  Copyright © 2015 soulghost. All rights reserved.
//

#import "ViewController.h"
#include "SGFuncDeal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 先得到后缀表达式，然后求值，这种情况下可以先缓存后缀表达式，在需要计算的时候求解即可。
    {
        NSString *format = @"(2*sin(x)+3*(2+1))^(2)";
        float x = M_PI_2;
        NSString *cache = [SGFuncDeal makePostfixWithInfixString:format];
        NSLog(@"后缀表达式：%@",cache);
        float res = [SGFuncDeal calculateWithPostfixString:cache variable:x];
        NSLog(@"计算结果：%f",res);
    }
    
    // 直接计算
    {
        float x = 1000;
        float res = [SGFuncDeal calculateWithPostfixString:[SGFuncDeal makePostfixWithInfixString:@"abs(lg(x)-5)^(3)"]variable:x];
        NSLog(@"%f",res);
    }
    
    
}

@end
