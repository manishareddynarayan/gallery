//
//  ViewController.swift
//  gallery
//
//  Created by N Manisha Reddy on 2/2/18.
//  Copyright © 2018 N Manisha Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    let array:[String] = ["https://cdn.pixabay.com/photo/2017/06/14/23/15/soap-bubble-2403673_960_720.jpg","https://cdn.pixabay.com/photo/2017/06/14/23/15/soap-bubble-2403673_960_720.jpg","https://farm5.staticflickr.com/4451/37165306804_ed273f1e8c_b.jpg","https://farm5.staticflickr.com/4451/37165306804_ed273f1e8c_b.jpg","https://farm5.staticflickr.com/4451/37165306804_ed273f1e8c_b.jpg","https://farm5.staticflickr.com/4451/37165306804_ed273f1e8c_b.jpg,https://cdn.pixabay.com/photo/2017/06/14/23/15/soap-bubble-2403673_960_720.jpg","https://cdn.pixabay.com/photo/2017/06/14/23/15/soap-bubble-2403673_960_720.jpg","https://farm5.staticflickr.com/4451/37165306804_ed273f1e8c_b.jpg","https://farm5.staticflickr.com/4451/37165306804_ed273f1e8c_b.jpg","https://farm5.staticflickr.com/4451/37165306804_ed273f1e8c_b.jpg","https://farm5.staticflickr.com/4451/37165306804_ed273f1e8c_b.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let imageSize = UIScreen.main.bounds.width/3 - 3
        var layout = collectionView?.collectionViewLayout as! Layouts
        layout.delegate = self
        layout.numberOfColumns = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! viewCell
        
        let myString = array[indexPath.row]
        
        let imageUrl:URL = URL(string: myString)!
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell.imageView.image = image
            }
        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedVideo = collectionView.cellForItem(at: indexPath)
        selectedVideo?.alpha = 0.8
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselectedVideo = collectionView.cellForItem(at: indexPath)
        deselectedVideo?.alpha = 1.0
    }
}
extension ViewController: LayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random * 100)

    }


}


