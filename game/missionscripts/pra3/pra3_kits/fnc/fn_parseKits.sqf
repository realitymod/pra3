#include "scriptDefines.sqh"
#include "defines.sqh"

PRA3_kits = [];

var(_loadWeapon) =
{
	if (isClass _this) then
	{
		[
			getText (_this >> "weapon"),
			getArray(_this >> "magazines"),
			[
				getText(_this >> "optics"),
				getText(_this >> "rail"),
				getText(_this >> "muzzle")
			]
		]
	}
	else
	{
		[]
	}
};

var(_cfg) = missionConfigFile >> "PRA3_kits" >> "Kits";
for "_i" from 0 to (count _cfg - 1) do
{
	var(_kit) = _cfg select _i;
	if (getNumber(_kit >> "scope") == 2) then // Only public kits
	{
		var(_name) = configName _kit;
		PRA3_kits set [_i, _name];

		var(_variants) = [];
		_variants resize count (_kit >> "Variants");
		for "_j" from 0 to (count (_kit >> "Variants") - 1) do
		{
			var(_variant) = (_kit >> "Variants") select _j;

			var(_pistol)  = (_variant >> "Pistol") call _loadWeapon;
			var(_primary) = (_variant >> "Primary") call _loadWeapon;
			var(_secondary) = if (isClass(_variant >> "Secondary")) then
			{
				if (getNumber(_variant >> "Secondary" >> "type") == TYPE_WEAPON) then
				{
					[
						TYPE_WEAPON,
						(_variant >> "Secondary") call _loadWeapon
					]
				}
				else
				{
					[
						TYPE_BACKPACK,
						[
							getText(_variant >> "Secondary" >> "backpack"),
							getArray(_variant >> "Secondary" >> "weapons"),
							getArray(_variant >> "Secondary" >> "magazines")
						]
					]
				}
			}
			else
			{
				[]
			};

			_variants set [
				_j,
				[
	/* VARIANT_CLASS       */ configName _variant,
	/* VARIANT_NAME        */ getText(_variant >> "name"),
	/* VARIANT_PISTOL      */ _pistol,
	/* VARIANT_PRIMARY     */ _primary,
	/* VARIANT_SECONDARY   */ _secondary,
	/* VARIANT_EXPLOSIVES  */ getArray(_variant >> "explosives"),
	/* VARIANT_ITEMS       */ getArray(_variant >> "items")
				]
			];
		};

		var(_clothing) = [
			getText(_kit >> "Clothing" >> "uniform"),
			getText(_kit >> "Clothing" >> "headgear"),
			getText(_kit >> "Clothing" >> "goggles"),
			getText(_kit >> "Clothing" >> "vest")
		];

		missionNamespace setVariable [
			format ["PRA3_kit_%1", _name],
			[
	/* KIT_TEAM         */ getNumber(_kit >> "side"),
	/* KIT_NAME         */ getText(_kit >> "name"),
	/* KIT_PICTURE      */ getText(_kit >> "picture"),
	/* KIT_REQUIREMENTS */ [], // requirements
	/* KIT_CLOTHING     */ _clothing,
	/* KIT_VARIANTS     */ _variants,
	/* KIT_VARIANT_CURR */ 0
			]
		];
	};
};

PRA3_kits
