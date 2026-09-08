#include "..\..\script_macros.hpp"
/*
    File: fn_addVirtualItems.sqf
    Author: Claude

    Description:
    Adds one or more virtual items to the caller's virtual inventory, respecting
    the player's carry weight. Meant to be called from mission scripts to hand a
    player items in one call. Purely mechanical: no notification, no logging.
    Amounts that don't fully fit are added partially (same behaviour as
    life_fnc_handleInv).

    Runs on the machine it is called on and acts on that machine's player /
    life_carryWeight, like all other virtual inventory code.

    Parameter(s):
        0: ARRAY - Items to add. Either a list of [_className,_quantity] pairs
                   or a single [_className,_quantity] pair.

    Returns:
        ARRAY - List of [_className,_added] for every item that had at least
                1 unit added. Empty array if nothing could be added.

    Example(s):
        [[["redgull",5],["pickaxe",1]]] call life_fnc_addVirtualItems;   // list of pairs
        ["waterBottle",1] call life_fnc_addVirtualItems;                  // single pair
*/
private ["_items","_added","_class","_qty","_diff"];

_items = _this;
if (isNil "_items" || {!(_items isEqualType [])} || {_items isEqualTo []}) exitWith {[]};

//Allow passing a single [_class,_qty] pair instead of a list of pairs
if ((_items select 0) isEqualType "") then {
    _items = [_items];
};

_added = [];

{
    _class = [_x,0,"",[""]] call BIS_fnc_param;
    _qty   = [_x,1,0,[0]] call BIS_fnc_param;

    if (_class isEqualTo "" || _qty <= 0) then {
        //Skip malformed entry
    } else {
        if !(isClass (missionConfigFile >> "VirtualItems" >> _class)) then {
            diag_log format ["life_fnc_addVirtualItems: Unknown virtual item '%1'",_class];
        } else {
            //How much actually fits given the player's current weight
            _diff = [_class,_qty,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
            if (_diff > 0 && {[true,_class,_diff] call life_fnc_handleInv}) then {
                _added pushBack [_class,_diff];
            };
        };
    };
} forEach _items;

_added
