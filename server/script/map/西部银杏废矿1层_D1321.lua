local addmon = require('map.addmonster')
local addMonCo = addmon.monGener( -- 西部银杏废矿1层_D1321
{
    {
        name = '多脚虫1',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '多脚虫2',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '红甲虫',
        loc = {
            {x = 200, y = 200, w = 190, h = 190, count = 1, time = 7200, cratio = 0},
        }
    },
    {
        name = '胞眼虫1',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '胞眼虫2',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '蜘蛛娃',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 50, time = 600, cratio = 0},
        }
    },
    {
        name = '蜘蛛娃0',
        loc = {
            {x = 200, y = 200, w = 190, h = 190, count = 1, time = 3600, cratio = 0},
        }
    },
})

function main()
    while true do
        coroutine.resume(addMonCo)
        asyncWait(1000 * 5)
    end
end
