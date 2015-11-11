//
//  Stack.m
//  表达式求值
//
//  Created by 11 on 2/21/15.
//  Copyright (c) 2015 soulghost. All rights reserved.
//

#import "SGStack.h"

@implementation SGStack

- (instancetype)initWithEmptyStack{
    
    if (self = [super init]) {
        self.stack = [NSMutableArray array];
        self.numBuffer = [NSMutableArray array];
    }
    
    return self; 
    
}

- (BOOL)addToBufferWithFloat:(float)f{
    
    [self.numBuffer addObject:@(f)];
    
    return self.numBuffer.count <= 2 ? YES : NO;
    
}

- (float)popFromBuffer{
    
    float buffer = [[self.numBuffer lastObject] floatValue];
    
    [self.numBuffer removeLastObject];
    
    return buffer;
}

- (BOOL)addToBufferWithX{
    
    [self.numBuffer addObject:@'x'];
    
    return self.numBuffer.count <= 2 ? YES : NO;
}

- (unichar)pop{
    
    if (self.stack.count > 0) {
        unichar c = [[self.stack lastObject] intValue];
        [self.stack removeLastObject];
        return c;
    }else{
        NSLog(@"the stack is empty");
        return 0;
    }
    
}

- (void)pushWithUnichar:(unichar)character{

    [self.stack addObject:@(character)];
    
}

- (BOOL)isNotEmpty{
    
    return self.stack.count > 0;
    
}

@end
