/*
 * =====================================================================================
 *
 *       Filename: landtype.hpp
 *        Created: 08/16/2017 23:36:45
 *  Last Modified: 08/17/2017 10:38:53
 *
 *    Description: for every cell we have land type
 *
 *                 LandType is a bitfiled in EditorMap and Mir2xMapData
 *                 so it should take at most N bits
 *
 *        Version: 1.0
 *       Revision: none
 *       Compiler: gcc
 *
 *         Author: ANHONG
 *          Email: anhonghe@gmail.com
 *   Organization: USTC
 *
 * =====================================================================================
 */

#pragma once
enum LandType: int
{
    LANDTYPE_NONE  = 0,
    LANDTYPE_SAND,
    LANDTYPE_GRASS,
    LANDTYPE_STONE,
    LANDTYPE_MAX,
};
