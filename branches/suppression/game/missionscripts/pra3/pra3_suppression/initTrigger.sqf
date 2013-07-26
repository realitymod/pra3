#include "scriptDefines.sqh"

player addEventHandler ["Fired",
{
	_shooter = _this select 0;
	_bullet = _this select 6;

	if ((player != vehicle player) || {player == _shooter} || {(player distance _shooter) > 1500} || {!(_bullet isKindOf "BulletCore")}) exitWith {};
	
	_velocity = velocity _bullet;
	_posOrigin = getPosASL _bullet;
	_posTarget = getPosASL player;

	_distVector = [(_posTarget select 0) - (_posOrigin select 0), (_posTarget select 1) - (_posOrigin select 1)];

	_div = if ((_distVector select 0) > (_distVector select 1)) then
	{
		(_velocity select 0) / (_distVector select 0)
	}
	else
	{
		(_velocity select 1) / (_distVector select 1)
	};

	_hitScan = [(_distVector select 0) * _div, (_distVector select 1) * _div];

	if ((player distance _shooter) < 1500 &&
	{[_hitScan select 0, _velocity select 0, 50] call PRA3_fnc_roughlyEquals} &&
	{[_hitScan select 1, _velocity select 1, 50] call PRA3_fnc_roughlyEquals}) then
	{
		_bullet spawn PRA3_fnc_suppressionTrack;
	};					
}];