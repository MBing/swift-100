//
//  ViewController.swift
//  StormViewer
//
//  Created by Martin Demiddel on 31.03.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // When you want to get only the suffix of the String
//                var itemText = item
//                if let index =  item.firstIndex(of: "l") {
//                    itemText = String(item.suffix(from: index))
//                }
                // we only need the numbers in the String, so this is how we do it
                 let itemText = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                let picture = Picture(name: itemText, image: item)
                pictures.append(picture)
            }
        }
        // perform an ASC sort on the current Array (will not create a new one!)
        pictures.sort(by: { $0.name < $1.name })
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Storm", for: indexPath) as? StormCell else { fatalError("Could not dequeue cell to Storm Cell") }
        let picture = pictures[indexPath.item]
        cell.name.text = picture.name
        cell.imageView.image = UIImage(named: picture.image)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.totalPictures = pictures.count
            vc.currentPicture = indexPath.row + 1
            vc.selectedImage = pictures[indexPath.item].image
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

