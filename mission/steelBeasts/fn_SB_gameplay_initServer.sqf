

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
    {
        systemchat str _x;
        _areaState = missionNamespace getvariable _x;
        systemchat str _areaState;
        _owner = _areaState get "owner";
        marcador set [_owner, (marcador get _owner) + 1];
        publicVariable "marcador";
    }foreach _objetivos;
    sleep 60;
};

_puntosOpfor = marcador get opfor;
_puntosBlufor = marcador get blufor;

if (_puntosOpfor>_puntosOpfor) then {
    //gano opfor
    hint "gano opfor";
}else{
    //gano blufor
    hint "gano blufor";
};
