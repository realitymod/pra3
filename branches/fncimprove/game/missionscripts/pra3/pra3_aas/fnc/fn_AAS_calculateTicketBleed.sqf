#include "scriptDefines.sqh"
#include "aas_defines.sqh"

// Reset to 0
{
	PRA3_AAS_ticketBleed set [_forEachIndex, 0];
} forEach PRA3_AAS_sides;

// Now add up the bleed for each zone
// For each zone...
{
	var(_owner) = _forEachIndex call PRA3_fnc_AAS_getZoneOwner;
	if (_owner != __neutral) then
	{
		var(_bleed) = _x select 4;
		var(_sync)  = _x select 1;
		// For each team...
		{
			if (_x != _owner &&
				{
					var(_o) = _x call PRA3_fnc_AAS_getZoneOwner;
					_o == __neutral || _o != _owner
				} count _sync == 0
				&& (_bleed select _forEachIndex) > 0) then
			{
				PRA3_AAS_ticketBleed set [
					_forEachIndex,
					(PRA3_AAS_ticketBleed select _forEachIndex) + (_bleed select _forEachIndex)
				];
			};
		} forEach PRA3_AAS_sides;
	};
} forEach PRA3_AAS_zones;
