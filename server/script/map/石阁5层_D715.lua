local addmon = require('map.addmonster')
local addMonCo = addmon.monGener( -- 石阁5层_D715
{
    {
        name = '楔蛾',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 150, time = 600, cratio = 0},
        }
    },
    {
        name = '白野猪',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 1, time = 7200, cratio = 0},
        }
    },
    {
        name = '红野猪',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 220, time = 600, cratio = 0},
        }
    },
    {
        name = '红野猪0',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 3, time = 3600, cratio = 0},
        }
    },
    {
        name = '蝎蛇',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 215, time = 600, cratio = 0},
        }
    },
    {
        name = '蝎蛇0',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 3, time = 3600, cratio = 0},
        }
    },
    {
        name = '角蝇',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 60, time = 600, cratio = 0},
        }
    },
    {
        name = '黑野猪',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 200, time = 600, cratio = 0},
        }
    },
    {
        name = '黑野猪0',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 3, time = 3600, cratio = 0},
        }
    },
})

function main()
    while true do
        coroutine.resume(addMonCo)
        asyncWait(1000 * 5)
    end
end
