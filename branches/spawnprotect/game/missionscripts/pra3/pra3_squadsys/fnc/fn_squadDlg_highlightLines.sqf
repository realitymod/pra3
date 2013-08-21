#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Highlights the currently active line and un-highlights the other lines.
 *
 *		(in)  <VOID>
 *		(out) <VOID>
 */

var(_colorRegular)   = getArray(__cfgPathItemListLine(01,"01") >> "Controls" >> "Background" >> "colorBackground");
var(_colorHighlight) = getArray(__cfgPathItemListLine(01,"01") >> "Controls" >> "Background" >> "colorBackgroundHighlight");

for "_i" from 1 to __squadSize do
{
	__ctrl(500000 + 8000 + 10*_i + 6)
		ctrlSetBackgroundColor (
			if (_i == PRA3_squadSys_playerOnLine) then {
				if (_i == PRA3_squadSys_currentLine) then {__memberLineColorHighlightPlayer} else {__memberLineColorNormalPlayer}
			} else {
				if (_i == PRA3_squadSys_currentLine) then {__memberLineColorHighlight} else {__memberLineColorNormal}
			}
		);
};
