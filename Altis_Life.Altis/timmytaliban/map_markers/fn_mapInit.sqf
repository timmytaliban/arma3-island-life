 params [
	["_mapOpen",false,[false]]
 ];

 if (_mapOpen) then {
     switch playerSide do {
        case west: {[] spawn life_fnc_bluforMarkers; [] spawn life_fnc_indepMarkers;};
        case independent: {[] spawn life_fnc_bluforMarkers; [] spawn life_fnc_indepMarkers;};
        case civilian: {[] spawn life_fnc_civMarkers;};
     };
 } 
 	else 
 {

 };
