---
--- 关于 Lua 模块的示例
ModuleExample = {
    --- 使用 require 查找 Lua 库
    function()
        print("Example 1:")

        -- 在 package.path 中添加 Lua 库的查找路径
        package.path = "../../src/?.lua;" .. package.path

        -- 加载给定模块
        -- 当成功加载一个未加载模块时, 返回两个结果
        -- 第一个结果是 package.loaded[modname] 的最终值
        -- 第二个结果是加载器的数据, 表示模块的路径
        local v1, v2 = require("Utils")
        print(v1, v2)

        print(Utils.Constants.Pi)
        print(Utils.getDirectory())

        -- 不能访问使用 local 声明的函数
        --print(Utils.AccessibilityTest())
    end,

    --- 使用 require 查找 C 库
    function()
        print("Example 2:")

        -- 在 package.cpath 中添加 C 库的查找路径
        package.cpath = "../../lib/?.dll;" .. package.cpath

        -- 加载给定模块
        local cppLib = require("mycpplib")
        print(cppLib)

        -- 可以通过 package.loaded 获取已加载的模块
        print(package.loaded["mycpplib"])

        -- 调用 C 库的函数
        cppLib.printParams(1, "Test", 100)
        print(cppLib.pow(2, 10))
    end,

    --- 使用 package.loadlib 函数将 C 库动态链接到程序 
    function()
        print("Example 3:")

        -- C 库的完整文件名
        -- 在必要时, 还要加上路径和扩展名
        local path = "../../lib/mycpplib.dll"

        -- 动态链接目标 C 库
        -- 此处返回 C 函数 luaopen_mycpplib
        local func = package.loadlib(path, "luaopen_mycpplib")

        -- 调用 C 函数, 该函数在 Lua 中注册了数个 C 函数
        local cppLib = func()
        print(cppLib)

        -- 调用注册的 C 函数
        cppLib.printParams(0, 1, "Test")
        print(cppLib.pow(2, 8))
    end,
}

--- 运行
for _, fun in pairs(ModuleExample) do
    fun()
    print()
end
