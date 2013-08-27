class Kits
{
	file = "pra3\pra3_kits\fnc";

	class blockInventory
	{
		description = "Blocks certain controls in the inventory dialog.";
	};

	class parseKits
	{
		description = "Parses kits from config to variables.";
	};
	class getKitInfo
	{
		description = "Returns the info for the given kit.";
	};

	class equipWithKit
	{
		description = "Equips the unit with the given kit. Also notifies the server about it.";
	};

	class getKitAvailableNum
	{
		description = "Returns the number of kits the given unit has available.";
	};
	class getMaxKitAvailableNum
	{
		description = "Returns the max number of kits that could be available to the give unit.";
	};

	class unitGetKit
	{
		description = "Returns the unit's kit. Returns an empty string if the unit had no kit assigned.";
	};
	class unitSetKit
	{
		description = "Sets the unit's kit. Has to be run server-side.";
	};

	class kitDlg_updateAvailability
	{
		description = "Checks availabilty of kits, updates descriptions and disables the request button.";
	};
	class kitDlg_kitDetailsBtn
	{
		description = "Handles clicking on a kit details button.";
	};
	class kitDlg_loadoutVariantLB
	{
		description = "Handles switching to a different loadout variant in the variants ListXBox.";
	};
	class kitDlg_onLoad
	{
		description = "Handles opening of the kit selection dialog.";
	};
	class kitDlg_populateKitSelection
	{
		description = "Populates the list of all selectable kits.";
	};
	class kitDlg_populateVariants
	{
		description = "Populates the list of possible kit variants.";
	};
	class kitDlg_populateKitDetails
	{
		description = "Populates the kit details part of the kit dialog.";
	};
	class kitDlg_requestKitBtn
	{
		description = "Handles activating the request kit button.";
	};
	class kitDlg_expandKitDetails
	{
		description = "";
	};
	class kitDlg_hideKitDetails
	{
		description = "";
	};
	class kitDlg_open
	{
		description = "Opens the Kit Selection dialog.";
	};
};
