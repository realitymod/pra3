#define __anims [\
	"ainvpercmstpsraswrfldnon",\
	"ainvpknlmstpsraswrfldnon",\
	"ainvppnemstpsraswrfldnon",\
	"ainvpercmstpsraswpstdnon",\
	"ainvpknlmstpsraswpstdnon",\
	"ainvppnemstpsraswpstdnon",\
	"ainvpercmstpsnonwnondnon",\
	"ainvpknlmstpsnonwnondnon",\
	"ainvppnemstpsnonwnondnon" \
]

if (toLower (_this select 1) in __anims) then
{
	0 spawn
	{
		waitUntil {!isNull (uiNamespace getVariable "RscDisplayInventory")};
		{
			uiNamespace getVariable "RscDisplayInventory" displayCtrl _x ctrlEnable false;
		} forEach [610, 620, 622, 621, 611, 624, 626, 625, 612, 628, 630, 629];

		uiNamespace getVariable "RscDisplayInventory" displayCtrl 6554 lbSetCurSel 1;
		uiNamespace getVariable "RscDisplayInventory" displayCtrl 6554 ctrlEnable false;
	};
};
