---
--- 关于 Lua 垃圾回收的示例
GarbageCollectionExample = {
    --- collectgarbage 函数
    function()
        print("Example 1:")

        local table = {}
        for i = 1, 10 ^ 5 do
            table[i] = "A"
        end

        -- collectgarbage 函数是 GC 的通用接口
        -- 根据第一个参数 opt 来执行不同的函数
        print(collectgarbage("isrunning"))

        -- 返回 Lua 使用的总内存量 (以 KB 为单位)
        print(collectgarbage("count") .. " KB")

        -- 令变量 table 不再引用之前的值
        table = nil

        print(collectgarbage("count") .. " KB")

        -- 执行一次完整的 GC
        collectgarbage("collect")

        print(collectgarbage("count") .. " KB")
    end,
}

--- 运行
for _, fun in pairs(GarbageCollectionExample) do
    fun()
    print()
end
