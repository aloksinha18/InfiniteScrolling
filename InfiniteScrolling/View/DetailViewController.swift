//
//  DetailViewController.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-17.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    private var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Blurr","GrayScale"])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedSegmentIndex = 0
        return view
    }()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
    }
    
    private func setupViews() {
        self.view.addSubview(segmentControl)
        self.view.addSubview(imageView)
        self.view.addSubview(authorLabel)

        self.imageView.addSubview(activityView)
        
        NSLayoutConstraint.activate([
            
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentControl.heightAnchor.constraint(equalToConstant: 50.0),

            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),

            activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        segmentControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        self.authorLabel.text = "Author: \(viewModel.authorName)"
        fetchBlurImage()
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            fetchBlurImage()
        case 1:
            fetchGreyScaleImage()
        default:
            fatalError("There are only two cases defined")
        }
    }
    
    private func fetchBlurImage() {
        imageView.image = nil
        activityView.startAnimating()
        viewModel.loadBlurImage { image in
            self.imageView.image  = image
            self.activityView.stopAnimating()
        }
    }
    
    private func fetchGreyScaleImage() {
        imageView.image = nil
        activityView.startAnimating()
        viewModel.loadGrayScaleImage { image in
            self.imageView.image  = image
            self.activityView.stopAnimating()
        }
    }
}
