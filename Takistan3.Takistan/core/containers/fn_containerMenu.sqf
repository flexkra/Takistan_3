#include "..\..\script_macros.hpp"
/*
	File: fn_containerMenu.sqf
	Author: xydra "xydra" xydra

	Shows the container menu
*/
private["_cInv","_pInv","_pIcon","_cIcon","_item","_amount"];
disableSerialization;

_cInv = CONTROL(54000,5401);
_pInv = CONTROL(54000,5402);
lbClear _cInv;
lbClear _pInv;

{
	if(ITEM_VALUE(configName _x) > 0) then {
		_pInv lbAdd format["%2 [x%1]",ITEM_VALUE(configName _x),localize (getText(_x >> "displayName"))];
		_pInv lbSetData [(lbSize _pInv)-1,configName _x];
		_pIcon = M_CONFIG(getText,"VirtualItems",configName _x,"icon");
		if(!(EQUAL(_pIcon,""))) then {
			_pInv lbSetPicture [(lbSize _pInv)-1,_pIcon];
		};
	};
} foreach ("true" configClasses (missionConfigFile >> "VirtualItems"));

diag_log format["life_container_inventory: %1",life_container_inventory];
if(count life_container_inventory == 0) exitWith {};
{
	_item = _x select 0;
	_amount = _x select 1;
	_cInv lbAdd format["%2 [x%1]",_amount,localize ITEM_NAME(_item)];
	_cInv lbSetData [(lbSize _cInv)-1,_item];
	_cIcon = M_CONFIG(getText,"VirtualItems",_item,"icon");
	if(!(EQUAL(_cIcon,""))) then {
		_cInv lbSetPicture [(lbSize _cInv)-1,_cIcon];
	};
} forEach life_container_inventory;