/**
 *	Returns the ID of the given side.
 *
 *		(in)  <SIDE> team
 *		(out) <INT> [players count team A, players count team B]
 */

#include "scriptDefines.sqh"

//Get one team name and return the number of active players on each team
var(_teamA) = _this;

var(_teamACount) = 0;
var(_teamBCount) = 0;
var(_allplayers) = [] call PRA3_fnc_getConnectedPlayers; 
	{
		var(_team) = _x call PRA3_fnc_getplayerTeam;
		if (_team == _teamA) then 
			{
				_teamACount = _teamACount +1;
			}
			else
			{
				_teamBCount = _teamBCount +1;
			};
	} forEach _allplayers;
	
//return value	
[_teamACount,_teamBCount];