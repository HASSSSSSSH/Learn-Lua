/**
 * userdata 类型提供将任意 C 数据存储在 Lua 变量中的能力
 * userdata 的值表示一块原始内存
 * userdata 可以分为: full userdata (Lua 管理的一块内存的对象) 和 light userdata (一个 C 指针值)
 *
 * 可使用以下 g++ 命令编译此文件:
 * g++ ./cpp/point.cpp -o ./lib/point.dll -O3 -shared -I ./cpp/lua/include/ -L ./cpp/lua/lib/ -llua54
 */

#include <string>
#include "lua.hpp"

// 元表名称
static const std::string METATABLE_NAME = "lua_point";

/**
 * 自定义类型 Point
 */
typedef struct Point {
    LUA_INTEGER x, y;
} Point;

/**
 * 创建 userdata
 *
 * userdata 在 Lua 中除了赋值和相等性测试以外没有其他预定义的操作
 * 可以使用元表为 full userdata 定义操作
 */
static int point_new(lua_State *L) {
    // 获取参数
    LUA_INTEGER x = luaL_checkinteger(L, 1);
    LUA_INTEGER y = luaL_checkinteger(L, 2);

    // 创建一个新的 full userdata 并入栈
    // 此函数开辟了一块大小为 size 字节的原始内存块
    auto *p = (Point *) lua_newuserdata(L, sizeof(Point));

    // 赋值
    p->x = x;
    p->y = y;

    // 将注册表中与名称 tname 关联的元表入栈
    // 在 luaopen_point 函数中已经创建名称为 METATABLE_NAME 的元表
    luaL_getmetatable(L, METATABLE_NAME.c_str());

    // 出栈一个表或者 nil, 并将该值设置为给定索引处值的新元表
    // 此时索引 -2 处的值正是刚创建的 userdata
    lua_setmetatable(L, -2);

    return 1;
}

/**
 * 用于操作 Point 的函数
 */
static int point_get_x(lua_State *L) {
    // 检查函数参数 ud 是否为类型 tname 的 userdata
    auto *p = (Point *) luaL_checkudata(L, 1, METATABLE_NAME.c_str());

    lua_pushinteger(L, p->x);
    return 1;
}

/**
 * 用于操作 Point 的函数
 */
static int point_get_y(lua_State *L) {
    auto *p = (Point *) luaL_checkudata(L, 1, METATABLE_NAME.c_str());
    lua_pushinteger(L, p->y);
    return 1;
}

/**
 * 函数数组, 其中包含用于操作 Point 的函数
 */
static const luaL_Reg pointLib[]{
        {"getX", point_get_x},
        {"getY", point_get_y},
        {NULL, NULL}
};

/**
 * 函数数组, 其中包含用于创建 userdata 的函数
 */
static const luaL_Reg pointNewFunction[]{
        {"new", point_new},
        {NULL, NULL}
};

/**
 * 创建元表并注册用于创建 userdata 的函数
 */
extern "C" {
__declspec(dllexport) int luaopen_point(lua_State *L) {
    // 创建一个新的表作为 userdata 的元表
    // 新表存储在注册表中
    // 此函数会将注册表中与 tname 关联的最终值入栈
    luaL_newmetatable(L, METATABLE_NAME.c_str());

    // 复制给定索引处的元素并入栈
    lua_pushvalue(L, -1);

    // 执行与 t[k] = v 等效的操作, 其中 t 是给定索引处的值, v 是栈顶的值
    // 假设新创建的元表为 metatable, 此处相当于执行 metatable[__index] = metatable
    lua_setfield(L, -2, "__index");

    // 将数组 l 中的所有函数注册到栈顶的表中
    // 此处将 pointLib 中的函数注册到新创建的元表中
    luaL_setfuncs(L, pointLib, 0);

    // 创建一个新表并注册用于创建 userdata 的函数
    luaL_newlib(L, pointNewFunction);

    return 1;
}
}
