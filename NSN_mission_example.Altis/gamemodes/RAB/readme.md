##NSN_RAB_AREAS

Variable que guarda todos los sectores en formato "[ x_relativo , y_relativo ]" 
con su respectiva subarea "[ x_relativo , y_relativo ]_sub" 

##Hasmap con la informacion del area:
    _data = missionnamespace getvariable <marcador>

    _data = {
        "bando"   : SIDE (bando dueño del sector )
        "subArea" : < marcador de subarea > (marcador de subarea capturable )
        "base"    : BOOL ( si es un sector base)
    }


