#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Enables/disables all interactive controls.
 *
 *		(in)  <BOOL> enable?
 *		(out) <VOID>
 */

var(_enable) = _this;

if (!isNull (uiNamespace getVariable "Rsc_PRAA_squadSys_manageDlg")) then
{
	for "_i" from 1 to 27 do
	{
		ctrl(10000*_i + 6000) ctrlEnable _enable; // Action button
		ctrl(10000*_i + 7002) ctrlEnable _enable; // Collapse button
	};
	ctrl(500000 + 5002) ctrlEnable _enable; // Lock button
	ctrl(500000 + 3002) ctrlEnable _enable; // Rename action text
	ctrl(990000 + 9000) ctrlEnable _enable; // Invite button
	ctrl(990000 + 7002) ctrlEnable _enable; // Collapse unassigned button
	ctrl(999901) ctrlEnable _enable;        // Create squad button
};
