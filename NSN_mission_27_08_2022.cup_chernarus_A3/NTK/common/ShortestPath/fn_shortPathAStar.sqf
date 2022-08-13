 /*  
	Author: Sarogahtyp
	Title: SSSP(A) - Sarogahtyps Simple Shortest Path - A*-algorithm
                                                          https://en.wikipedia.org/wiki/A*_search_algorithm

	Description: A*-algorithm - sqf implementation
                     This algorithm is much faster than -Dijkstra algorithm but currently support not more than one floor/layer

	Arguments: Precalculated distances are not supportet here as A* doesn't need more than a few distances. 
	           It would be just senseless to hold all probably needed distances in memory.
         
1.	number - ID of start node

2.  number - ID of end node

3.  array - nodes list - format: [ [ID1, positionASL], [ID2, positionASL], ..., [IDn, positionASL] ]
               ID1-IDn - numbers, ID of the specific node 
			   ID range has to be 0 to n and each ID between 0 and n has to have a node (no leaks)
			   ID may provided unsorted cause they get sorted anyways
		    positionASL - position above sea level

4.  array - connections list - format: [[fromID, toID], [fromID, toID], ..., [fromID, toID]]
            fromID - number, connections start node ID
            toID - number, connections end node ID

   returned nodes array (3.) - array of nodeIDs in order to pass from first (start node) to last (end node) element or
					           boolean false - indicating that input data was not valid
                               boolean true - indicating that there is no possible solution
*/

	
private _correctList = params [ ["_startNode", objNull, [0]],  // numbers allowed only
         ["_endNode", objNull, [0]],    // numbers allowed only
         ["_allNodes", objNull, [ [] ]], // arrays allowed only
         ["_allConnections", objNull, [ [] ]]]; // arrays allowed only



// check for valid parameter data types
if (!_correctList) exitWith {_allNodes = false; false};

//check if first element of _allNodes is an array with exact 2 elements
private _correctNodes = _allNodes params [["_firstElementNodes", objNull, [[]], [2]]];

//check if first element of _allConnections is an array with 3 elements
private _correctConnections = _allConnections params [["_firstElementConnections", objNull, [[]], [2]]];

// exit if at least one of both first elements has wrong format
if (!_correctNodes || !_correctConnections) exitWith {_allNodes = false; false};
// determine arguments 3. and 4. format

private _tempNode = _startNode;
_startNode = _endNode;
_endNode = _tempNode;
_tempNode = nil;

#ifndef SQRT2
 #define SQRT2 1.41421
#endif

//set maximum possible squared distance
private _maxDist = (worldSize * SQRT2)^2;
private _maxDistDoubl = 2 * _maxDist;

// store f-value (heuristic sum) - Predecessor ID - g-value (real sum) - Node ID - Node Position

_allNodes sort true;
private _openList = [[0, _maxDist, 0, (_allNodes select _startNode select 0)]]; 

private _closedList = [];
private _currentNode = _maxDist;

// define a name for the script scope to be able to break all loops
scopeName "main";
_solutionFound = false;

while {true} do
{
 private _shortestHeuristic = _maxDistDoubl;
 private _shortestReal = _maxDist;
 
 // get node with best f-value (heuristic sum)
 {
  if ((_x select 0) < _shortestHeuristic) then 
  {
   _shortestHeuristic = _x select 0;
   _currentNode = _x;
  };
 } count _openList;
 
 private _openNum = count _openList;
 
 //if the open list is empty then break all scopes - no solution possible
 if (_openNum isEqualTo 0) then {breakTo "main"};

 private _currID = _currentNode select 3;
 
 //delete current Node from open list and add it to closed list
 //_openList = _openList - _currentNode;
 
 _d = _openList deleteAt (_openList findIf {(_x select 3) isEqualTo _currID});
 
 _closedList pushBack [(_currentNode select 3), (_currentNode select 1)];
 
 // break to script scope if solution is found
 if (_currID isEqualTo _endNode) then
 {
  _solutionFound = true;
  breakTo "main";    //breaks all scopes except main scope
 };
 
 //get all connections to all neighbors of current node
 _neighbConns = _allConnections select
 {
  (_x select 0 isEqualTo _currID) || (_x select 1 isEqualTo _currID)
 };

 //get all neighbors of current node which are not on closed list
 _neighbNodes = _allNodes select
 {
  private _neighbID = _x select 0;
   ((_closedList findIf {(_x select 0) isEqualTo _neighbID} isEqualTo -1) && 
   (_neighbConns findIf {(_x select 0) isEqualTo _neighbID || (_x select 1) isEqualTo _neighbID} > -1))
 };
 
 {
  private _neighbID = _x select 0;

  _tentative_g = (_currentNode select 2) + ((_allNodes select _currID select 1) distanceSqr (_allNodes select _neighbID select 1));
  _neighInOListIndex = _openList findIf {(_x select 3) isEqualTo _neighbID};
  _heurDist = (_allNodes select _endNode select 1) distanceSqr (_allNodes select _neighbID select 1);

  if (_neighInOListIndex > -1) then
  {
   if (_tentative_g < (_openList select _neighInOListIndex select 2)) then
   {
    _d = _openList set [_neighInOListIndex, [(_tentative_g + _heurDist), _currID, _tentative_g, _neighbID]];
   };
  }
  else
  {
   _d = _openList pushBack [(_tentative_g + _heurDist), _currID, _tentative_g, _neighbID];
  };
 } count _neighbNodes;
};

//exit if there is no solution for the given nodes/connections set to get from start node to end node
if (!_solutionFound) exitWith {_allNodes = true; true};

// build solution path array from end node to start node

private _currNodeIndex = _closedList findIf {(_x select 0) isEqualTo _endNode};
private _currNode = _closedList select _currNodeIndex;

_allNodes resize 0;

_allNodes pushBack (_currNode select 0);

while {!((_currNode select 0) isEqualTo _startNode)} do
{
 _currNodeIndex = _closedList findIf {(_x select 0) isEqualTo (_currNode select 1)};
 _currNode = _closedList select _currNodeIndex;
 
 //current nodes ID is part of solution
 _allNodes pushBack (_currNode select 0);
};

_allNodes