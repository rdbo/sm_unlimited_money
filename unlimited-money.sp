#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <cstrike>

ConVar g_cvEnabled;
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
    g_cvEnabled = CreateConVar("sm_unlimitedmoney_enabled", "1", "Enable money SM Unlimited Money plugin");
    g_cvStartMoney = FindConVar("mp_startmoney");
    HookEvent("round_start", EV_RoundStart, EventHookMode_PostNoCopy); 
}

Action EV_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
    if (!g_cvEnabled.IntValue)
        return Plugin_Continue;

    int start_money = GetConVarInt(g_cvStartMoney);
    for (int i = 1; i < MaxClients; ++i)
    {
        if (IsClientInGame(i))
            SetEntProp(i, Prop_Send, "m_iAccount", start_money);
    }

    return Plugin_Continue;
}
