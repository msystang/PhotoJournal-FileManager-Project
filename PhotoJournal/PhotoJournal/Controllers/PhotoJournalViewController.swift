//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/2/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class PhotoJournalViewController: UIViewController {

    @IBOutlet weak var photoJournalCollectionView: UICollectionView!
    
    var photoJournal = [PhotoJournal]() {
        didSet {
            photoJournalCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPhotoJournal()
    }

    private func configureCollectionView() {
        photoJournalCollectionView.delegate = self
        photoJournalCollectionView.dataSource = self
    }
    
    private func loadPhotoJournal() {
        do {
            photoJournal = try PhotoPersistenceHelper.manager.getPhotoJournal()
        } catch {
            print(error)
        }
    }

}

extension PhotoJournalViewController: UICollectionViewDelegate {}

extension PhotoJournalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoJournal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoJournalCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoJournalCollectionViewCell
        let currentPhotoEntry = photoJournal[indexPath.row]
        
        cell.photoImageView.image = UIImage(data: currentPhotoEntry.photoData)
        cell.titleLabel.text = currentPhotoEntry.title
        cell.dateLabel.text = currentPhotoEntry.date
        
        return cell
    }
    
    
}
