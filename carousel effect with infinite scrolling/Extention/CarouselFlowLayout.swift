//
//  CarouselFlowLayout.swift
//  carousel effect with infinite scrolling
//
//  Created by Atik Hasan on 7/6/25.
//

import UIKit

class CarouselFlowLayout: UICollectionViewFlowLayout {
    let scaleFactor: CGFloat = 0.6

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 20
        guard let collectionView = collectionView else { return }

        let width = collectionView.bounds.width * 0.6
        let height = collectionView.bounds.height * 0.8
        itemSize = CGSize(width: width, height: height)

        let inset = (collectionView.bounds.width - width) / 2
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }

        guard let collectionView = collectionView else { return attributes }

        let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2

        attributes?.forEach { attribute in
            let distance = abs(attribute.center.x - centerX)
            let normalizedDistance = distance / collectionView.bounds.width
            let scale = 1 - (1 - scaleFactor) * normalizedDistance
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
        }

        return attributes
    }
}
