# Random Object Positioning in a Maze

## Abstract: 
Given a player position, an opponent position, and a graph representing the maze, this algorithm finds a spot to place          an object whose position is pseudo-random and whose shortest-path is also a more or less equal distance to both                players.

## Notes
* Time Complexity: O(E + V), where E is edges and V is verticies in a goven graph

## Algorithm Explanation
* Uses a modified breadth first search to create a minimum spanning tree (a mapping of every node and their distance from a source node) for both players
+ These mappings are represented with a 2-D array of verticies and are analyzed to find a node that is: 
    1. Atleast 36 tiles away from each player
    2. Have a similiar shortest path to each player: ± 7
