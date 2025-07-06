//
//  ViewController.swift
//  carousel effect with infinite scrolling
//
//  Created by Atik Hasan on 7/6/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    var images = ["img1","img2","img3","img4","img5","img6","img7"]
    var infiniteImages: [String] = []
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<50 {
            infiniteImages.append(contentsOf: images)
        }
        self.setUpCV()
    }
    
    func setUpCV(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.decelerationRate = .fast
        collectionView.isUserInteractionEnabled = false
        collectionView.collectionViewLayout = CarouselFlowLayout()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        let middle = infiniteImages.count / 2
        collectionView.scrollToItem(at: IndexPath(item: middle, section: 0), at: .centeredHorizontally, animated: false)
        
        startAutoScroll()
        self.collectionView.reloadData()
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(scrollNext), userInfo: nil, repeats: true)
    }
    
    @objc func scrollNext() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let currentOffset = collectionView.contentOffset.x
        let pageWidth = layout.itemSize.width + layout.minimumLineSpacing
        let nextOffset = currentOffset + pageWidth

        let maxOffset = collectionView.contentSize.width - collectionView.bounds.width

        if nextOffset >= maxOffset {
            // Scroll মাঝখানে reset করো
            let middleIndex = infiniteImages.count / 2
            collectionView.scrollToItem(at: IndexPath(item: middleIndex, section: 0), at: .centeredHorizontally, animated: false)
        } else {
            // Smooth scroll to next
            collectionView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
        }
        self.collectionView.layoutIfNeeded()
    }

    
    deinit {
        timer?.invalidate()
    }
    
}


extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infiniteImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imgView.image = UIImage(named: infiniteImages[indexPath.item])
        return cell
    }

}

