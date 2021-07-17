local addmon = require('map.addmonster')
local addMonCo = addmon.monGener( -- 调控室_D904
{
    {
        name = '海神将领',
        loc = {
            {x = 50, y = 50, w = 50, h = 50, count = 15, time = 3600, cratio = 0},
        }
    },
    {
        name = '爆毒神魔',
        loc = {
            {x = 50, y = 50, w = 50, h = 50, count = 10, time = 3600, cratio = 0},
        }
    },
    {
        name = '神舰守卫',
        loc = {
            {x = 50, y = 50, w = 50, h = 50, count = 15, time = 3600, cratio = 0},
        }
    },
    {
        name = '红衣法师',
        loc = {
            {x = 50, y = 50, w = 50, h = 50, count = 10, time = 3600, cratio = 0},
        }
    },
    {
        name = '霸王教主',
        loc = {
            {x = 50, y = 50, w = 50, h = 50, count = 1, time = 10800, cratio = 0},
        }
    },
})

function main()
    while true do
        coroutine.resume(addMonCo)
        asyncWait(1000 * 5)
    end
end
