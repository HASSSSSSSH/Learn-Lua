# Learn-Lua

此项目是本人在学习 Lua 过程中，为了加深对知识点的理解而编写的代码示例。

学习资源的主要来源是 [Lua 5.4 参考手册](https://www.lua.org/manual/5.4/contents.html) 和 [Lua 教程](https://www.runoob.com/lua/lua-tutorial.html)。



## 说明

示例被放置在一个与 Lua 文件名同名的表中，然后通过 [pairs 函数](https://www.lua.org/manual/5.4/manual.html#pdf-pairs) 迭代该表的所有键值对，从键值对中取出作为值存储的函数，最后调用该函数，以此运行一个 Lua 文件中的所有示例。例如，在 EnvExample.lua 中有这样的表声明：

```lua
--- EnvExample.lua
--- 关于 Lua 环境和全局环境的示例
EnvExample = {
    --- 全局环境 _G
    function()
        print("Example 1:")

        a = 1
        b = "test"
        c = { s = "zzz" }

        -- 全局环境 _G 默认为 table 类型
        print(type(_G), _G)

        -- 默认情况下, 对全局变量的访问相当于对全局环境中元素的访问
        print(a == _G.a)
        print(b == _G.b)
        print(c == _G.c)
    end,

    --- 输出全局环境 _G
    function()
        print("Example 2:")

        for i, v in pairs(_G) do
            print(i, v)
        end
    end,

    ...
}
```

上面的代码声明了一个 EnvExample 表，该表与文件名同名，其中包含了多个关于 Lua 环境和全局环境的示例。然后，在文件的末尾通过以下代码对该表进行迭代，以此运行示例：

```lua
--- 运行
for _, fun in pairs(EnvExample) do
    fun()
    print()
end
```

以下是运行后的输出：

```
Example 1:
table	table: 0000000000f21c50
true
true
true

Example 2:
pcall	function: 0000000065b9ca70
string	table: 0000000000f28ff0
...
```

所有的示例都带有注释，在关键代码上也有相关注释，可以通过阅读注释再配合运行和调试来进一步理解代码。

---------

项目包括以下文件夹和文件：

- **cpp**
  - **lua**：文件夹。其中包括 Lua 5.4.2 的头文件和库文件，可用于编译 C/C++ 文件。
  - **main.cpp**：C++ 调用 Lua 的示例。
  - **mycpplib.cpp**：在 Lua 调用 C++ 的示例中使用。
  - **point.cpp**：在 Lua 调用 C 库类型的示例中使用。
- **lib**
  - **mycpplib.dll**：由 mycpplib.cpp 编译得到的 C++ 库。
  - **point.dll**：由 point.cpp 编译得到的 C++ 库。
- **src**
  - **Array**
    - **ArrayExample.lua**：在 Lua 中实现数组的示例。示例包括：一维数组、多维数组、通过不相同的索引键实现二维数组等。
  - **Coroutine**
    - **CoroutineExample.lua**：关于 Lua 协程的示例。示例包括：协程的基本操作、协程的状态、生产者消费者问题等。
  - **Env**
    - **EnvExample.lua**：关于 Lua 环境和全局环境的示例。示例包括：输出全局环境 _G、更改全局环境 _G 等。
  - **ErrorHandling**
    - **ErrorHandlingExample.lua**：关于 Lua 错误处理的示例。示例包括：通过 error 引发错误、使用 pcall 捕获 Lua 中的错误等。
  - **Expression**
    - **ExpressionExample.lua**：关于 Lua 表达式的示例。示例包括：关系运算符、取长度运算符、多重表达式等。
  - **GC**
    - **GarbageCollectionExample.lua**：关于 Lua 垃圾回收的示例。示例包括：使用 collectgarbage 函数。
  - **Iterator**
    - **IteratorExample.lua**：关于 Lua 迭代器的示例。示例包括：无状态的迭代器、实现 ipairs 迭代器、多状态迭代器等。
  - **Metatable**
    - **MetatableExample.lua**：关于 Lua 元表的示例。示例包括：获取元表、设置元表、加法操作、相等性比较操作、索引访问操作、索引赋值操作、调用方法操作、tostring 事件等。
  - **Module**
    - **ModuleExample.lua**：关于 Lua 模块的示例。示例包括：使用 require 查找 Lua 库、使用 require 查找 C 库、使用 package.loadlib 函数将 C 库动态链接到程序 、使用 C 库中的类型等。
  - **ObjectOriented**
    - **ObjectOrientedExample.lua**：关于 Lua 模拟面向对象的示例。示例包括：模拟类和对象。
  - **Statement**
    - **StatementExample.lua**：关于 Lua 语句的示例。示例包括：赋值操作、for 语句、break 语句、return 语句等。
  - **Type**
    - **BasicTypeExample.lua**：关于 Lua 基本类型的示例。示例包括：nil 类型、boolean 类型、number 类型、string 类型、function 类型、userdata 类型、thread 类型、table 类型。
    - **FunctionExample.lua**：关于 Lua 函数的示例。示例包括：函数的定义和调用、模拟方法等。
    - **StringExample.lua**：关于 Lua 字符串的示例。示例包括：计算字符串的长度、截取字符串、查找字符串、字符串格式化等。
    - **TableExample.lua**：关于 Lua 表的示例。示例包括：table 元素的插入和移除、table 元素的排序等。
  - **Variable**
    - **VariableExample.lua**：关于 Lua 变量的示例。示例包括：全局变量和局部变量、Lua 按引用传递的示例、Lua 按值传递的示例等。
  - **Utils.lua**：Lua 库，在示例 ModuleExample 中使用。

