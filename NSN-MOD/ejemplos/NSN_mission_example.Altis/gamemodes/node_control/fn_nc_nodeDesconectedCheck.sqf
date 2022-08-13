/*

Description:
	Se llama cada vez que se captura un nodo, verifica que todos los nodos tengan conexiones, si no lo tiene, lo descapea 
*/



params ["_nodos"]; 
{
	_node = _x;
	_nodeData = _node getvariable "Data";
	_owner = _nodeData get "owner";
	_nodosVecinos = _nodeData get "connected";
	
	_alMenosUnoAliado = _nodosVecinos findif {
		_nodoVecino = _x;
		_ownerVecino = _nodoVecino getvariable "Data" get "owner";
		_ownerVecino isEqualTo _owner
	};

	if (_alMenosUnoAliado isequalto -1) then { //Lo descapea 
		_mk = _nodeData get "referenceMarker";
		_mk setmarkercolor ("color" + str sideUnknown);
		_nodeData set ["owner",sideUnknown];
		_node setvariable ["Data",_nodeData,true];
	};
}foreach _nodos;