// Add a help section into the briefing
#include "fnc\scriptDefines.sqh"

player createDiarySubject ["pra3", "Project Reality"];
// TODO: Some actual help

// ##### CREDITS #####
var(_credits) = "<font size='18' face='PuristaBold'>CREDITS</font>";
{
	var(_cfg) = _x >> "PRA3_Credits";
	for "_i" from 0 to count _cfg - 1 do
	{
		_credits = _credits + format ["<br/><font color='#ffaaaaaa'>%1:</font> %2", getText (_cfg select _i >> "displayName"), getText (_cfg select _i >> "value")];
	};
} forEach [missionConfigFile, configFile];

_credits = _credits + "<br/><br/><font size='18' face='PuristaBold'>LICENSE</font><br/>This mission and all of its contents are licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International license.<br/><br/>";
_credits = _credits + "<img image='pra3\pra3_ui\data\cc_by-nc-sa_88.paa' width='100' height='35'/><br/><br/>";

// Read the license text from LICENSE.txt
// To get that to display properly in-game we have to convert LF character to "<br/>
#define CHAR_LF 10

var(_license)   = toArray loadFile "LICENSE.txt";
var(_licenseBR) = +_license;
var(_idx) = 0;
{
	if (_x == CHAR_LF) then
	{
		{
			_licenseBR set [_idx, _x];
			_idx = _idx + 1;
		} forEach toArray "<br/>";
	}
	else
	{
		_licenseBR set [_idx, _x];
		_idx = _idx + 1;
	};
} forEach _license;

_credits = _credits + format ["<font color='#ffaaaaaa' size='10'>%1</font>", toString _licenseBR];

player createDiaryRecord ["pra3", ["Credits & License", _credits]];
