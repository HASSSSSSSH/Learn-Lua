---
--- 关于 Lua 模拟面向对象的示例
ObjectOrientedExample = {
    --- 模拟类和对象
    function()
        print("Example 1:")

        --- 声明一个类
        ---@class Rectangle
        local Rectangle = { length = 0, width = 0 }

        -- 用于实例化的函数
        function Rectangle:new(length, width, obj)
            obj = obj or {}
            length = length or 0
            width = width or 0
            setmetatable(obj, self)
            self.__index = self
            self.length = length
            self.width = width
            return obj
        end

        -- 类的方法
        function Rectangle:getArea()
            return self.length * self.width
        end

        -- 创建对象
        local rect = Rectangle:new(10, 20)

        -- 获取类的成员变量
        print(rect.length, rect.width)

        -- 调用类的方法
        print(rect:getArea())
    end,
}

--- 运行
for _, fun in pairs(ObjectOrientedExample) do
    fun()
    print()
end
