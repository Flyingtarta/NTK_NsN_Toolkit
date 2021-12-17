

//spawn me
[] spawn {["obj1",60,opfor]  call nsn_fnc_TartaSectorAD};
[] spawn {["obj_n",60]       call nsn_fnc_TartaSectorAD};
[] spawn {["obj2",60,blufor] call nsn_fnc_TartaSectorAD};

private _tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
waituntil {time> _tiempoPreparacion*60}; //esperamos que pase la estapa de preparacion

_duracion = ["Duracion",165] call BIS_fnc_getParamValue;
marcador = createHashMapFromArray [ [blufor,0] , [opfor,0] , [sideUnknown,0]];
_objetivos = ["obj1","obj_n","obj2"];
sleep 1;
while {time < (_duracion+_tiempoPreparacion)*60} do {
    if ( (round(time)%60) isequalto 0) then {
        {
            _areaState = missionNamespace getvariable _x;
            _owner = _areaState get "owner";
            marcador set [_owner, (marcador get _owner) + 1];
            publicVariable "marcador";
        }foreach _objetivos;
    };
    sleep 1;
};

_puntosOpfor = marcador get opfor;
_puntosBlufor = marcador get blufor;
if (_puntosOpfor isequalto _puntosBlufor) then {
    ["end1", true] remoteexec ["BIS_fnc_endMission",opfor];
    ["end1", true] remoteexec ["BIS_fnc_endMission",blufor];
}else{
    if (_puntosOpfor>_puntosOpfor) then {
        ["end1", true] remoteexec ["BIS_fnc_endMission",opfor];
        ["end1", false] remoteexec ["BIS_fnc_endMission",blufor];
    }else{
        ["end1", false] remoteexec ["BIS_fnc_endMission",opfor];
        ["end1", true] remoteexec ["BIS_fnc_endMission",blufor];

    };
};
sleep 1;
["end1", true] call BIS_fnc_endMission;
