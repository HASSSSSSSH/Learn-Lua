---
--- Lua 库
Utils = {}

--- 常量
Utils.Constants = { Pi = 3.14159, SpeedOfLight = 300000 }

--- 获取 lua 文件所在的目录
function Utils.getDirectory()
    local path = debug.getinfo(1).source

    -- 字符串以 "@" 开头, 删除 "@"
    path = string.sub(path, 2, -1)

    -- 截取最后一个 "/" 之前的部分, 得到目录字符串
    path = string.match(path, "^.*/")

    return path
end

--- 可访问性测试
--- 使用 local 声明的函数不能通过模块访问
local function AccessibilityTest()
    print("AccessibilityTest")
end
