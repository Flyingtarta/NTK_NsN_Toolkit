

/*

	Description:
		Tiempo de alto el fuego para dar tiempo a los juegadores que se posicionen y fortifiquen sus zonas
		Caso especifico para modo de nodos:
			- Radio maximo de base (por parametro)
			- Si se sale alerta
			- pasados los 30 segundos tira mortero

*/

private _pos_inicial = getpos player; // < ------ ver esto de hacer mejor 
private _radio = missionnamespace getvariable ["NSN_VAR_nc_radioCeaseFire",1500];

waitUntil {missionnamespace getvariable ["NSN_VAR_endTime",-1] isNotEqualTo -1};
private _endpreptime = missionNamespace getvariable ["NSN_VAR_EndPrepTime",0];
private _endTiempoDeAltoElFuego = _endpreptime + (["AltoElFuego", 20] call BIS_fnc_getParamValue) * 60;

waitUntil {servertime > _endpreptime};


//hacemos marcador de radio de referencia 
_ceaseFireMK = createMarkerLocal ["ceaseFireMK", _pos_inicial];
_ceaseFireMK   setMarkerSizeLocal [_radio,_radio];
_ceaseFireMk   setMarkerShapelocal "ELLIPSE";
_ceaseFireMk   setMarkerBrushlocal "Border";
_ceaseFireMk   setMarkerColorLocal "colorRed";

//while que se fija que no salga de la zona 
while {servertime < _endTiempoDeAltoElFuego } do {
	sleep 1;
	//Checkeo de que no salgan de la zona 

}; 

//al terminar borra el marcador 
deleteMarkerLocal _ceaseFireMK;







