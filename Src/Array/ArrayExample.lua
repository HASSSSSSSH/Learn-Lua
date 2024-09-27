---
--- 在 Lua 中实现数组
ArrayExample = {
    --- 一维数组
    function()
        print("Example 1:")

        -- 使用 table 实现数组
        local array = { 10, 20, 30, 40, 50 }

        -- 索引默认从 1 开始
        print(array[1], array[2], array[3], array[4], array[5])
    end,

    --- 多维数组
    function()
        print("Example 2:")

        -- 二维数组迭代器
        local iterator = {}

        -- 使用 table 实现二维数组
        local maxRows = 2
        local maxColumns = 3
        local array = {}
        local n = 0
        for i = 1, maxRows do
            array[i] = {}
            for j = 1, maxColumns do
                n = n + 1
                array[i][j] = n
            end
        end

        -- 遍历二维数组
        function iterator.iterate(arr, rows, columns)
            local text = "[ "
            for row = 1, rows do
                for col = 1, columns do
                    text = text .. arr[row][col] .. ", "
                end
                text = text .. "]"
                print(text)
                text = "[ "
            end
        end

        -- 遍历二维数组 array
        iterator.iterate(array, maxRows, maxColumns)
    end,

    --- 通过不相同的索引键实现二维数组
    function()
        print("Example 3:")

        local maxRows = 2
        local maxColumns = 3
        local array = {}
        local n = 0
        for row = 1, maxRows do
            for col = 1, maxColumns do
                n = n + 1
                array[row * maxColumns + col] = n
            end
        end

        -- 遍历数组
        local text = "[ "
        for row = 1, maxRows do
            for col = 1, maxColumns do
                text = text .. array[row * maxColumns + col] .. ", "
            end
            text = text .. "]"
            print(text)
            text = "[ "
        end
    end,

    --- 删除数组中的元素
    function()
        print("Example 4:")

        -- 使用 table 实现数组
        local array = { 10, 20, 30, 40, 50 }

        -- 删除第 3 个元素
        table.remove(array, 3)

        -- 遍历数组
        for i = 1, #array do
            print(array[i])
        end
    end,
}

--- 运行
for _, fun in pairs(ArrayExample) do
    fun()
    print()
end
