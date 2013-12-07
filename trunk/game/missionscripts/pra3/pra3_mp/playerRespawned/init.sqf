#define var(x) private #x; x

if !isDedicated then
{
	//Add the MP EH to the player unit
	0 spawn
	{
		waitUntil {!isNull player};
		// NOTE: We cannot use MPRespawn because that doesn't actually work properly as of 1.62 - it doesn't execute for other clients!
		player addEventHandler ["Respawn", {[_this, "PRA3_fnc_playerRespawnedHandler"] call PRA3_fnc_MP}];
	};
};
