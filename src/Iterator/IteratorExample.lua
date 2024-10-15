---
--- 关于 Lua 迭代器的示例
IteratorExample = {
    --- 无状态的迭代器
    function()
        print("Example 1:")

        -- 一个无状态的迭代器只需要状态常量和控制变量的值就可以获取下一个元素
        local function square(iteratorMaxCount, currentNumber)
            if currentNumber < iteratorMaxCount
            then
                currentNumber = currentNumber + 1

                -- 实现数字的平方
                return currentNumber, currentNumber * currentNumber
            end
        end

        -- 在 in 后面的是一个表达式列表, 应返回泛型 for 需要的 3 个值
        -- 分别为迭代函数, 状态常量和控制变量
        -- 在每次迭代中, 将状态常量和控制变量的值传递给迭代函数 square
        for i, n in square, 3, 0
        do
            -- 数字 n 为数字 i 的平方
            print(i, n)
        end
    end,

    --- 实现 ipairs 迭代器
    function()
        print("Example 2:")

        -- 迭代函数
        local function iterate(table, i)
            i = i + 1
            local v = table[i]
            if v then
                return i, v
            end
        end

        -- 迭代器应返回泛型 for 需要的 3 个值
        -- 分别为迭代函数, 状态常量 (在循环中不会改变) 和 控制变量 (此处是 table 当前的索引)
        local function ipairs(table)
            return iterate, table, 0
        end

        local t = { 10, "test", "zzz", 100 }
        for i, v in ipairs(t) do
            print(i, v)
        end
    end,

    --- 多状态迭代器
    function()
        print("Example 3:")

        local function elementIterator(table)
            local index = 0
            local count = #table

            -- 通过闭包函数保存多个状态信息
            return function()
                index = index + 1
                if index <= count then
                    -- 返回当前元素
                    return table[index]
                end
            end
        end

        local t = { 10, "test", "zzz", 100 }
        for element in elementIterator(t) do
            print(element)
        end
    end,
}

--- 运行
for _, fun in pairs(IteratorExample) do
    fun()
    print()
end
