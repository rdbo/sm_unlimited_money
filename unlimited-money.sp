#include <sourcemod>
#include <cstrike>

ConVar g_cvStartMoney;

public Plugin myinfo =
{
    name = "UnlimitedMoney",
    author = "rdbo",
    description = "Resets money on each round start to mp_startmoney",
    version = "1.0",
    url = ""
};

public void OnPluginStart()
{
    g_cvStartMoney = FindConVar("mp_startmoney");
    HookEvent("round_start", EV_RoundStart, EventHookMode_PostNoCopy); 
}

Action EV_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
    int start_money = GetConVarInt(g_cvStartMoney);
    for (int i = 0; i < MaxClients; ++i)
    {
        if (IsClientInGame(i))
            SetEntProp(i, Prop_Send, "m_iAccount", start_money);
    }
}
