/*


*/
#define SUBZONERADIUS 400

params ['_mk',"_bando"];

_pos = getmarkerpos _mk;
_dir = markerdir _mk;


_mk2 = createMarker [ (_mk + "_subzone"), _pos];
_mk2 setMarkerDir _dir;
_mk2 setMarkerSize [SUBZONERADIUS,SUBZONERADIUS];
_mk2 setMarkerAlpha 0.3;
_mk2 setMarkerShape "RECTANGLE";
//_mk2 setmarkerbrush "DiagGrid";
//_mk2 setmarkerColor "colorCivilian";
_mk2


/*
#define SUBZONERADIUS 200

params ['_mk',"_bando"];

_pos = getmarkerpos _mk;
_dir = markerdir _mk;

_candidates = [_pos];
_rp = [
  [-1,1],[0,1],[1,1],
  [-1,0],       [1,0],
  [-1,-1],[0,-1],[1,-1]
  ];

_selected = [];
if (_bando isnotequalto sideUnknown) then {

  {
    _pepe = _pos getpos  [ (SUBZONERADIUS) * (_x select 0) , _dir+90 ];
    _cord = _pepe getpos [ (SUBZONERADIUS) * (_x select 1) , _dir+180 ];
    _candidates pushback _cord;
  }  foreach _rp;

  _h = createHashMap;
  { _h set [ (agltoasl _x) select 2 , _x] } foreach _candidates;
  _maxAltitude = selectmax (keys _h);
  _selected = _h get _maxAltitude;

  _selected = selectrandom _candidates;

}else{
  _selected = _pos;
};


_mk2 = createMarker [ (_mk + "_subzone"), _selected];
_mk2 setMarkerDir _dir;
_mk2 setMarkerSize [SUBZONERADIUS,SUBZONERADIUS];
_mk2 setMarkerAlpha 0.5;
_mk2 setMarkerShape "RECTANGLE";
//_mk2 setmarkerbrush "DiagGrid";
_mk2 setmarkerColor "colorCivilian";

//if ([_mk,opfor] call nsn_fnc_RAB_canCaptureZone && ) then {_mk2 setMarkerAlpha 0.5};


_mk2
