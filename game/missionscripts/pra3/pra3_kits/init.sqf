if (!isDedicated) then
{
	_code = {
		_this select 0 addEventHandler [
			"animChanged",
			{_this call PRA3_fnc_handleInventoryBlock}
		]
	};

	[player] call _code;

	[
		player,
		_code
	] call PRA3_fnc_registerPlayerRespawnedHandler;
};
