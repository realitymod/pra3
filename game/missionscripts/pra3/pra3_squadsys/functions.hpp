class SquadSys
{
	file = "pra3\pra3_squadsys\fnc";

	class broadcastSquadVariable
	{
		description = "Broadcasts the value of the squad's variable to all clients.";
	};
	class createSquad
	{
		description = "Creates a squad and returns its unique ID. Returns -1 if a squad cannot be created or the player is already in a squad.";
	};
	class destroySquad
	{
		description = "Destroys the given squad. Returns false if the squad doesn't exist.";
	};
	class getSideID
	{
		description = "Returns the base value of squads of the given side.";
	};
	class getUnassignedPlayers
	{
		description = "Returns an array of unassigned players for the given side.";
	};
	class squadExists
	{
		description = "Checks if a squad with the given ID exists.";
	};
	class squadGetFtLeader
	{
		description = "Returns UID of the squad's fireteam leader. Returns an empty string if the squad or FT does not exist, or the FT has no leader.";
	};
	class squadGetLeader
	{
		description = "Returns UID of the squad's leader. Returns an empty string if the squad does not exist.";
	};
	class squadGetMembers
	{
		description = "Returns a POINTER to an array of squads members. Returns an empty string if the squad does not exist.";
	};
	class squadGetMembersNum
	{
		description = "Returns the number of memebers of the squad.";
	};
	class squadGetName
	{
		description = "Returns the optional name of the squad's leader. Returns an empty string if the squad does not exist (or no name is assigned).";
	};
	class squadGetSide
	{
		description = "Returns the side the squad is on.";
	};
	class squadGetSize
	{
		description = "Returns the max size the squad allows. Returns -1 if the squad does not exist.";
	};
	class squadIsLocked
	{
		description = "Returns whether the squad is locked.";
	};
	class squadSetFtLeader
	{
		description = "Sets a new fireteam leader for the squad, demoting the previous leader if need be. Returns false if the squad or the unit does not exist.";
	};
	class squadSetLeader
	{
		description = "Sets a new squad leader for the squad, demoting the previous leader if need be. Returns false if the squad or the unit does not exist.";
	};
	class squadSetLocked
	{
		description = "Sets whether the squad is locked. Returns false if the squad or the unit does not exist.";
	};
	class squadSetMembers
	{
		description = "Sets the array of members for the given squad. Returns false if the squad or the unit does not exist.";
	};
	class squadSetName
	{
		description = "Sets the optional name of the squad. Returns false if the squad or the unit does not exist.";
	};
	class squadSetSize
	{
		description = "Sets the max size of the squad. Returns false if the squad or the unit does not exist.";
	};
	class unitGetFt
	{
		description = "Returns ID of the fireteam the unit is assigned to. Returns -1 if the unit does not belong to the squad, 0 if the unit has no FT assigned.";
	};
	class unitGetSquad
	{
		description = "Returns ID of the squad the unit is a member of. Returns -1 if the unit is unassigned.";
	};
	class unitJoinSquad
	{
		description = "Assignes the given unit to the squad. Returns false if the squad does not exist.";
	};
	class unitLeaveSquad
	{
		description = "Removes the given unit from the squad. Updates leadership within the squad or completely dissolves it if necessary. Returns false if the squad does not exist or the unit is not a memeber.";
	};
	class unitSetFt
	{
		description = "Assigns fireteam to the unit. Setting FT ID to 0 will unassign the unit from its current FT. Returns false if the squad does not exist or the unit is not the squad's memeber.";
	};
	class updateFtLeadership
	{
		description = "Ensures that the squad's fireteam has a leader and if not, the highest ranking member of the fireteam is promoted. Returns false if the squad does not exist or no changes have been made.";
	};
	class updateSquadLeadership
	{
		description = "Ensures that the squad has a leader and if not, the highest ranking member is promoted. Returns false if the squad does not exist or no changes have been made.";
	};
	
	class isSquadLeader
	{
		description = "Returns whether the unit is a squad leader. Unassigned units aren't considered squad leaders and return false.";
	};
	class isInSquad
	{
		description = "Returns true if the unit is in a squad or fales if it is unassigned.";
	};

	class squadDlg_actionButton
	{
	};
	class squadDlg_collapseSquad
	{
	};
	class squadDlg_collapseUnassigned
	{
	};
	class squadDlg_customName
	{
	};
	class squadDlg_enableControls
	{
	};
	class squadDlg_highlightLines
	{
	};
	class squadDlg_inviteButton
	{
	};
	class squadDlg_lockSquad
	{
	};
	class squadDlg_menuButton
	{
	};
	class squadDlg_onLoad
	{
	};
	class squadDlg_onMouseClick
	{
	};
	class squadDlg_onMouseMoving
	{
	};
	class squadDlg_refresh
	{
	};
	class squadDlg_repositionSquadBoxes
	{
	};
	class squadDlg_showPopupMenu
	{
	};
	class squadDlg_toggleCollapseSquad
	{
	};
	class squadDlg_updateSquadsInfo
	{
	};

	class squadDlg_server_createSquad
	{
	};
	class squadDlg_server_customNameSave
	{
	};
	class squadDlg_server_joinSquad
	{
	};
	class squadDlg_server_kickOut
	{
	};
	class squadDlg_server_lockSquad
	{
	};
	class squadDlg_server_refresh
	{
	};
	class squadDlg_server_setFt
	{
	};
	class squadDlg_server_setFtLeader
	{
	};
	class squadDlg_server_setNewSL
	{
	};
	class squadDlg_server_unsetFt
	{
	};
	
	class squadDlg_open
	{
		description = "Opens the Squad Management dialog.";
	};
};
