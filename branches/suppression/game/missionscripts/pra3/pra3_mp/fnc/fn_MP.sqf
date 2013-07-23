private "_things";
_things = [
	_this select 0,
	_this select 1,
	if (count _this > 2) then {_this select 2} else {true},
	if (count _this > 3) then {_this select 3} else {false},
	if (count _this > 4) then {_this select 4} else {true} // this makes things call rather than spawn
];

if (isMultiplayer) then
{
	_things call BIS_fnc_MP;
}
else
{
	BIS_fnc_MP_packet = [0] + _things;
	if (_things select 4) then
	{
		["BIS_fnc_MP_packet", BIS_fnc_MP_packet] call BIS_fnc_MPexec;
	}
	else
	{
		["BIS_fnc_MP_packet", BIS_fnc_MP_packet] spawn BIS_fnc_MPexec;
	};
};
