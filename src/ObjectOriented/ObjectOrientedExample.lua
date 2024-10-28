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

            -- 将 Rectangle 设为 obj 的元表
            setmetatable(obj, self)

            -- 为 obj 的元表 Rectangle 设置 index 事件, 元值为 Rectangle
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

    --- 模拟类的构造函数
    function()
        print("Example 2:")

        local Rectangle = { length = 0, width = 0 }

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

        function Rectangle:getArea()
            return self.length * self.width
        end

        -- 为 Rectangle 设置 call 事件, 从而可以使用 Rectangle 作为构造函数进行实例化
        setmetatable(Rectangle, {
            __call = function(self, length, width, obj)
                return self:new(length, width, obj)
            end
        })

        -- 调用类的构造函数创建对象
        local rect = Rectangle(10, 20)

        print(rect.length, rect.width)
        print(rect:getArea())
    end,

    --- 模拟继承
    function()
        print("Example 3:")

        --- 基类
        ---@class Enemy
        local Enemy = { HP = 0 }

        function Enemy:new(hp)
            local obj = {}
            hp = hp or 0
            setmetatable(obj, self)
            self.__index = self
            self.HP = hp
            return obj
        end

        function Enemy:takeDamage(damage)
            self.HP = self.HP - damage
            return self.HP
        end

        -- 基类 Enemy 的构造函数
        setmetatable(Enemy, {
            __call = function(self, hp)
                return self:new(hp)
            end
        })

        --- 子类
        ---@class Goblin : Enemy
        local Goblin = { MP = 0 }

        function Goblin:new(mp, hp)
            local obj = {}
            mp = mp or 0

            -- 设置 obj 的元表
            -- 元表包含 index 事件, 元值为 Goblin
            local mt = { __index = self }
            setmetatable(obj, mt)
            self.MP = mp

            -- self 是 obj 元表的 index 事件的元值
            -- 设置 self 的元表以使 obj 包含基类 Enemy 中的元素
            -- 为 self 的元表设置 index 事件, 元值为调用基类 Enemy 构造函数得到的对象
            local base = Enemy(hp)
            setmetatable(self, { __index = base })

            return obj
        end

        function Goblin:attackDamage()
            if (self.MP >= 10) then
                self.MP = self.MP - 10
                return 10
            else
                return 1
            end
        end

        -- 为 Goblin 设置 call 事件, 从而可以使用 Goblin 作为构造函数进行实例化
        setmetatable(Goblin, {
            __call = function(self, mp, hp)
                return self:new(mp, hp)
            end
        })

        -- 创建 Goblin 对象
        local gbl = Goblin(20, 100)

        -- 获取成员变量
        print("HP: " .. gbl.HP, "MP: " .. gbl.MP)

        -- 调用子类的方法
        print(gbl:attackDamage())
        print(gbl:attackDamage())
        print(gbl:attackDamage())

        -- 调用基类的方法
        gbl:takeDamage(30)

        print("HP: " .. gbl.HP, "MP: " .. gbl.MP)
    end,
}

--- 运行
for _, fun in pairs(ObjectOrientedExample) do
    fun()
    print()
end
