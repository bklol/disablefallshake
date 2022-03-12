#include <sourcemod>
#include <sdkhooks>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = "remove view shake for css alse dmg",
	author = "neko AKA bklol" ,
	description = "fuck cant perfect work" ,
	version = "0.1"
}

public void OnPluginStart()
{
	for( int i = 1; i <= MaxClients; i++ )
		if( IsClientInGame(i) )
			OnClientPutInServer(i);
	
	//HookUserMessage(GetUserMessageId("Shake"), OnShakeData, true);
}
/*
Action OnShakeData(UserMsg iMsgId, Protobuf hMessage, const int[] iPlayers, int iPlayersNum, bool bReliable, bool bInit)
{
	return Plugin_Handled;
}
*/
public void OnClientPutInServer(int client)
{
	SDKHook(client, SDKHook_PreThinkPost, postThink);
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public Action postThink(int client)
{
    if(IsValidClient(client))
    {
		SetEntPropVector(client, Prop_Send, "m_vecPunchAngle", NULL_VECTOR);
		SetEntPropVector(client, Prop_Send, "m_vecPunchAngleVel", NULL_VECTOR);
		SetEntPropFloat(client, Prop_Send, "m_flStamina", 0.0);
    }
}

stock bool IsValidClient(int client, bool BotIsValid = false)
{
	if ( client < 1 || client > MaxClients ) return false;
	if ( !IsClientConnected( client )) return false;
	if ( !IsClientInGame( client )) return false;
	if ( IsFakeClient( client ) && !BotIsValid )return false;
	if ( IsClientSourceTV(client) || IsClientReplay(client)) return false;
	return true;
}

public Action OnTakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype) 
{
	return Plugin_Handled;
}