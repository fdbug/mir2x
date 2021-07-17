local addmon = require('map.addmonster')
local addMonCo = addmon.monGener( -- 绝命谷1层北部_D60013
{
    {
        name = '蜈蚣',
        loc = {
            {x = 125, y = 125, w = 115, h = 115, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '蝴蝶虫',
        loc = {
            {x = 125, y = 125, w = 115, h = 115, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '跳跳蜂',
        loc = {
            {x = 125, y = 125, w = 115, h = 115, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '跳跳蜂0',
        loc = {
            {x = 125, y = 125, w = 115, h = 115, count = 1, time = 3600, cratio = 0},
        }
    },
    {
        name = '邪恶钳虫',
        loc = {
            {x = 100, y = 100, w = 100, h = 100, count = 1, time = 7200, cratio = 0},
        }
    },
    {
        name = '钳虫',
        loc = {
            {x = 125, y = 125, w = 115, h = 115, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '钳虫0',
        loc = {
            {x = 125, y = 125, w = 115, h = 115, count = 1, time = 3600, cratio = 0},
        }
    },
    {
        name = '黑色恶蛆',
        loc = {
            {x = 125, y = 125, w = 115, h = 115, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '黑色恶蛆0',
        loc = {
            {x = 125, y = 125, w = 115, h = 115, count = 1, time = 3600, cratio = 0},
        }
    },
})

function main()
    while true do
        coroutine.resume(addMonCo)
        asyncWait(1000 * 5)
    end
end
