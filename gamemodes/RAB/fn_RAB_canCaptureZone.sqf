/*
Verifica que un vecino sea capturable

*/


params ["_mk","_bandoDom"];

private _grid = call compile _mk;
_grid params ["_ejex","_ejey"];
_relativos = [[1,0],[0,1],[-1,0],[0,-1]];

private _canCapture = _relativos findif  {
  _vecino = str((_grid vectoradd _x) select [0,2]);
  _data = missionnamespace getvariable _vecino;
  if (!isnil {_data}) then {
    (_data get "bando") isequalto _bandoDom
  }else{
    false
  };
};

(_canCapture isNotEqualTo -1)
