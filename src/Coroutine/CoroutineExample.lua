---
--- 关于 Lua 协程的示例
CoroutineExample = {
    --- 协程的基本操作
    function()
        print("Example 1:")

        -- 一个函数
        local f = function(...)
            local args = { ... }
            for i, _ in ipairs(args) do
                -- 调用 coroutine.yield 函数挂起协程
                -- 该函数返回值由之后调用的 coroutine.resume 决定
                local value = coroutine.yield(args[i])
                print("yield return:", value)
            end
            return 1
        end

        -- 创建一个协程, 得到一个 thread 类型的对象
        local co = coroutine.create(f)

        -- 开始执行协程
        print("resume return:", coroutine.resume(co, 10, 20, "30"))

        for i = 1, 3 do
            -- 继续执行协程
            print("resume return:", coroutine.resume(co, "resume" .. i))
        end

        -- 执行处于死亡状态的协程
        print("resume return:", coroutine.resume(co, "Test"))
    end,

    --- 使用 coroutine.wrap 函数创建协程
    function()
        print("Example 2:")

        -- 一个函数
        local f = function()
            for i = 1, 3 do
                local value = coroutine.yield("index" .. i)
                print("yield return:", value)
            end
            return 1
        end

        -- 通过 coroutine.wrap 创建协程
        -- 得到的是一个 function 类型的对象
        local co = coroutine.wrap(f)

        -- 开始执行协程
        print("coroutine return:", co())

        for i = 1, 3 do
            -- 继续执行协程
            print("coroutine return:", co("resume" .. i))
        end

        -- 执行处于死亡状态的协程会引发错误
        --print("coroutine return:", co("Test"))
    end,

    --- 协程的状态
    function()
        print("Example 3:")

        -- 输出协程的状态信息
        local logInfo = function(co)
            -- 以字符串的形式返回协程 co 的状态
            print("\t status:", coroutine.status(co))

            -- 返回正在运行的协程和一个 boolean 类型的值
            -- 如果正在运行的协程是主协程时, 返回 true
            local thread, bool = coroutine.running()

            print("\t running:", thread, bool)
            print("\t (co == thread)", co == thread)
        end

        -- 创建协程
        print("create coroutine")
        local co = coroutine.create(
                function(co)
                    for i = 1, 3 do
                        logInfo(co)
                        coroutine.yield("index" .. i)
                    end
                    return 1
                end
        )

        -- 输出未运行协程的信息
        logInfo(co)

        -- 开始执行协程
        print("start coroutine")
        print("coroutine return:", coroutine.resume(co, co))

        for i = 1, 3 do
            -- 继续执行协程
            print("continue coroutine")
            print("coroutine return:", coroutine.resume(co, "resume" .. i))
            logInfo(co)
        end
    end,

    --- 生产者消费者问题
    function()
        print("Example 4:")

        local ProducerConsumer = {}

        function ProducerConsumer:init(co)
            self.coroutine = co
        end

        -- 生产者
        function ProducerConsumer:producer()
            local status = "running"
            local i = 0

            while i < 5 do
                i = i + 1

                -- 生产结束
                if i >= 5 then
                    status = "stop"
                end

                local product = "Product" .. i
                print("produce " .. tostring(product))
                self.produce(self, status, product)
            end
        end

        -- 消费者
        function ProducerConsumer:consumer()
            while true do
                local status, product = self.consume(self)
                print("consume " .. tostring(product))

                -- 当生产者停止时, 停止消费者
                if (status == "stop") then
                    return
                end
            end
        end

        -- 生产对象
        function ProducerConsumer:produce(status, product)
            coroutine.yield(status, product)
        end

        -- 消费对象
        function ProducerConsumer:consume()
            local _, status, product = coroutine.resume(self.coroutine, self)
            return status, product
        end

        -- 使用 ProducerConsumer.producer 函数创建协程
        local co = coroutine.create(ProducerConsumer.producer)

        ProducerConsumer.init(ProducerConsumer, co)
        ProducerConsumer.consumer(ProducerConsumer)
    end,

    --- 错误处理
    function()
        print("Example 5:")

        local f = function()
            for i = 1, 3 do
                if (i == 2) then
                    error("Test!!")
                end
                coroutine.yield("index" .. i)
            end
            return 1
        end

        -- 通过 coroutine.wrap 创建协程
        local co1 = coroutine.wrap(f)

        -- 通过 coroutine.create 创建协程
        local co2 = coroutine.create(f)

        -- 开始执行协程
        print("coroutine1 return:", co1())
        print("coroutine2 return:", coroutine.resume(co2))

        for i = 1, 3 do
            -- 通过 coroutine.wrap 创建的协程在出现错误时, 函数会关闭协程并引发错误
            print("coroutine1 return:", pcall(co1, "resume" .. i))

            -- 当出现错误时, coroutine.resume 函数返回 false 和错误消息
            print("coroutine2 return:", coroutine.resume(co2, "resume" .. i))
        end
    end,
}

--- 运行
for _, fun in pairs(CoroutineExample) do
    fun()
    print()
end
