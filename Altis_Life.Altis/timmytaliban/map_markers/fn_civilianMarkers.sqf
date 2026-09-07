/*
    File: fn_civMarkers.sqf
    Author: Timmy Taliban

    Description: Advanced markers based on GPS inventory item
*/
private ["_markers","_members"];
_markers = [];
_members = [];
_refresh = 0.1;

for "_i" from 0 to 1 step 0 do {
    sleep 0.5;
    if (visibleMap) then
    {
        _members = [];
        {if ("ItemGPS" in (assignedItems _x)) then {_members pushBack _x;}} forEach (units (group player));
        {
            _marker = createMarkerLocal [format ["%1_marker",_x],visiblePosition _x];
            _marker setMarkerColorLocal "ColorCIV";
            _marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerSizeLocal [0.6, 0.9];
			_marker setMarkerDirLocal (direction _x);
            _marker setMarkerTextLocal format ["%1", _x getVariable ["realname",name _x]];
            _markers pushBack [_marker,_x];
        } forEach _members;

        while {visibleMap} do
        {
            {
                private ["_unit"];
                _unit = _x select 1;
                if (!isNil "_unit" && !isNull _unit) then {
                      (_x select 0) setMarkerPosLocal (visiblePosition _unit);
                };
            } forEach _markers;
            if (!visibleMap) exitWith {};
            sleep _refresh;
        };

        {deleteMarkerLocal (_x select 0);} forEach _markers;
        _markers = [];
        _members = [];
    };
};