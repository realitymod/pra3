#include "scriptDefines.sqh"

/**
 *	This function aims to block players from dropping weapons and equipment.
 *	It's incredibly hacky because inventory is now engine-driven.
 *	The idea is that we disable the controls to prevent anything from being dropped.
 *	For some reason we cannot just disable the controls anymore, somehow the engine re-enables them.
 *	Workaround using onMouseMoving seems to work though.
 */

#define IDC_SLOT_PRIMARY              610
#define IDC_SLOT_PRIMARY_FLASHLIGHT   622
#define IDC_SLOT_PRIMARY_MUZZLE       620
#define IDC_SLOT_PRIMARY_OPTICS       621

#define IDC_SLOT_SECONDARY            611
#define IDC_SLOT_SECONDARY_FLASHLIGHT 626
#define IDC_SLOT_SECONDARY_MUZZLE     624
#define IDC_SLOT_SECONDARY_OPTICS     625

#define IDC_SLOT_HANDGUN              612
#define IDC_SLOT_HANDGUN_FLASHLIGHT   630
#define IDC_SLOT_HANDGUN_MUZZLE       628
#define IDC_SLOT_HANDGUN_OPTICS       629

#define IDC_SLOT_MAP                  6211
#define IDC_SLOT_GPS                  6215
#define IDC_SLOT_RADIO                6214
#define IDC_SLOT_COMPASS              6212
#define IDC_SLOT_WATCH                6213

#define IDC_SLOT_HEADGEAR             6240
#define IDC_SLOT_BINOCULARS           6238
#define IDC_SLOT_HMD                  6217
#define IDC_SLOT_GOGGLES              6216

#define IDC_SLOT_UNIFORM              6331
#define IDC_SLOT_VEST                 6381
#define IDC_SLOT_BACKPACK             6191

{
	uiNamespace getVariable "RscDisplayInventory" displayCtrl _x ctrlAddEventHandler [
		"mouseMoving",
		{
			{
				ctrlParent (_this select 0) displayCtrl _x ctrlEnable false;
			} forEach [
				IDC_SLOT_PRIMARY,
				IDC_SLOT_PRIMARY_MUZZLE,
				IDC_SLOT_PRIMARY_FLASHLIGHT,
				IDC_SLOT_PRIMARY_OPTICS,

				IDC_SLOT_SECONDARY,
				IDC_SLOT_SECONDARY_MUZZLE,
				IDC_SLOT_SECONDARY_FLASHLIGHT,
				IDC_SLOT_SECONDARY_OPTICS,

				IDC_SLOT_HANDGUN,
				IDC_SLOT_HANDGUN_MUZZLE,
				IDC_SLOT_HANDGUN_FLASHLIGHT,
				IDC_SLOT_HANDGUN_OPTICS,

				IDC_SLOT_HANDGUN,
				IDC_SLOT_HANDGUN_FLASHLIGHT,
				IDC_SLOT_HANDGUN_MUZZLE,
				IDC_SLOT_HANDGUN_OPTICS,

				IDC_SLOT_MAP,
				IDC_SLOT_GPS,
				IDC_SLOT_RADIO,
				IDC_SLOT_COMPASS,
				IDC_SLOT_WATCH,

				IDC_SLOT_HEADGEAR,
				IDC_SLOT_BINOCULARS,
				IDC_SLOT_HMD,
				IDC_SLOT_GOGGLES,

				IDC_SLOT_UNIFORM,
				IDC_SLOT_VEST,
				IDC_SLOT_BACKPACK
			];
		}
	];
} forEach [
	IDC_SLOT_PRIMARY,
	IDC_SLOT_PRIMARY_FLASHLIGHT,
	IDC_SLOT_PRIMARY_MUZZLE,
	IDC_SLOT_PRIMARY_OPTICS,

	IDC_SLOT_SECONDARY,
	IDC_SLOT_SECONDARY_FLASHLIGHT,
	IDC_SLOT_SECONDARY_MUZZLE,
	IDC_SLOT_SECONDARY_OPTICS,

	IDC_SLOT_HANDGUN,
	IDC_SLOT_HANDGUN_FLASHLIGHT,
	IDC_SLOT_HANDGUN_MUZZLE,
	IDC_SLOT_HANDGUN_OPTICS,

	IDC_SLOT_MAP,
	IDC_SLOT_GPS,
	IDC_SLOT_RADIO,
	IDC_SLOT_COMPASS,
	IDC_SLOT_WATCH,

	IDC_SLOT_HEADGEAR,
	IDC_SLOT_BINOCULARS,
	IDC_SLOT_HMD,
	IDC_SLOT_GOGGLES,

	IDC_SLOT_UNIFORM,
	IDC_SLOT_VEST,
	IDC_SLOT_BACKPACK
];

uiNamespace getVariable "RscDisplayInventory" displayCtrl 6554 lbSetCurSel 1;
uiNamespace getVariable "RscDisplayInventory" displayCtrl 6554 ctrlEnable false;
