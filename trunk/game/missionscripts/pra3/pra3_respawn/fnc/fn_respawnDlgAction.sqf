#include "scriptDefines.sqh"

#define ctrl(idc) (uiNamespace getVariable "PRA3_dlg_spawnScreen" displayCtrl idc)

var(_action) = _this select 1;

switch (toLower _action) do
{
	case "onlbselchanged":
	{
		var(_idx) = (_this select 0) select 1;
		if (_idx != -1) then
		{
			PRA3_AAS_selectedSpawn = ((_this select 0) select 0) lbData _idx;
		};

		// Draw selected marker
		deleteMarkerLocal "PRA3_selectedSpawn"; // Delete old one first
		if (PRA3_AAS_selectedSpawn != "") then
		{
			var(_marker) = createMarkerLocal ["PRA3_selectedSpawn", getMarkerPos PRA3_AAS_selectedSpawn];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "Select";
			_marker setMarkerSizeLocal [1.5,1.5];

			// Center the map
			ctrlMapAnimClear ctrl(20);
			ctrl(20) ctrlMapAnimAdd [0.1, 0.1, getMarkerPos PRA3_AAS_selectedSpawn];
			ctrlMapAnimCommit ctrl(20);
		};
	};
	case "onmapsingleclick":
	{
		if (lbSize ctrl(10) > 0) then
		{
			var(_pos)  = _this select 0;
			var(_best) = ctrl(10) lbData 0;
			var(_idx)  = 0;

			for "_i" from 0 to (lbSize ctrl(10))-1 do
			{
				if (getMarkerPos(ctrl(10) lbData _i) distance _pos < getMarkerPos _best distance _pos) then
				{
					_best = ctrl(10) lbData _i;
					_idx = _i;
				};
			};

			if ((getMarkerPos _best distance _pos) < 50) then
			{
				PRA3_AAS_selectedSpawn = _best;
				ctrl(10) lbSetCurSel _idx;
			}
			else
			{
				PRA3_AAS_selectedSpawn = "";
				ctrl(10) lbSetCurSel -1;
			};
		};
	};
};
