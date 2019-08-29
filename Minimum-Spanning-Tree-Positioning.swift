    //MARK:- Minimum Spanning Tree
    /* Set trophy random position
     Use breath-first search twice to make a shortest path mapping of every vertex from both players
     Compare the 2 maps to find tiles that are:
        1. Atleast 36 tiles away from each player
        2. Have a similiar length: ± 7
     */
    func MSTBasedFairPosition(
        graph: GKGridGraph<GKGridGraphNode>,
        tileManager: TileManager,
        playerPosition: CGPoint,
        opponentPosition: CGPoint
    ) {
        //Get Player Pos
        let playerPosGrid = tileManager.indexFrom(position: playerPosition)
        //Convert 2-D mapping to 1-D
        let playerPos = playerPosGrid.row*Maze.MAX_COLUMNS + playerPosGrid.column
        //Get map of all distances
        let mappedDist1 = distances(from: playerPos, using: graph)
        
        //Repeat for opponent
        let oppPosGrid = tileManager.indexFrom(position: opponentPosition)
        let oppPos = oppPosGrid.row*Maze.MAX_COLUMNS + oppPosGrid.column
        let mappedDist2 = distances(from: oppPos, using: graph)
        
        var viableTile = [GridPosition]()
        //Compare each mapping to find ideal tile for trophy placement
        for y in 0..<mappedDist1.count {
            for x in 0..<mappedDist1[y].count {
                let MIN_LENGTH_OT = mappedDist2[y][x] > 36
                let MIN_LENGTH_PT = mappedDist1[y][x] > 36
                let SIMILIAR_LENTH =  mappedDist2[y][x] + 7 >= mappedDist1[y][x] && mappedDist2[y][x] - 7 <= mappedDist1[y][x]
                
                if MIN_LENGTH_OT && MIN_LENGTH_PT && SIMILIAR_LENTH {
                    viableTile.append(GridPosition(column: x, row: y))
                }
            }
        }
        if viableTile.isEmpty {
            
            //
            //Default value
            //
            object.position = CGPoint.zero
            
            return
        }
        
        let randPos = viableTile.randomElement()!
        let tile = tileManager.getTile(row: randPos.row, column: randPos.column)
        
        //
        //  object represents Object that is going to be randomly positioned
        //
        object.position = tile.position
        
    }
    /*
     Patrick's alogrithm that uses a breath-first search to efficiently ( O(|E| + |V|) ) to create a minimum spanning tree (or in other words, a mapping showing distances to every node from a source node)
     */
    func distances(from src: Int, using graph: GKGridGraph<GKGridGraphNode>) -> [[Int]] {
        //Creating Queue
        var queue = Queue<GKGridGraphNode>()
        let srcNode = graph.nodes![src] as! GKGridGraphNode
        let srcPos = GridPosition(from: srcNode.gridPosition)
        queue.enqueue(srcNode)

        //Visited Array for Breath-first search
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: Maze.MAX_COLUMNS), count: Maze.MAX_ROWS)
        visited[srcPos.row][srcPos.column] = true
        
        //Array to track final distances
        var dist = [[Int]](repeating: [Int](repeating: -1, count: Maze.MAX_COLUMNS), count: Maze.MAX_ROWS)
        dist[srcPos.row][srcPos.column] = 0
        
        //Search
        while let rootNode = queue.dequeue() {
            for neighbour in rootNode.connectedNodes {
                let neighbourNode = neighbour as! GKGridGraphNode
                let neighbourPos = GridPosition(from: neighbourNode.gridPosition)
                if !visited[neighbourPos.row][neighbourPos.column] {
                    queue.enqueue(neighbourNode)
                    let rootPos = GridPosition(from: rootNode.gridPosition)
                    dist[neighbourPos.row][neighbourPos.column] = dist[rootPos.row][rootPos.column] + 1
                    visited[neighbourPos.row][neighbourPos.column] = true
                }
            }
        }
        
        return dist
    }
}
