class Kits
{
	file = "pra3\pra3_kits\fnc";

	class blockInventory
	{
		description = "Blocks certain controls in the inventory dialog.";
	};

	class getKitVariants
	{
		description = "Returns a list of config paths for the variants of the given kit.";
	};
	class getSelectedKitVariant
	{
		description = "Returns the class name of the currently selected variant of the given kit.";
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
};
