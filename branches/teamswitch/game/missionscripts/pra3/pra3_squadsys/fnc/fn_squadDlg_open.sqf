#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"

var(_showSpawnMap) =  if (count _this == 0) then {
		if (isNil "PRA3_showRespawnSelection") then {
			false
		} else {
			PRA3_showRespawnSelection
		}
	} else {
		_this select 0
	};

PRA3_showRespawnSelection = _showSpawnMap;

createDialog "Rsc_PRA3_squadSys_manageDlg";
