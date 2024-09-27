---
--- 关于 Lua 字符串的示例
StringExample = {
    --- 计算字符串的长度
    function()
        print("Example 1:")

        local str = "你好，World!"

        -- 返回字符串所包含的 UTF-8 字符的数量
        local length1 = utf8.len(str)

        -- 返回字符串所包含的 ASCII 字符的数量
        local length2 = string.len(str)

        -- 使用取长度运算符 # 计算字符串的长度
        local length3 = #str

        print("utf8.len(str): " .. length1)
        print("string.len(str): " .. length2)
        print("(#str): " .. length3)
    end,

    --- 截取字符串
    function()
        print("Example 2:")

        local str = "prefix_TEST_suffix"

        -- 截取第 8 个到第 11 个字符
        local sub1 = string.sub(str, 8, 11)

        -- 参数 -1 表示截取到最后一个字符
        local sub2 = string.sub(str, 2, -1)

        -- 返回空字符串
        local sub3 = string.sub(str, #str + 1, -1)

        print(str)
        print(sub1)
        print(sub2)
        print("#sub3: " .. #sub3)
    end,

    --- 查找字符串
    function()
        print("Example 3:")

        local str = "prefix_TEST_suffix"

        -- 返回 3 个值
        -- 前两个值表示目标字符串的位置
        local res1 = { string.find(str, "TEST") }

        -- 输出结果
        print(res1[1], res1[2], res1[3])

        -- 如果找不到目标字符串, 则返回 nil
        local res2 = { string.find(str, "zzz") }
        print(res2[1], res2[2], res2[3])
    end,

    --- 字符串格式化
    function()
        print("Example 4:")

        -- 格式化字符串
        print(string.format("%s", "zzz"))

        -- 将数字格式化为浮点数, 并保留 5 位小数
        print(string.format("%.5f", 1 / 3))

        -- 将数字格式化为十六进制数
        print(string.format("%x, %X", 240, 240))

        -- 日期格式化
        -- 可以在符号 % 后添加参数
        local date, month, year = 1, 5, 2077
        print(string.format("%02d/%02d/%04d", date, month, year))
    end,
}

--- 运行
for _, fun in pairs(StringExample) do
    fun()
    print()
end
