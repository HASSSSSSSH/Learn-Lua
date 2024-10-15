---
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

    --- 更改全局环境 _G
    function()
        print("Example 3:")

        -- _G 未在内部使用
        -- 因此更改 _G 的值只会影响自己的代码
        _G = "TEST"
        print("type(_G): " .. type(_G) .. ", _G: " .. _G)

        -- 不影响声明新的全局变量
        -- 因为全局变量声明在名为 _ENV 的外部局部变量中
        s = "AAA"
        t = { 10, 20, 30 }
        print("s:", s, "\nt:", t)

        -- 当 Lua 加载一个代码块时, 其 _ENV 变量的默认值是全局环境
        print("_VERSION:", _VERSION)
        print("math:", math)
        print("setmetatable:", setmetatable)
        print("_G:", _G)
    end,
}

--- 运行
for _, fun in pairs(EnvExample) do
    fun()
    print()
end
