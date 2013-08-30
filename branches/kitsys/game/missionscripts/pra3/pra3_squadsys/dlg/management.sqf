#define gvar(x) x

// Client only
if (!isDedicated) then
{
	gvar(PRAA_squadSys_dlgOpenedOn) = 0; // Time the dialog was opened on

	gvar(PRAA_squadSys_playerOnLine) = -1; // Line the player is on in the squad members list (1-based)

	gvar(PRAA_squadSys_menuTarget) = ""; // UID of the unit interacted with via pop-up menu (NOTE: "" indicates no menu)
	gvar(PRAA_squadSys_menuPos) = [];    // Screen-space coordinates of the pop-up menu

	gvar(PRAA_squadSys_editingCustomName) = false; // Editing squad's custom name?
	gvar(PRAA_squadSys_customNamePrev) = "";       // Last state of the custom name

	gvar(PRAA_squadSys_collapsedSquads) = []; // Collapse state of squad boxes, player is index 0, unassigned is 26
	PRAA_squadSys_collapsedSquads resize 9;
	for "_i" from 0 to 9 do
	{
		PRAA_squadSys_collapsedSquads set [_i, false]; // Nothing collapsed by default
	};
};
