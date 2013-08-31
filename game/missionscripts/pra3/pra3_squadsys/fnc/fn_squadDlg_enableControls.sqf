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
		__ctrl(10000*_i + 6000) ctrlEnable _enable; // Action button
		__ctrl(10000*_i + 7002) ctrlEnable _enable; // Collapse button
	};
	__ctrl(500000 + 5002) ctrlEnable _enable; // Lock button
	__ctrl(500000 + 3002) ctrlEnable _enable; // Rename action text
	__ctrl(990000 + 9000) ctrlEnable _enable; // Invite button
	__ctrl(990000 + 7002) ctrlEnable _enable; // Collapse unassigned button
	__ctrl(999901) ctrlEnable _enable;        // Create squad button
};
