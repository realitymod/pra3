#include "scriptDefines.sqh"

#define TEast			0
#define TWest			1
#define TGuerrila		2
#define TCivilian		3
#define TSideUnknown	4
#define TEnemy			5
#define TFriendly		6
#define TLogic			7

/**
 *	Returns the side the vehicle belongs to, regardless of who is inside it.
 *		(in)  <STRING> Vehicle classname
 *				or
 *		(in)  <OBJECT> Vehicle
 *		(out) <STRING> Display name
 */

if (typeName _this == "OBJECT" && _this isKindOf "CAManBase") then
{
	_this call PRA3_fnc_getPlayerSide
}
else
{
	var(_className) = if (typeName _this == "STRING") then {_this} else {typeOf _this};

	var(_cfg) = (configFile >> "CfgVehicles" >> _className >> "side");
	var(_side) = if (isNumber _cfg) then {getNumber _cfg} else {TSideUnknown};

	switch (_side) do
	{
		case TEast:
		{
			east
		};
		case TWest:
		{
			west
		};
		case TGuerrila:
		{
			resistance
		};
		case TCivilian:
		{
			if (_className isKindOf "ReammoBox") then
			{
				if (_className isKindOf "USBasicAmmunitionBox") then
				{
					west
				}
				else
				{
					if (_className isKindOf "RUBasicAmmunitionBox") then
					{
						east
					}
					else
					{
						if (_className isKindOf "GuerillaCacheBox") then
						{
							resistance
						}
						else
						{
							civilian
						}
					}
				}
			}
			else
			{
				civilian
			}
		};
		case TEnemy:
		{
			sideEnemy
		};
		case TFriendly:
		{
			sideFriendly
		};
		case TLogic:
		{
			sideLogic
		};
		default
		{
			civilian
		};
	}
}
