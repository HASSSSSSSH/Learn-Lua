/**
 * C++ 调用 Lua 的示例
 *
 * 可使用以下 g++ 命令编译此文件:
 * g++ ./cpp/main.cpp -o ./cpp/main.exe -I ./cpp/lua/include/ -L ./cpp/lua/lib/ -llua54
 */

#include <iostream>
#include "lua.hpp"

using namespace std;

void Test1() {
    // 创建一个新的 lua_State
    lua_State *L = luaL_newstate();

    // 入栈
    lua_pushstring(L, "Lua test!");

    // 判断给定索引处的值是否为字符串或者数字
    // 索引 1 表示虚拟栈的栈底
    if (lua_isstring(L, 1)) {
        // 取值
        // 将给定索引处的 Lua 值转换为 C 字符串
        cout << lua_tostring(L, 1) << endl;
    }

    // 关闭 lua_State
    lua_close(L);
}

void Test2() {
    // 创建一个新的 lua_State
    lua_State *L = luaL_newstate();

    // 将文件加载为 Lua 块
    // 此函数只加载块而不运行
    int bRet = luaL_loadfile(L, "./lua/src/Test.lua");
    if (bRet) {
        cout << "luaL_loadfile error" << endl;
        return;
    }

    // 在保护模式下调用一个函数或可调用对象
    // 运行 Lua 文件
    bRet = lua_pcall(L, 0, 0, 0);
    if (bRet) {
        cout << "lua_pcall error" << endl;
        return;
    }

    // 将全局名称对应的值入栈
    // 此处名称 pow 对应的值是一个函数
    lua_getglobal(L, "pow");

    // 将整数入栈, 作为 pow 函数的参数
    lua_pushinteger(L, 2);

    // 将整数入栈, 作为 pow 函数的参数
    lua_pushinteger(L, 10);

    // 将字符串入栈, 作为 pow 函数的参数
    // lua_pushstring(L, "10");

    // 在保护模式下调用函数, 调用完成后会将返回值入栈
    // 其中, 第 2 个参数表示函数参数的数量, 第 3 个参数表示返回值的数量
    int iRet = lua_pcall(L, 2, 1, 0);

    if (iRet) {
        // 输出错误信息
        // 索引 -1 表示虚拟栈的栈顶
        const char *pErrorMsg = lua_tostring(L, -1);
        cout << "lua_pcall error: " << pErrorMsg << endl;
        lua_close(L);
        return;
    }

    // 判断给定索引处的值是否为数字或可转换为数字的字符串
    if (lua_isnumber(L, -1)) {
        // 将给定索引处的 Lua 值转换为 C 类型 lua_Number
        // 索引 -1 表示虚拟栈的栈顶
        // double result = lua_tonumber(L, -1);
        lua_Number result = lua_tonumber(L, -1);
        cout << result << endl;
    }

    // 关闭 lua_State
    lua_close(L);
}

int main() {
    Test1();
    Test2();
    system("pause");
    return 0;
}
