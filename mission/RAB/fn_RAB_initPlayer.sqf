/*

  - Verifica que no se salga del area
  - Agrega effecto si se sale del area
  - UI

*/
systemchat str "RAB | initPlayer...ok!";
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{

  _zonasCapturables = zonas select {
    _bando = (missionNamespace getVariable _x) get "bando";
    _bando isNotEqualTo (side player)
  };


  {
    _canCapture = [_x,side player] call NSN_FNC_RAB_canCaptureZone;
    if (_canCapture) then {
      _zona = _x;
      _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
      _alpha = linearconversion [0.1,0.5,_scale,0,1,false];
      (_this#0) drawicon [
          "\a3\ui_f\data\igui\cfg\simpletasks\types\attack_ca.paa",
          [1,1,1,_alpha],
          getmarkerpos _zona,
          10/_scale,
          10/_scale,
          markerDir _zona
      ];
    };
  } foreach _zonasCapturables;

}];
