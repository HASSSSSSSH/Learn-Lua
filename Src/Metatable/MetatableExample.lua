---
--- 关于 Lua metatable 的示例
MetatableExample = {
    --- 获取元表
    function()
        print("Example 1:")

        -- 默认情况下, 值没有元表
        -- 但是, 字符串库为 string 类型设置了元表
        local str = "Test"
        local metatable = getmetatable(str)
        printTable(metatable)
    end,

    --- 设置元表
    function()
        print("Example 2:")

        local table = {}
        setmetatable(table, {
            __len = function(_)
                return "empty"
            end })
        print("#table = " .. #table)
        printTable(getmetatable(table))
    end,

    --- 加法操作
    function()
        print("Example 3:")

        -- 将 add 事件的元值设为一个函数
        local table1 = setmetatable({ 1, 2, 3, k1 = "v1" }, {
            __add = function(a, b)
                if (type(a) == "table" and type(b) == "table") then
                    for k, v in pairs(b) do
                        a[k] = v
                    end
                    return a
                end
            end
        })

        local table2 = { 10, k1 = "value1", k2 = "value2", 20 }
        printTable(table1 + table2)
    end,

    --- 相等性比较操作
    function()
        print("Example 4:")

        -- 将 eq 事件的元值设为一个函数
        local table1 = setmetatable({ 1, "AAA", "zzz", 2 }, {
            __eq = function(a, b)
                if (type(a) == "table" and type(b) == "table") then
                    if (not (#a == #b)) then
                        return false
                    end
                    for i, _ in ipairs(b) do
                        if (not (a[i] == b[i])) then
                            return false
                        end
                    end
                    return true
                end
                return false
            end
        })

        local table2 = { 1, "zzz" }
        local table3 = { 1, "AAA", "zzz", "2" }
        local table4 = { 1, "AAA", "zzz", 2 }
        print("table1 == table2", table1 == table2)
        print("table1 == table3", table1 == table3)
        print("table1 == table4", table1 == table4)
    end,

    --- 索引访问操作
    function()
        print("Example 5:")

        -- 将 index 事件的元值设为一个函数
        local table1 = setmetatable({ }, {
            __index = function(table, key)
                if key == "MovedPermanently" then
                    return 301
                elseif key == 404 then
                    return "NotFound"
                else
                    return 0
                end
            end
        })

        print("table1[\"MovedPermanently\"] = " .. table1["MovedPermanently"])
        print("table1[404] = " .. table1[404])
        print("table1[1] = " .. table1[1])

        -- index 事件的元值也可以是一个 table
        local table2 = setmetatable({ Error = "-1" }, {
            __index = { "Test", Error = "404", OK = "200" }
        })

        -- 首先在 table2 中进行查找
        print("table2[\"Error\"] = " .. table2["Error"])

        print("table2[\"OK\"] = " .. table2["OK"])
        print("table2[1] = " .. table2[1])
    end,

    --- 索引赋值操作
    function()
        print("Example 6:")

        -- 将 newindex 事件的元值设为一个函数
        local table1 = setmetatable({ }, {
            __newindex = function(table, key, value)
                -- 直接令 table[key] = value, 不使用元值 __newindex
                rawset(table, key, "(" .. tostring(value) .. ")")
            end
        })
        table1["key1"] = "value1"
        table1["key2"] = { 1, 2, 3 }
        print("table1[\"key1\"] = " .. table1["key1"])
        print("table1[\"key2\"] = " .. table1["key2"])

        -- newindex 事件的元值也可以是一个 table
        local newTable = {}
        local table2 = setmetatable({ k1 = "value1" }, { __newindex = newTable })

        -- 由于 table2 存在索引 "k1", 所以此处为 table2["k1"] 赋值
        table2["k1"] = "NewValue"

        -- 由于 table2 不存在索引 "k2", 且 __newindex 事件设为 newTable
        -- 所以此处为 newTable["k2"] 赋值
        table2["k2"] = "value2"

        print(table2["k1"], table2["k2"])
        print(newTable["k1"], newTable["k2"])
    end,

    --- 调用方法操作
    function()
        print("Example 7:")

        -- 将 call 事件的元值设为一个函数
        local table = setmetatable({ }, {
            __call = function(func, ...)
                local args = { ... }
                if (args[1] == "printArgs") then
                    table.remove(args, 1)
                    local text = "[ "
                    for _, v in ipairs(args) do
                        text = text .. tostring(v) .. ", "
                    end
                    text = text .. "]"
                    print(text)
                    return 1
                end

                -- 这是唯一的允许返回多个结果的元方法
                return 0, nil, false
            end
        })

        local res1 = table("printArgs", "Test", 666, {})
        print("res1:", res1)

        local res2 = { table("test") }
        print("res2:", res2[1], ", ", res2[2], ", ", res2[3])
    end,

    --- tostring 事件
    function()
        print("Example 8:")

        -- 将 tostring 事件的元值设为一个函数
        local table = setmetatable({ 100, "Test", {}, }, {
            __tostring = function(table)
                local text = "{ "
                for _, v in pairs(table) do
                    text = text .. "(" .. type(v) .. ")" .. tostring(v) .. ", "
                end
                text = text .. "}"
                return text
            end
        })

        print(tostring(table))
    end,
}

function printTable(table)
    local text = "{ "
    for k, v in pairs(table) do
        text = text .. k .. ":(" .. type(v) .. ")" .. tostring(v) .. ", "
    end
    text = text .. "}"
    print(text)
end

--- 运行
for _, fun in pairs(MetatableExample) do
    fun()
    print()
end
