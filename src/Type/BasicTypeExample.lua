---
--- 关于 Lua 基本类型的示例
BasicTypeExample = {
    --- nil 类型
    function()
        print("Example 1:")
        local b = nil
        printType(a)
        printType(b)
    end,

    --- boolean 类型
    function()
        print("Example 2:")
        local a = false
        local b = true
        printType(a)
        printType(b)
    end,

    --- number 类型
    function()
        print("Example 3:")
        local a = 1
        local b = 3.14
        printType(a)
        printType(b)
        printType(1e+2 + 0.01)
        printType("1e+3" + 0.01)
        printType(1e+4 + "0.01")
        printType("1e+5" + "0.01")
    end,

    --- string 类型
    function()
        print("Example 4:")
        local a = 'zzz'
        local b = "test"
        local c = [[
        New
        string
        ]]
        printType(a)
        printType(b)
        printType(c)
        -- printType(a + b)
        printType(a .. b .. 1e+2)
    end,

    --- function 类型
    function()
        print("Example 5:")
        local a = print
        local b = printType
        printType(a)
        printType(b)
    end,

    -- TODO: userdata 类型
    --
    --

    --- thread 类型
    function()
        print("Example 6:")
        local thread1 = coroutine.running()
        local thread2 = coroutine.create(
                function()
                    print("Test")
                end
        )
        printType(thread1)
        printType(thread2)
    end,

    --- table 类型
    function()
        print("Example 7:")
        local a = {
            name = "Test",
            x = 1,
            y = 1.0,
        }
        local b = {
            a = print,
            b = a,
        }
        printType(a)
        printType(b)
        printType(b.b)
    end,
}

--- 输出值的类型
function printType(value)
    print(type(value), ":", value)
end

--- 运行
for _, fun in pairs(BasicTypeExample) do
    fun()
    print()
end
