/*
	Descripcion:
		Se fija si es posible capturar ese nodo o no 
	
	input:
		0: nodo (obj)
		1: bando (side)
	return:
		bool

*/

params ["_node","_side"];


_nodeData = _node getvariable "Data";
_nodosVecinos = _nodeData get "connected";

systemchat str ( _nodosVecinos); 
_alMenosUnoAliado = _nodosVecinos findif {
	_nodoVecino = _x;
	_ownerVecino = _nodoVecino getvariable "Data" get "owner";
	_ownerVecino isEqualTo _side
};
_alMenosUnoAliado isnotequalto -1
