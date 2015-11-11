# SGFuncDeal
用于处理数学表达式运算的开源库，支持常见的数学函数、符号混合运算。

## 使用方法
将SGFuncDeal文件夹加入到项目中，并且包含SGFuncDeal.h，然后使用下面的静态方法来处理表达式。
### 将中缀表达式转为后缀表达式
我们知道，类似于5*(3+2)这样的表达式是符合人们自然书写习惯的，但不适合计算，这种式子称为中缀表达式。
要想方便计算，应该转为不含优先级关系的后缀表达式，形如3 2 + 5 *，这样只要从前到后处理即可得到结果。
为了实现转换，使用静态方法`+ (NSString *)makePostfixWithInfixString:(NSString *)infix;`
举例如下，把2*(3+x)转化为后缀表达式
```Objective-C
NSString *infix = @"2*(3+x)";
[SGFuncDeal makePostfixWithInfixString:infix];
// 得到的输出为:2 3 x + *
```

### 利用后缀表达式求值
当得到了后缀表达式，可以调用另一个静态方法求值，这里支持一个变量x(X)包含在表达式中。
```Objective-C
NSString *format = @"(2*sin(x)+3*(2+1))^(2)"; // 中缀表达式
float x = M_PI_2; // 变量x的值
NSString *postfix = [SGFuncDeal makePostfixWithInfixString:format]; // 得到后缀表达式
NSLog(@"后缀表达式：%@",postfix);
float res = [SGFuncDeal calculateWithPostfixString:postfix variable:x]; // 计算结果
NSLog(@"结果：%f",res);
```

###对数学函数的支持情况及书写
其中书写方法为中缀表达式中呈现的形式，记法为后缀表达式生成的形式。
 -------------------------- </br>
         函数对照表：</br>
 --------------------------</br>
 函数名     书写方法     记法</br>
 sin       sin         s </br>
 cos       cos         c</br>
 tan       tan         t</br>
 arcsin    arcsin      a</br>
 arccos    arccos      b</br>
 arctan    arctan      d</br>
 sqrt      sqrt        f</br>
 log2      log         g</br>
 log10     lg          h</br>
 ln(loge)  ln          k</br>
 abs       abs         l</br>
 pow       ^()         ^()</br>
 --------------------------</br>
 --------------------------</br>
         常量对照表：</br>
 --------------------------</br>
 常量名     书写方法     记法</br>
 PI        p           p</br>
 e         e           e</br>
 --------------------------</br>
