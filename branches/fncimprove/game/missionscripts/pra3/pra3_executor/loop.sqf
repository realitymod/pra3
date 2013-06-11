while {true} do
{
	_last = -1;
	{
		if (_x select 0 > time) exitWith {};
		(_x select 2) call (_x select 1);
		_last = _forEachIndex;
	} forEach PRA3_executor_events;
	
	if (_last > -1) then
	{
		for "_i" from _last to (count PRA3_executor_events)-1 do
		{
			PRA3_executor_events set [_i - _last, PRA3_executor_events select (_i + 1)];
		};
		
		PRA3_executor_events resize (count PRA3_executor_events - _last - 1);
	};
	
	sleep 0.1;
};
