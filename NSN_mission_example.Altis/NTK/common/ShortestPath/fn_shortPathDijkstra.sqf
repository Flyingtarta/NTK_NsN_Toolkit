/*  
	Author: Sarogahtyp
	Title: SSSP(D) - Sarogahtyps Simple Shortest Path - Dijkstra algorithm
                                                          https://en.wikipedia.org/wiki/Dijkstra

	Description: Dijkstra-algorithm - sqf implementation
                     This algorithm is much more time consuming than A* algorithm if only 1 floor is necessary
                     if multiple floors are needed then it has to be tested if A* (multiple floor solution) is faster or not

	Arguments:
        if you use alternative format at 3. then you have to use alternative format at 4 as well and vice versa
        if you have precalculated distances (maybe at mission start) for 4. then alternative format is faster
         
1.	number - ID of start node

2.  number - ID of end node

3.  array - nodes list - format: [ [ID1, positionASL], [ID2, positionASL], ..., [IDn, positionASL] ]
               ID1-IDn - numbers, ID of the specific node 
			   ID range has to be 0 to n and each ID between 0 and n has to have a node (no leaks)
			   ID may provided unsorted cause they get sorted anyways
		    positionASL - position above sea level

     format(alternative, faster): [ ID1, ID2, ..., IDn ]

4.  array - connections list - format: [[fromID, toID], [fromID, toID], ..., [fromID, toID]]
            fromID - number, connections start node ID
            toID - number, connections end node ID

         format (alternative, faster): [[distance, fromID, toID], [distance, fromID, toID], ..., [distance, fromID, toID]]
                                       distance can be any distance format you prefer (distance, distanceSqr, distance2D may be worse with multiple floors)

   returned nodes array (3.) - array of nodeIDs in order to pass from first (start node) to last (end node) element or
					           boolean false - indicating that input data was not valid
                               boolean true - indicating that there is no possible solution
*/

private _correctList = params [ ["_startNode", objNull, [0]],  // numbers allowed only
         ["_endNode", objNull, [0]],    // numbers allowed only
         ["_allNodes", objNull, [ [] ]], // arrays allowed only
         ["_allConnections", objNull, [ [] ]], // arrays allowed only
		  "_oneway" ];

// check for valid parameter data types
if (!_correctList) exitWith {_allNodes = false; false};

//check if first element of _allNodes is number or array and if it is array then with exact 2 elements
private _correctNodes = _allNodes params [["_firstElementNodes", objNull, [0, []], [2]]];

//check if first element of _allConnections is an array and if it has 2 or 3 elements
private _correctConnections = _allConnections params [["_firstElementConnections", objNull, [[]], [2, 3]]];

// exit if at least one of both first elements has wrong format
if (!_correctNodes || !_correctConnections) exitWith {_allNodes = false; false};
// determine arguments 3. and 4. format
private _alternativeFormat = count _firstElementConnections isEqualTo 3;

private _solution = [];
private _sqrt2 = 1.41421;

//set maximum possible squared distance
private _maxDist = (worldSize * _sqrt2)^2;

// interchange start and end node
private _tempNode = _startNode;
_startNode = _endNode;
_endNode = _tempNode;
_tempNode = nil;

//ensures that ID is the same as the array index of each element 
_allNodes sort true;
 
if (!_alternativeFormat) then
{
 // calculate distances and insert as first element of each connection
 _allConnections = _allConnections apply 
 {
  private  _fromID = _x select 0;
  private  _toID = _x select 1;
  private _dist = ((_allNodes select _fromID) select 1) distanceSqr ((_allNodes select _toID) select 1);
  [_dist, _fromID, _toID]
 };
};

// insert distance to start value, predecessor node ID and already viewed state for each node.
// delete positions as not needed anymore
{
 private  _nodeID = if(typeName _x isEqualTo "ARRAY") then {_x select 0} else {_x};
 private  _dist = if(_nodeID isEqualTo _startNode) then {0} else {_maxDist};
 _allNodes set [_forEachIndex, [_dist, _maxDist, false, _nodeID]];
} forEach _allNodes;

private _solutionFound = false;

// define a name for the script scope to be able to break all loops
scopeName "main";

while {true} do
{
 // select node with shortest distance value (_allNodes is sortet ascending by distance)
 private _shortest = _maxDist;
 private _currentNode= [];

 {
  if (!(_x select 2) && {(_x select 0) < _shortest}) then 
  {
   _shortest = _x select 0;
   _currentNode = _x;
  };
 } count _allNodes;
 
 //if there is no unviewed node then break all scopes - no solution possible
 if (_currentNode isEqualTo []) then {breakTo "main"};
 
 private _currID = _currentNode select 3;
 
 // change viewed state of current node to true
 _currentNode set [2, true];

 //get all connections to all neighbors of current node
 private _neighbConns = _allConnections select
 {
  (_x select 1 isEqualTo _currID) || (_x select 2 isEqualTo _currID)
 };

 //get all not viewed neighbors of current node
 _neighbNodes = _allNodes select
 {
  private _neighbID = _x select 3;
  (!(_x select 2) && (_neighbConns findIf {(_x select 1 isEqualTo _neighbID) || (_x select 2 isEqualTo _neighbID)} > -1))
 };
 
 //process all neighbor nodes of current node
 {
  private _neighbID = _x select 3;
  
  // find the index of the connection between current node and this neighbor node
  // get distance value of the connection
   
  private _thisDist = (_currentNode select 0) + ((_neighbConns select (_neighbConns findIf {_neighbID isEqualTo (_x select 1) || _neighbID isEqualTo (_x select 2)})) select 0);
  
  // if we found a shorter distance then set current node as predecessor of this neighbor node and update the found distance for it
  if ( (_x select 0) > _thisDist ) then
  {
   _x set [0, _thisDist];
   _x set [1, _currID];
  
   //check if this neighbor is the end node
   if (_neighbID isEqualTo _endNode) then
   {
    _solutionFound = true;

	breakTo "main";    //breaks all scopes except main scope
   };
  };
 } count _neighbNodes;
};

//exit if there is no solution for the given nodes/connections set to get from start node to end node
if (!_solutionFound) exitWith {_allNodes = true; true};

{
 _allNodes set [_forEachIndex, [(_x select 3), (_x select 1)]];
} forEach _allNodes;

_allNodes sort true;

// build solution path array from end node to start node
private _currNode = _allNodes select _endNode;

while {!((_currNode select 0) isEqualTo _startNode)} do
{
 //current nodes ID is part of solution
 _solution pushBack (_currNode select 0);
 
 //next current node is predecessor of actual current node
 _currNode = _allNodes select (_currNode select 1);
};

private _d = _solution pushBack _startNode;

_allNodes resize 0;

{
 private _d = _allNodes pushBack _x;
} count _solution;

_solution