//
//  Stack.h
//  表达式求值
//
//  Created by 11 on 2/21/15.
//  Copyright (c) 2015 soulghost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGStack : NSObject

@property (nonatomic, strong) NSMutableArray *stack;
@property (nonatomic, strong) NSMutableArray *numBuffer;

- (instancetype)initWithEmptyStack;
- (unichar)pop;
- (void)pushWithUnichar:(unichar)character;
- (BOOL)isNotEmpty;
- (BOOL)addToBufferWithFloat:(float)f;
- (BOOL)addToBufferWithX;
- (float)popFromBuffer;

@end
