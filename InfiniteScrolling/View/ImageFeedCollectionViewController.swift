//
//  ImageFeedCollectionViewController.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-15.
//
import UIKit

private let reuseIdentifier = "Cell"

protocol ImageFeedCollectionViewControllerDelegate: AnyObject {
    func didSelect(feed: FeedImage, on viewController: ImageFeedCollectionViewController)
}

class ImageFeedCollectionViewController: UICollectionViewController {
    
    var viewModel: FeedImageViewModel!
    weak var delegate: ImageFeedCollectionViewControllerDelegate?
    
    var cellControllers = [CellController]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        viewModel.load()
    }
    
    func configure(viewModel: FeedImageViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupCollectionView() {
        view.backgroundColor = .white
        self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cellControllers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellControllers[indexPath.row].view(for: collectionView, indexpath: indexPath)
        return cell
    }
}


extension ImageFeedCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2 - 3), height: (view.frame.size.height/3 - 3))
    }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // If last cell is about to be displayed, try to fetch extra heroes to present to user
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == cellControllers.count - 1) {
          //  spinner.startAnimating()
            viewModel.load()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(feed: cellControllers[indexPath.row].feed, on: self)
    }
}
