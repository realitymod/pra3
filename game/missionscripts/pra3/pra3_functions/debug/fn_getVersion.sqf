/**
 * Returns the version number of the given component.
 *
 *		(in)  <ARRAY>:
 *		    0 <STRING> Component:
 *		                - "core"
 *		                - "mission"
 *		    1 <STRING> Format type:
 *		                - "array"
 *		                - "dot"
 *		(out) <ARRAY> When format is "array": [major, minor, release, revision]
 *			OR
 *		(out) <STRING> When format is "dot": "major.minor.release.revision"
 */

#include "scriptDefines.sqh"

var(_component) = _this select 0;
var(_format)  = _this select 1;

var(_version) = switch (toLower _component) do
{
	case "core":
	{
		if (isNil "PRA3_coreVersion") then
		{
			PRA3_coreVersion = getArray(missionConfigFile >> "CfgPatches" >> "PRA3_core" >> "version");
			PRA3_coreVersion set [3, parseNumber loadFile "pra3\revision.txt"];
		};

		PRA3_coreVersion
	};
	case "mission":
	{
		if (isNil "PRA3_missionVersion") then
		{
			PRA3_missionVersion = getArray(missionConfigFile >> "missionVersion");
			if (count PRA3_missionVersion > 0) then // Make sure we're in a PR mission, we don't want file not found error messages otherwise
			{
				PRA3_missionVersion set [3, parseNumber loadFile "revision.txt"];
			}
			else
			{
				PRA3_missionVersion = [];
			};
		};

		PRA3_missionVersion
	};
	default
	{
		[]
	};
};

if (count _version == 4) then
{
	if (_format == "array") then
	{
		_version
	}
	else
	{
		format [
			"%1.%2.%3.%4",
			_version select 0,
			_version select 1,
			_version select 2,
			_version select 3
		]
	}
}
else
{
	if (_format == "array") then {[]} else {""}
}
