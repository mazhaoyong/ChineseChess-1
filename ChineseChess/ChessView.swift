//
//  ChessView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 4/25/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit

@IBDesignable
class ChessView: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 1 { didSet { setNeedsDisplay(); board.lineWidth = lineWidth } }
    @IBInspectable
    var color: UIColor = UIColor.black { didSet { setNeedsDisplay(); board.color = color } }
    
    // Board
    public lazy var board: BoardView = self.createBoard()
    
    private func createBoard() -> BoardView {
        let board = BoardView()
        board.isOpaque = false
        board.color = color
        board.lineWidth = lineWidth
        return board
    }

    private func positionBoard(board: BoardView) {
        board.frame = bounds
        board.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    // Pieces
    private lazy var pieces : [PieceView] = self.createPieces()
    
    private func createPieces() -> [PieceView] {
        var ret: [PieceView] = []
        let initialGameStates = Rules.GameStates

        for i in 0...Int(Board.rows) {
            for j in 0...Int(Board.columns) {
                
                if let piece = initialGameStates[i][j] {
                    let player = Board.getTerritoryOwner(row: i)
                    ret.append(PieceView(player, piece, row: i, column: j))
                }
    
            }
        }
        
        return ret
    }
    
    private func positionPiece(piece: PieceView, center: CGPoint) {
        let size = board.gridWidth * 0.9
        piece.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
        piece.center = center
        piece.setRadius(radius: size / 2)
    }
    
    public var pieceViews: [PieceView] {
        return pieces
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
        positionBoard(board: self.board)
        
        let m = board.boardCoordinates
        
        for p in pieces {
            positionPiece(piece: p, center: m[p.row][p.column])
        }
    }
}
