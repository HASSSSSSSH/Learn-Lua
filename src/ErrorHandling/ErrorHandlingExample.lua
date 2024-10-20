---
--- 关于 Lua 错误处理的示例
ErrorHandlingExample = {
    --- 通过 error 引发错误
    function()
        print("Example 1:")

        local f = function(n)
            if (n == 1) then
                -- 引发错误, 并将 message 作为错误对象
                -- 当错误对象是字符串时, 会在 message 开头添加一些有关错误位置的信息
                error("Error test 1")
            elseif (n == 2) then
                -- 将参数 level 设为 0
                -- 表示不添加错误位置信息到 message 中
                error("Error test 2", 0)
            elseif (n == 3) then
                -- 将参数 level 设为 2
                -- 表示将错误指向调用错误的函数的位置
                error("Error test 3", 2)
            else
                -- 错误对象可以是任意类型
                error(function()
                    print("Error test!")
                end)
            end
        end

        -- 调用引发错误的函数
        print(pcall(f, 1))
        print(pcall(f, 2))
        print(pcall(f, 3))
        print(pcall(f))
    end,

    --- 使用 pcall 捕获 Lua 中的错误
    function()
        print("Example 2:")

        local f = function(a, b)
            return a .. b
        end

        -- 函数 pcall 在受保护模式下调用给定函数
        -- 如果调用成功且没有错误, 返回 true 和所有结果
        print(pcall(f, 1, "0"))

        -- 运行的函数出现任何错误都会使其停止执行, 控制权会立即交回 pcall
        print(pcall(f, 1))
    end,

    --- 使用 xpcall 捕获 Lua 中的错误
    function()
        print("Example 3:")

        local f = function(a, b)
            return a .. b
        end

        local errorHandler = function(msg)
            -- handler 仍存于受保护的调用中
            -- 因此, handler 中的错误将再次调用 handler
            -- 但是, 如果此循环持续太长时间, Lua 会中断它并返回适当的消息
            --error("test")

            -- handler 在错误展开栈之前被调用, 以便可以收集有关错误的更多信息
            -- 此时可以查看并打印调用栈
            print(debug.traceback())

            msg = "errorHandler catch error: " .. msg
            --print(msg)
            return msg
        end

        -- xpcall 与 pcall 类似
        -- 只是 xpcall 支持设置一个 handler 用于处理错误
        print(xpcall(f, errorHandler))
    end,
}

--- 运行
for _, fun in pairs(ErrorHandlingExample) do
    fun()
    print()
end
