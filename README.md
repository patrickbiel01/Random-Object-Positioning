# Random Object Positioning in a Maze

### Used in the Relic Race App:
Avaialble on the iOS App Store [here](https://apps.apple.com/ca/app/relic-race/id1476996951)

## Abstract: 
Given a player position, an opponent position, and a graph representing the maze, this algorithm finds a spot to place          an object whose position is pseudo-random and whose shortest-path is also a more or less equal distance to both                players.

## Notes
* Time Complexity: O(E + V), where E is edges and V is verticies in a goven graph
* GKGridGraph is a part of Apple's GameKit API
* graph is used to represent a maze. It's creation and usage is detailed [here](https://github.com/patrickbiel01/Maze-Generation)
* tileManger is a instance of a custom class I made that, in short, allows a bunch of Spritekit nodes to be easily accessed as a grid. Source code is available [here](https://github.com/patrickbiel01/TileManager).
* playerPosition and opponentPosition are the on-screen coordinates of 2 players
* The Queue data structure used is available [here](https://github.com/raywenderlich/swift-algorithm-club/blob/master/Breadth-First%20Search/BreadthFirstSearch.playground/Sources/Queue.swift).

## Algorithm Explanation
* Uses a modified breadth first search to create a minimum spanning tree (a mapping of every node and their distance from a source node) for both players
+ These mappings are represented with a 2-D array of verticies and are analyzed to find a node that is: 
    1. Atleast 36 tiles away from each player
    2. Have a similiar shortest path to each player: ± 7
