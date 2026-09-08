/*
    File: fn_bluforMarkers.sqf
    Author: Timmy Taliban

    Description: Advanced markers based on GPS inventory item
*/
private ["_markers","_cops"];
_markers = [];
_cops = [];
_refresh = 0.1;

sleep 0.5;
if (visibleMap) then {
    {if ((side _x isEqualTo west) && ("ItemRadio" in (assignedItems _x))) then {_cops pushBack _x;}} forEach playableUnits; // Replace "(units west)" with "playableUnits" for MP testing

    //Create markers
    {
        //	--- Using mil_triangle
			//if !(_x isEqualTo player) then {
            _marker = createMarkerLocal [format ["%1_marker",_x],visiblePosition _x];
            _marker setMarkerColorLocal "ColorBLUFOR";
            _marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerSizeLocal [0.6, 0.9];
			_marker setMarkerDirLocal (direction _x);
            _marker setMarkerTextLocal format ["%1", _x getVariable ["realname",name _x]];
            _markers pushBack [_marker,_x];
        };
		//
    } forEach _cops;

    while {visibleMap} do {
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
    _cops = [];