#include "scriptDefines.sqh"
#include "defines.sqh"

PRA3_kits = [];

var(_loadWeapon) =
{
	if (isClass _this && {getText(_this >> "weapon") != ""}) then
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

var(_loadRequirements) =
{
	var(_type) = getNumber(_this >> "type");
	var(_requirements) = [_type];

	var(_properties) = switch (_type) do
	{
		case LIMIT_NO:
		{
			[]
		};
		case LIMIT_SQUAD:
		{
			[
				getNumber(_this >> "perEvery"),
				getNumber(_this >> "minMembers"),
				getNumber(_this >> "maxPerSquad")
			]
		};
		case LIMIT_SL:
		{
			[
				getNumber(_this >> "minMembers")
			]
		};
	};

	(_requirements + _properties)
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
			var(_secondary) = (_variant >> "Secondary") call _loadWeapon;
			var(_backpack) = if (isClass(_variant >> "Backpack") && {getText(_variant >> "Backpack" >> "backpack") != ""}) then
			{
				[
					getText(_variant >> "Backpack" >> "backpack"),
					getArray(_variant >> "Backpack" >> "weapons"),
					getArray(_variant >> "Backpack" >> "magazines")
				]
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
	/* VARIANT_BACKPACK    */ _backpack,
	/* VARIANT_EXPLOSIVES  */ getArray(_variant >> "explosives"),
	/* VARIANT_ITEMS       */ getArray(_variant >> "items")
				]
			];
		};

		var(_clothing) = [
	/* CLOTHING_UNFORM   */	getText(_kit >> "Clothing" >> "uniform"),
	/* CLOTHING_HEADGEAR */	getText(_kit >> "Clothing" >> "headgear"),
	/* CLOTHING_GOGGLES  */	getText(_kit >> "Clothing" >> "goggles"),
	/* CLOTHING_VEST     */	getText(_kit >> "Clothing" >> "vest")
		];

		missionNamespace setVariable [
			format ["PRA3_kit_%1", _name],
			[
	/* KIT_TEAM         */ getText(_kit >> "team"),
	/* KIT_NAME         */ getText(_kit >> "name"),
	/* KIT_PICTURE      */ getText(_kit >> "picture"),
	/* KIT_REQUIREMENTS */ ((_kit >> "Requirements") call _loadRequirements),
	/* KIT_AVAILABLEAT  */ getArray(_kit >> "availableAt"),
	/* KIT_CLOTHING     */ _clothing,
	/* KIT_VARIANTS     */ _variants,
	/* KIT_VARIANT_CURR */ 0
			]
		];
	};
};

PRA3_kits
