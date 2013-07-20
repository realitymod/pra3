_cfg = configFile >> "CfgVehicles" >> typeOf cursorTarget >> "UserActions";for "_i" from 0 to (count _cfg - 1) do{	_entry = _cfg select _i;	if (isClass _entry && {getText(_entry >> "condition") != ""} && {getText(_entry >> "statement") != ""}) then	{		_point = getText(_entry >> "position");		_radius = getNumber(_entry >> "radius");		if (player modelToWorld (player selectionPosition "head") distance (cursorTarget modelToWorld (cursorTarget selectionPosition _point)) < 4) then		{			this = cursorTarget;			if (call compile getText(_entry >> "condition")) then			{				call compile getText(_entry >> "statement");			};		};	};};private ["_v","_return"];_return = false;_v = vehicle player; if (vehicle player != player) then{	if (driver _v == player) then	{		player action ["getOut", vehicle player];	};	if (driver _v != player) then	{		player action ["Eject", vehicle player];	};}else {	if (!isNull cursorTarget) then	{		if ((not isNull cursorTarget) and (vehicle player == player) and ((player distance vehicle cursorTarget) < 5)) then		{			if (isNull driver vehicle cursorTarget) then			{				player moveindriver vehicle cursorTarget;				_return = true;			};			if ((vehicle player == player) and (isNull gunner vehicle cursorTarget)) then			{				player moveingunner vehicle cursorTarget;				_return = true;			};			if ((vehicle player == player) and (isNull commander vehicle cursorTarget)) then			{				player moveInCommander vehicle cursorTarget;				_return = true;			};			if (vehicle player == player) then			{				player moveInCargo vehicle cursorTarget;				_return = true;			};		};	};};_return