---
--- 关于 Lua 语句的示例
StatementExample = {
    --- 赋值
    function()
        print("Example 1:")

        local t = {}
        local i = 1

        -- 等同于
        -- i = i + 1
        -- t[1] = 10 * 10
        -- 如果在多重赋值中对同一变量进行赋值和读取, Lua 会确保所有读取操作都会在赋值之前完成
        i, t[i] = i + 1, 10 * 10
        print("i =", i, "t[1] =", t[1])

        -- 交换变量的值
        local x, y = 1, 10
        print("x =", x, "y =", y)
        x, y = y, x
        print("x =", x, "y =", y)

        -- 对多个变量赋值
        local a, b, c = 1
        print("a =", a, "b =", b, "c =", c)
        a, b, c = "a", "b"
        print("a =", a, "b =", b, "c =", c)
        a, b, c = 10, 100, 1000
        print("a =", a, "b =", b, "c =", c)
    end,

    --- if 语句
    function()
        print("Example 2:")

        local f = function(a)
            if (a) then
                return true
            else
                return false
            end
        end

        -- 在 Lua 中, 只有 false 和 nil 视为假
        print(f(nil))
        print(f(false))
        print(f(0))
        print(f(-1))
        print(f(""))
        print(f({}))
    end,

    --- for 语句
    function()
        print("Example 3:")

        -- 步长默认为 1
        for i = 1, 5 do
            print(i)
        end
        print("------")

        -- 将步长指定为 3
        for i = 1, 5, 3 do
            print(i)
        end
        print("------")

        -- for 语句的 3 个表达式只在循环开始时计算一次
        local t = { }
        function t.f(x)
            print("call t.f(" .. x .. ")")
            return 10 * x
        end
        for i = t.f(0.1), t.f(1), t.f(0.3) do
            print(i)
        end
    end,

    --- break 语句
    function()
        print("Example 4:")

        -- 初始化一个二维数组
        local array = {}
        local maxRows = 2
        local maxColumns = 3
        for row = 1, maxRows do
            for col = 1, maxColumns do
                array[row * maxColumns + col] = row * col
            end
        end

        -- 遍历数组, 找到等于 target 的元素
        local target = 2
        for row = 1, maxRows do
            local col = 1
            while (col < maxColumns) do
                if array[row * maxColumns + col] == target then
                    -- break 只跳出最内层的循环
                    -- 这一行的未遍历元素只会大于当前元素, 因此可以直接跳出 while 循环
                    break
                end
                col = col + 1
            end
            print("array[" .. row .. ", " .. col .. "] = "
                    .. "array[" .. row * maxColumns + col .. "] = " .. target)
        end
    end,

    --- return 语句
    function()
        print("Example 5:")

        -- 遍历数组, 找到等于 target 的元素
        local t = {}
        function t.findTarget(array, maxRows, maxColumns, target)
            for row = 1, maxRows do
                for col = 1, maxColumns do
                    if array[row * maxColumns + col] == target then
                        -- 函数可以返回多个值
                        return row, col
                    end
                end
            end
        end

        -- 初始化一个二维数组
        local array = {}
        local maxRows = 2
        local maxColumns = 3
        for row = 1, maxRows do
            for col = 1, maxColumns do
                array[row * maxColumns + col] = row * col
            end
        end

        -- 接收函数的返回值
        local a, b, c = t.findTarget(array, maxRows, maxColumns, 2)
        print("a =", a, "b =", b, "c =", c)
        print("array[" .. a .. ", " .. b .. "] = " .. array[a * maxColumns + b])
    end,
}

--- 运行
for _, fun in pairs(StatementExample) do
    fun()
    print()
end
