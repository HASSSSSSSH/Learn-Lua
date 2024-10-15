/**
 * Lua 使用虚拟栈在 C 之间传递值
 * 虚拟栈中的每个元素都代表一个 Lua 值 (nil, number, string 等)
 * API 中的函数可以通过其收到的 lua_State 参数来访问该虚拟栈
 *
 * 每当 Lua 调用 C 时, 被调用的函数都会获得一个新的栈, 该栈独立于先前的栈和仍处于活动状态的 C 函数栈
 * 栈最初包含 C 函数的所有参数, C 函数可以在其中存储临时 Lua 值, 并且必须将其结果入栈以返回给调用方
 *
 * Lua 的 C API 可以使用索引引用栈中的任何元素
 * 正索引表示绝对的栈位置, 从 1 开始作为栈底部
 * 负索引表示相对于栈顶部的偏移量
 *
 * 可使用以下 g++ 命令编译此文件:
 * g++ ./cpp/mycpplib.cpp -o ./lib/mycpplib.dll -O3 -shared -I ./cpp/lua/include/ -L ./cpp/lua/lib/ -llua54
 */

#include <iostream>
#include <cmath>
#include "lua.hpp"

/**
 * C 函数
 *
 * 为了与 Lua 正确通信, C 函数必须遵循以下协议, 该协议定义了传递参数和结果的方式:
 * C 函数按顺序从 Lua 的栈中接收参数 (第一个参数首先入栈)
 *
 * 因此, 当函数启动时, 可以通过 lua_gettop(L) 来获取函数接收的参数数量
 * 第一个参数 (如果有) 位于索引 1, 最后一个参数位于索引 lua_gettop(L)
 * 如果需要将值返回给 Lua, C 函数只需将值按顺序入栈 (第一个结果首先被推送), 并且在 C 中返回结果的数量
 * 在栈中其他位于结果下方的任何值都将被 Lua 丢弃
 * 与 Lua 函数类似, Lua 调用的 C 函数也可以返回多个结果
 */
static int lua_print_params(lua_State *L) {
    // lua_gettop 函数返回栈顶部元素的索引
    // 该结果可以表示栈中元素的数量, 以此得到参数的数量
    int n = lua_gettop(L);

    std::string text = "[ ";

    // 按从栈底到栈顶的顺序读取数据
    for (int i = 1; i <= n; i++) {
        // 将给定索引处的 Lua 值转换为 C 字符串
        text.append(lua_tostring(L, i));
        text.append(", ");
    }

    text.append("]");
    std::cout << text << std::endl;

    // 返回 0 个结果
    return 0;
}

/**
 * C 函数
 */
static int lua_pow(lua_State *L) {
    int n = lua_gettop(L);

    // 当参数的数量不等于 2 时, 返回错误信息
    if (n != 2) {
        lua_pushstring(L, "Invalid parameters");
        return 1;
    }

    // 按从栈底到栈顶的顺序读取数据
    double a = lua_tonumber(L, 1);
    double b = lua_tonumber(L, 2);
    double result = std::pow(a, b);

    // 将结果入栈
    lua_pushboolean(L, 1);
    lua_pushnumber(L, result);
    lua_pushstring(L, std::to_string(result).data());

    // 返回 3 个结果
    return 3;
}

/**
 * 函数数组
 * 数组中的每个元素由函数名称和指向该函数的指针组成
 * 最后一个元素必须以 {NULL, NULL} 结尾
 */
static const luaL_Reg lib[]{
        {"printParams", lua_print_params},
        {"pow",         lua_pow},
        {NULL, NULL}
};

/**
 * luaopen_mycpplib 函数用于注册 C 函数
 *
 * 当 require 使用变量 package.cpath 给出的路径来查找 C 加载器时
 * 如果查找成功, 查找器首先使用动态链接工具将应用程序与库链接起来
 * 然后会尝试在库中找到作为加载器的 C 函数
 * 该 C 函数的名称以 "luaopen_" 开头, 然后接着模块名称, 模块名称中的每个 "." 都会替换为 "_"
 * 此外, 如果模块名称中包含 "-", 则第一个连字符本身及其之后的内容都会被删除
 */
extern "C" {
__declspec(dllexport) int luaopen_mycpplib(lua_State *L) {
    std::cout << "luaopen_mycpplib start" << std::endl;

    // 创建一个新表并在其中注册列表 lib 中的函数
    luaL_newlib(L, lib);

    std::cout << "luaopen_mycpplib finish" << std::endl;
    return 1;
}
}
