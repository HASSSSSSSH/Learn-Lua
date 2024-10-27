---
--- 关于 Lua 表达式的示例
ExpressionExample = {
    --- 关系运算符
    function()
        print("Example 1:")

        local a = 1
        local b = 6.66
        local t1 = { "Test" }
        local t2 = { "Test" }
        local t3 = t1
        local f1 = function() end
        local f2 = function() end
        local f3 = f1

        -- 运算符 == 首先比较操作数的类型
        print("(a == t1)", a == t1)

        -- 对于 number 类型, 当两者具有相同数值时相等
        print("(a == b)", a == b)

        -- 对于 string 类型, 当两者具有相同字节内容时相等
        print("(t1[1] == t2[1])", t1[1] == t2[1])

        -- 对于 table, userdata, thread, function 类型, 比较的是引用
        print("(t1 == t2)", t1 == t2)
        print("(t1 == t3)", t1 == t3)
        print("(f1 == f2)", f1 == f2)
        print("(f1 == f3)", f1 == f3)

        print("(\"1\" ~= 1)", "1" ~= 1)
    end,

    --- 逻辑运算符
    function()
        print("Example 2:")

        local a = nil
        local b = false
        local c = 0

        -- 对于 and 运算符, 如果第一个参数值为 false 或者 nil, 返回第一个参数
        -- 否则返回第二个参数
        print(a and b)
        print(b and a)
        print(c and -1)

        -- 对于 or 运算符, 如果第一个参数值不为 false 或者 nil, 返回第一个参数
        -- 否则返回第二个参数
        print(a or b)
        print(b or a)
        print(c or -1)

        -- not 运算符始终返回 true 或者 false
        -- 将 false 和 nil 视为 false, 将其他任何值视为 true
        print(not a)
        print(not b)
        print(not c)
    end,

    --- 取长度运算符 #
    function()
        print("Example 3:")

        -- 字符串的长度是其字节的数量
        -- 当每个字符都是一个字节时, 得到的长度是字符串的实际长度
        local str = "Test string"
        print("\"Test string\" length: " .. #str)

        -- 对 table 应用 # 运算符, 返回的是 table 的边长
        local t1 = { 10, 20, 30, 40, 50 }
        print("t1 length: " .. #t1)

        -- 当索引 1 不存在时, 返回 0
        local t2 = {}
        t2[2] = "aaa"
        t2[5] = "zzz"
        t2.str = "test"
        print("t2 length: " .. #t2)

        -- 运算符 # 不一定能够得到 table 的实际长度
        local t3 = { 10, 20, 30, nil, 40, 50 }
        local t4 = { 10, 20, nil }
        local t5 = { 10, nil, 20, nil }
        local t6 = { 10, 20, s = "test", 30, f = function() return 0 end }
        print("t3 length: " .. #t3)
        print("t4 length: " .. #t4)
        print("t5 length: " .. #t5)
        print("t6 length: " .. #t6)

        -- 获取 table 的实际长度
        print("getTableLength(t1): " .. getTableLength(t1))
        print("getTableLength(t2): " .. getTableLength(t2))
        print("getTableLength(t3): " .. getTableLength(t3))
        print("getTableLength(t4): " .. getTableLength(t4))
        print("getTableLength(t5): " .. getTableLength(t5))
        print("getTableLength(t6): " .. getTableLength(t6))
    end,

    --- 多重表达式
    function()
        print("Example 4:")

        local function f()
            return 1, 2, 3
        end

        local function g()
            return 10, 20, 30
        end

        local function test(...)
            -- x, y, z 分别为可变参数的第 1, 2, 3 个值
            local x, y, z = ...
            print("x = " .. x .. ", y = " .. y .. ", z = " .. z)

            -- 输出 x 和 f() 的所有结果
            print(x, f())

            -- 输出 x 和 f() 的第一个结果
            print(x, (f()))

            -- 输出 f() 的第一个结果和 x
            print(f(), x)

            -- 输出 f() 的第一个结果加 1
            print(1 + f())

            -- x 为可变参数中的第一个值
            -- y 为 f() 的第一个结果
            -- z 为 f() 的第二个结果
            x, y, z = ..., f()
            print("x = " .. x .. ", y = " .. y .. ", z = " .. z)

            -- x 为 f() 的第一个结果
            -- y 为 f() 的第二个结果
            -- z 为 f() 的第三个结果
            x, y, z = f()
            print("x = " .. x .. ", y = " .. y .. ", z = " .. z)

            -- x 为 f() 的第一个结果
            -- y 为 g() 的第一个结果
            -- z 为 g() 的第二个结果
            x, y, z = f(), g()
            print("x = " .. x .. ", y = " .. y .. ", z = " .. z)

            -- x 为 f() 的第一个结果, y 和 z 都为 nil
            x, y, z = (f())
            print("x = " .. x .. ", y = " .. type(y) .. ", z = " .. type(z))

            -- 创建一个 table, 其中包括所有可变参数 
            local t1 = { ... }
            print("getTableLength(t1): " .. getTableLength(t1))

            -- 创建一个 table, 其中包括一个 string 和 f() 的所有结果
            local t2 = { "test", f() }
            print("getTableLength(t2): " .. getTableLength(t2))

            -- 创建一个 table, 其中包括 f() 的第一个结果和一个 string
            local t3 = { f(), "test" }
            print("getTableLength(t3): " .. getTableLength(t3))

            -- 返回 f() 的所有结果
            --return f()

            -- 返回 x 和所有可变参数
            --return x, ...

            -- 返回 x, y 以及 f() 的所有结果
            --return x, y, f()
        end

        test("X", "Y", "Z")
    end
}

--- 获取 table 的实际长度
function getTableLength(table)
    if type(table) ~= "table" then
        return
    end

    local len = 0
    for _, _ in pairs(table) do
        len = len + 1
    end
    return len
end

--- 运行
for _, fun in pairs(ExpressionExample) do
    fun()
    print()
end
