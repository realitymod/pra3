#include "defines.sqh"

if (isNull (uiNamespace getVariable ["PRA3_hud_playerRecognition", displayNull])) then
{
	(["PRA3_hud_playerRecognition"] call BIS_fnc_rscLayer) cutRsc ["PRA3_hud_playerRecognition", "PLAIN", 0];
};

// Those checks are quite expensive so only run them every DELAY_FRAMES frames
if (diag_frameNo > PRA3_recognize_nextNearCheck) then
{
	PRA3_recognize_knownUnits = [];
	if (!isNull player) then
	{
		{
			var(_cameraPos) = positionCameraToWorld [0,0,0];
			var(_screenPos) = worldToScreen ASLToATL eyePos _x;
			if (
				count _screenPos > 0 &&
				_cameraPos distance _x < MAX_RECOGNIZE_DISTANCE * 1.5 &&
				_x != player &&
				{PRA3_player_side == _x call PRA3_fnc_getPlayerSide} &&
				{!lineIntersects [ATLToASL _cameraPos, eyePos _x, player, _x]}
			) then
			{
				PRA3_recognize_knownUnits set [count PRA3_recognize_knownUnits, _x];
			};
		} forEach (player nearEntities ["CAManBase", MAX_RECOGNIZE_DISTANCE]);
	};

	PRA3_recognize_nextNearCheck = diag_frameNo + DELAY_FRAMES;
};

var(_lastUsed) = 1;
{
	var(_pos) = visiblePosition _x;
	_pos set [2, (_pos select 2) + ((eyePos _x select 2) - (getPosASL _x select 2)) + 0.3];
	_pos = worldToScreen _pos;

	if (!visibleMap && alive _x && count _pos > 0) then
	{
		var(_stareTime) = _x getVariable ["PRA3_stareTime", 0];
		if (_stareTime > RECOGNIZE_DELAY) then
		{
			var(_idc)      = _lastUsed * 10;
			var(_distance) = eyePos _x distance positionCameraToWorld [0,0,0];
			var(_scale)    = ((MAX_RECOGNIZE_DISTANCE - _distance) / MAX_RECOGNIZE_DISTANCE + 0.5) min 1;
			var(_fade)     = ((_distance / MAX_RECOGNIZE_DISTANCE * 0.9)^3) + (RECOGNIZE_DELAY*2 - _stareTime);
			
			ctrl(_idc) ctrlShow true;
			ctrl(_idc) ctrlSetText name _x;
			ctrl(_idc) ctrlSetTextColor [0,0.75,1,1];
			ctrl(_idc) ctrlSetPosition [
				(_pos select 0) - 0.5 * _scale,
				(_pos select 1) max safeZoneY // Cap it at the top of the screen
			];
			ctrl(_idc) ctrlSetFade _fade;
			ctrl(_idc) ctrlSetScale _scale;
			ctrl(_idc) ctrlCommit 0;

			_lastUsed = _lastUsed + 1;
			
			var(_caller) = _this;
			var(_squad) = _caller call PRA3_fnc_unitGetSquad;
			
			{
				if (player call PRA3_fnc_unitGetSquad == _squad) then
				{
					ctrl(_idc) ctrlSetTextColor [0,1,0,1];
				};
			} forEach (player nearEntities ["CAManBase", MAX_RECOGNIZE_DISTANCE]);
		};
		var(_add) = diag_tickTime - PRA3_recognize_lastRun;
		_x setVariable ["PRA3_stareTime", (_stareTime + _add) min (RECOGNIZE_DELAY*2)];
	}
	else
	{
		_x setVariable ["PRA3_stareTime", 0];
	};
} forEach PRA3_recognize_knownUnits;

for "_i" from _lastUsed to 10 do
{
	ctrl(_i * 10) ctrlShow false;
};

{
	if !(_x in PRA3_recognize_knownUnits) then
	{
		_x setVariable ["PRA3_stareTime", 0];
	};
} forEach PRA3_recognize_lastKnownUnits;

PRA3_recognize_lastKnownUnits = PRA3_recognize_knownUnits;
PRA3_recognize_lastRun = diag_tickTime;
