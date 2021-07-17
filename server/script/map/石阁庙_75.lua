local addmon = require('map.addmonster')
local addMonCo = addmon.monGener( -- 石阁庙_75
{
    {
        name = '多角虫',
        loc = {
            {x = 200, y = 200, w = 150, h = 150, count = 10, time = 600, cratio = 0},
        }
    },
    {
        name = '夜行鬼09',
        loc = {
            {x = 200, y = 200, w = 200, h = 200, count = 100, time = 1200, cratio = 0},
        }
    },
    {
        name = '威思而小虫',
        loc = {
            {x = 200, y = 200, w = 150, h = 150, count = 10, time = 600, cratio = 0},
        }
    },
    {
        name = '巨型多角虫',
        loc = {
            {x = 200, y = 200, w = 190, h = 190, count = 1, time = 7200, cratio = 0},
        }
    },
    {
        name = '沙漠威思而小虫',
        loc = {
            {x = 200, y = 200, w = 150, h = 150, count = 10, time = 600, cratio = 0},
        }
    },
    {
        name = '猎鹰',
        loc = {
            {x = 200, y = 200, w = 150, h = 150, count = 10, time = 600, cratio = 0},
        }
    },
    {
        name = '盔甲虫',
        loc = {
            {x = 200, y = 200, w = 150, h = 150, count = 10, time = 600, cratio = 0},
            {x = 200, y = 200, w = 150, h = 150, count = 10, time = 600, cratio = 0},
        }
    },
})

function main()
    while true do
        coroutine.resume(addMonCo)
        asyncWait(1000 * 5)
    end
end
