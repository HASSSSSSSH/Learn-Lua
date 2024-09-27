---
--- 关于 Lua 变量的示例
VariableExample = {
    --- 全局变量和局部变量
    function()
        print("Example 1:")

        -- 全局变量 a
        a = 1

        -- 局部变量 b
        local b = 10

        -- 一个新的语句块
        do
            -- 局部变量的作用域仅限于当前语句块
            -- 注意, 在此声明中由于新的局部变量 a 尚未声明, 因此右侧的 a 引用的是外部变量
            local a = a + 1

            -- a 是当前语句块的局部变量
            print("a =", a, "b =", b)

            -- 另一个语句块
            do
                -- 新的局部变量 a 和 b
                local a = a + 1
                local b = b + 1
                print("a =", a, "b =", b)
            end

            -- a 是当前语句块的局部变量
            print("a =", a, "b =", b)
        end

        print("a =", a, "b =", b)

        -- 语句块
        do
            -- 对全局变量 a 重新赋值
            a = a + 1

            -- 对局部变量 b 重新赋值
            b = b + 1

            -- 局部变量的作用域仅限于当前语句块
            local c = 0

            print("a =", a, "b =", b, "c =", c)
        end

        print("a =", a, "b =", b, "c =", c)
    end,

    --- Lua 按引用传递的示例
    function()
        print("Example 2:")

        local t1 = { a = 1, b = "Test", c = function()
            return "t1.c()"
        end }
        print(t1.a, t1.b, t1.c())

        -- table 中的元素是按引用传递的
        local t2 = t1
        t2.a = 10
        t2.b = "zzz"
        t2.c = function()
            return "t2.c()"
        end

        -- 再次输出 t1
        print(t1.a, t1.b, t1.c())

        -- 令 t2 为 nil
        t2 = nil

        print("t1: " .. tostring(t1), "\nt2: " .. type(t2))
    end,

    --- Lua 按值传递的示例
    function()
        print("Example 3:")

        local x1 = 1
        local y1 = x1
        y1 = 10
        print("x1:", x1)

        local x2 = "AAA"
        local y2 = x2
        y2 = "zzz"
        print("x2:", x2)

        local x3 = "AAA"
        local rep = function(str)
            return string.rep(str, 2)
        end
        rep(x3)
        print("x3:", x3)

        local x4 = { 1, "AAA" }
        local y4 = x4[1]
        y4 = 10
        print("x4[1]:", x4[1])
    end,
}

--- 运行
for _, fun in pairs(VariableExample) do
    fun()
    print()
end
