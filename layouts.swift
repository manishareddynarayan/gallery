//
//  layouts.swift
//  gallery
//
//  Created by N Manisha Reddy on 2/8/18.
//  Copyright © 2018 N Manisha Reddy. All rights reserved.
//

import UIKit
protocol LayoutDelegate {
    func collectionView(collectionView: UICollectionView,heightForItemAtIndexPath indexPath:NSIndexPath) -> CGFloat
}
class Layouts: UICollectionViewLayout {
    var delegate: LayoutDelegate!
    var numberOfColumns = 2
    private var cache = [UICollectionViewLayoutAttributes]()
    private var height:CGFloat = 0
    private var cellPadding: CGFloat = 3
    private var width:CGFloat {
        get {
let insets = collectionView!.contentInset
            return (collectionView!.bounds.width - (insets.left + insets.right))
        }
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    override func prepare() {
        if cache.isEmpty {
            let coloumnWidth = width / CGFloat(numberOfColumns)
            var xOffSet = [CGFloat]()
            for coloumn in 0..<numberOfColumns {
                xOffSet.append(CGFloat(coloumn) * coloumnWidth)
            }
            var column = 0
            var yOffSet = [CGFloat](repeatElement(0, count: numberOfColumns))

            for index in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = NSIndexPath(item: index, section: 0)
                let coloumnHeight = delegate?.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)
                let colmHeight = cellPadding * 2 + coloumnHeight!
                let frame = CGRect(x: xOffSet[column], y: yOffSet[column], width: coloumnWidth, height: colmHeight)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                attribute.frame = frame
                cache.append(attribute)
                height = max(height, frame.maxY)
                yOffSet[column] = yOffSet[column] + colmHeight
                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            }
            
        }
    
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            let attr = attributes as! UICollectionViewLayoutAttributes
            if (rect.intersects(attributes.frame))
            {
                layoutAttributes.append(attr)
            }
        }
        
        return layoutAttributes
    }
    
}
