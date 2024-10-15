---
--- 关于 Lua table 的示例
TableExample = {
    --- table 元素的插入和移除
    function()
        print("Example 1:")

        local list = { "a", "b", nil, "c" }

        local printList = function()
            print(list[1], list[2], list[3], list[4], list[5])
        end

        -- 将新的元素插入到列表的末尾
        table.insert(list, "d")
        printList()

        -- 移除列表中的最后一个元素
        table.remove(list)
        printList()

        -- 移除列表中的最后一个元素
        table.remove(list)
        printList()

        -- 再次将新的元素插入到列表的末尾
        table.insert(list, "x")
        printList()

        -- 移除列表中的最后一个元素
        table.remove(list, #list)
        printList()

        -- 指定新元素的插入位置
        -- 注意, 插入的位置不可超出 #list + 1
        table.insert(list, #list, "y")
        table.insert(list, #list + 1, "z")
        --table.insert(list, 10, "z")
        printList()
    end,

    --- table 元素的排序
    function()
        print("Example 2:")

        local list = { "Test", "AA", "zzz", "c", "SSS" }

        local printList = function()
            local text = "{ "
            for _, v in pairs(list) do
                text = text .. v .. ", "
            end
            text = text .. "}"
            print(text)
        end

        -- 输出列表
        printList()

        -- 按字符串的长度降序排序
        table.sort(list, function(a, b)
            --return #a >= #b
            return #a > #b
        end)

        -- 输出列表
        printList()
    end,
}

--- 运行
for _, fun in pairs(TableExample) do
    fun()
    print()
end
