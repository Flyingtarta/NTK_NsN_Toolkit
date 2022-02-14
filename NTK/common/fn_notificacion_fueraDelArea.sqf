/*
Descripcion:
  Mensaje de que esta fuera del area permitida
*/



disableSerialization;
cutRsc ["rcsNotificacion","PLAIN"];
_display = uiNamespace getvariable 'rcsNotificacion_idd';

(allControls _display) params [
  "_fondo", //text
  "_content",//RscStructuredText
  "_leftImg", //img
  "_rightImg", //img
  "_Titulo" //text
];
//imagenes
//_leftImg ctrlsettext "\a3\Ui_f\data\IGUI\Cfg\Actions\take_ca.paa";
//_rightImg ctrlsettext "\a3\Ui_f\data\IGUI\Cfg\Actions\take_ca.paa";
_leftImg ctrlsettext "\A3\ui_f\data\map\markers\military\warning_CA.paa";
_rightImg ctrlsettext "\A3\ui_f\data\map\markers\military\warning_CA.paa";


_leftImg ctrlSetTextColor [1,0.2,0.2,1];
_rightImg ctrlSetTextColor [1,0.2,0.2,1];

_titulo ctrlSetText "TE SALISTE DEL AREA DE OPERACIONES";
//_content ctrlSetStructuredText (composeText ["Volve al area de operaciones:",lineBreak,str ( 20 - (localnamespace getvariable ["advertencia",0]) ) ]);
_countDown = str ( 31 - (localnamespace getvariable ["advertencia",0]));
_content ctrlSetStructuredText (parseText (format ["<t size='1.5' align='center' valign='center' > Volve al area: %1 <\t>",_countDown] )); //format ["<t size='1'> Volve al area: %1 <\t>",_countDown] );
_content ctrlSetTextColor [1,0.2,0.2,1];
