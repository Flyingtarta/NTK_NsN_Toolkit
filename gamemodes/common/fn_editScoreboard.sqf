/*



global variable for scoreboard = Marcador


input:
  1: deltaPerSide (hasmap):
      _delta = [
        [opfor , value ],
        [blufor , value]
      ];
*/
params ["_delta"];

{
  _valorAnterior = marcador getOrDefault [_x,0];
  _nuevoValor = _valorAnterior + (_delta get _x);
  marcador set [_x, _nuevoValor];
  publicVariable "marcador";
}foreach _delta;
