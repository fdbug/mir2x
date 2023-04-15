#include "uidf.hpp"
#include "strf.hpp"
#include "quest.hpp"
#include "dbpod.hpp"
#include "filesys.hpp"

extern DBPod *g_dbPod;

Quest::Quest(const SDInitQuest &initQuest)
    : ServerObject(uidf::getQuestUID(initQuest.questID))
    , m_scriptName(initQuest.fullScriptName)
{}

void Quest::onActivate()
{
    ServerObject::onActivate();
    m_luaRunner = std::make_unique<ServerLuaCoroutineRunner>(m_actorPod);

    m_luaRunner->bindFunction("getQuestName", [this]() -> std::string
    {
        return std::get<1>(filesys::decompFileName(m_scriptName.c_str(), true));
    });

    m_luaRunner->bindFunction("getUID", [this]() -> uint64_t
    {
        return UID();
    });

    m_luaRunner->bindFunction("dbGetUIDQuestState", [this](uint64_t uid, sol::this_state s) -> sol::object
    {
        sol::state_view sv(s);
        const auto dbid = uidf::getPlayerDBID(uid);
        const auto dbName = str_printf("tbl_questdb_%s", getQuestName().c_str());

        if(!g_dbPod->createQuery(u8R"###(select name from sqlite_master where type='table' and name='%s')###", dbName.c_str()).executeStep()){
            return sol::make_object(sv, sol::nil);
        }

        auto queryStatement = g_dbPod->createQuery(u8R"###(select fld_state from %s where fld_dbid=%llu)###", dbName.c_str(), to_llu(dbid));
        if(!queryStatement.executeStep()){
            return sol::make_object(sv, sol::nil);
        }

        return luaf::buildLuaObj(sol::state_view(s), cerealf::deserialize<luaf::luaVar>(queryStatement.getColumn(0)));
    });

    m_luaRunner->bindFunction("dbSetUIDQuestState", [this](uint64_t uid, sol::object obj)
    {
        const auto dbid = uidf::getPlayerDBID(uid);
        const auto dbName = str_printf("tbl_questdb_%s", getQuestName().c_str());

        if(!g_dbPod->createQuery(u8R"###(select name from sqlite_master where type='table' and name='%s')###", dbName.c_str()).executeStep()){
            g_dbPod->exec(
                u8R"###( create table %s(                                          )###"
                u8R"###(     fld_dbid           int unsigned not null,             )###"
                u8R"###(     fld_timestamp      int unsigned not null,             )###"
                u8R"###(     fld_state          blob         not null,             )###"
                u8R"###(                                                           )###"
                u8R"###(     foreign key (fld_dbid) references tbl_char(fld_dbid), )###"
                u8R"###(     primary key (fld_dbid)                                )###"
                u8R"###( );                                                        )###", dbName.c_str());
        }

        auto query = g_dbPod->createQuery(
            u8R"###( replace into %s(fld_dbid, fld_timestamp, fld_state) )###"
            u8R"###( values                                              )###"
            u8R"###(     (%llu, %llu, ?)                                 )###",

            dbName.c_str(),
            to_llu(dbid),
            to_llu(std::time(nullptr)));

        query.bind(1, cerealf::serialize(luaf::buildLuaVar(obj)));
        query.exec();
    });

    m_luaRunner->bindFunctionCoop("_RSVD_NAME_modifyQuestTriggerType", [this](LuaCoopResumer onDone, int triggerType, bool enable)
    {
        fflassert(triggerType >= SYS_ON_BEGIN, triggerType);
        fflassert(triggerType <  SYS_ON_END  , triggerType);

        AMModifyQuestTriggerType amMQTT;
        std::memset(&amMQTT, 0, sizeof(amMQTT));

        amMQTT.type = triggerType;
        amMQTT.enable = enable;

        m_actorPod->forward(uidf::getServiceCoreUID(), {AM_MODIFYQUESTTRIGGERTYPE, amMQTT}, [onDone, this](const ActorMsgPack &rmpk)
        {
            // expected an reply
            // this makes sure when modifyQuestTriggerType() returns, the trigger has already been enabled/disabled

            switch(rmpk.type()){
                case AM_OK:
                    {
                        onDone(true);
                        break;
                    }
                default:
                    {
                        onDone();
                        break;
                    }
            }
        });
    });

    m_luaRunner->bindFunctionCoop("_RSVD_NAME_loadMap", [this](LuaCoopResumer onDone, std::string mapName)
    {
        fflassert(str_haschar(mapName));

        AMLoadMap amLM;
        std::memset(&amLM, 0, sizeof(AMLoadMap));

        amLM.mapID = DBCOM_MAPID(to_u8cstr(mapName));
        amLM.activateMap = true;

        m_actorPod->forward(uidf::getServiceCoreUID(), {AM_LOADMAP, amLM}, [mapID = amLM.mapID, onDone, this](const ActorMsgPack &mpk)
        {
            switch(mpk.type()){
                case AM_LOADMAPOK:
                    {
                        const auto amLMOK = mpk.conv<AMLoadMapOK>();
                        onDone(amLMOK.uid);
                        break;
                    }
                default:
                    {
                        onDone();
                        break;
                    }
            }
        });
    });

    m_luaRunner->pfrCheck(m_luaRunner->execRawString(BEGIN_LUAINC(char)
#include "quest.lua"
    END_LUAINC()));

    // define all functions needed for the quest
    // but don't execute them here since they may require coroutine environment
    m_luaRunner->pfrCheck(m_luaRunner->execFile(m_scriptName.c_str()));

    m_luaRunner->spawn(m_mainScriptThreadKey, str_printf(
        R"#( do                           )#""\n"
        R"#(     getTLSTable().uid = %llu )#""\n"
        R"#(     return main()            )#""\n"
        R"#( end                          )#""\n", to_llu(UID())));
}

void Quest::operateAM(const ActorMsgPack &mpk)
{
    switch(mpk.type()){
        case AM_METRONOME:
            {
                on_AM_METRONOME(mpk);
                break;
            }
        case AM_QUESTNOTIFY:
            {
                on_AM_QUESTNOTIFY(mpk);
                break;
            }
        case AM_REMOTECALL:
            {
                on_AM_REMOTECALL(mpk);
                break;
            }
        case AM_RUNQUESTTRIGGER:
            {
                on_AM_RUNQUESTTRIGGER(mpk);
                break;
            }
        default:
            {
                throw fflerror("unsupported message: %s", mpkName(mpk.type()));
            }
    }
}
