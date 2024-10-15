---
--- 关于 Lua 函数的示例
FunctionExample = {
    --- 函数的定义和调用
    function()
        print("Example 1:")

        local function f(a, b)
            if not a then
                a = "nil"
            end
            if not b then
                b = "nil"
            end
            print(f, "f(" .. a .. ", " .. b .. ")")
        end

        -- 可变参数函数
        -- 其中 ... 是可变参数表达式
        local function g(a, b, ...)
            if not a then
                a = "nil"
            end
            if not b then
                b = "nil"
            end

            local s = ""

            -- 可通过 select("#", ...) 获取可变参数的数量
            if select("#", ...) > 0 then
                local arg = { ... }
                for _, v in ipairs(arg) do
                    s = s .. ", " .. tostring(v)
                end
            end

            print(g, "g(" .. a .. ", " .. b .. s .. ")")
        end

        -- 具有多个返回值的函数
        local function r()
            return 1, 2, 3
        end

        -- a = 10, b = nil
        f(10)

        -- a = 10, b = 20
        f(10, 20)

        -- a = 10, b = 20
        f(10, 20, 30)

        -- a = 1, b = 10
        f(r(), 10)

        -- a = 1, b = 2
        f(r())

        -- a = 10, b = nil, ... --> (nothing)
        g(10)

        -- a = 10, b = 20, ... --> (nothing)
        g(10, 20)

        -- a = 10, b = 20, ... --> 30, 40
        g(10, 20, 30, 40)

        -- a = 10, b = 1, ... --> 2, 3
        g(10, r())
    end,

    --- 模拟方法
    function()
        print("Example 2:")

        local t = { tag = "TEST" }

        -- 冒号语法用于模拟方法, 可以为函数添加隐式的额外参数 self
        function t:getTag()
            return self.tag
        end

        function t:toString()
            return self.getTag(self)
        end

        print(t.toString(t))
    end
}

--- 运行
for _, fun in pairs(FunctionExample) do
    fun()
    print()
end
