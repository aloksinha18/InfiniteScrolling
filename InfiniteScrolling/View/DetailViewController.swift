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
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private var dimensionsInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var urlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var downloadURLLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
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
        self.view.addSubview(dimensionsInfoLabel)
        self.view.addSubview(urlLabel)
        self.view.addSubview(downloadURLLabel)

        self.imageView.addSubview(activityView)
        
        NSLayoutConstraint.activate([
            
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.segmentControlTop),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.segmentControlLeading),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.segmentControlTrailing),
            segmentControl.heightAnchor.constraint(equalToConstant: Layout.segmentControlHeight),

            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.imageViewLeading),
            imageView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: Layout.imageViewTop),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.imageViewTrailing),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: Layout.imageViewHeightMultiplier),

            activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.labelLeading),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            dimensionsInfoLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            dimensionsInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.labelLeading),
            dimensionsInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            urlLabel.topAnchor.constraint(equalTo: dimensionsInfoLabel.bottomAnchor),
            urlLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            urlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.labelLeading),
            
            downloadURLLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor),
            downloadURLLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.labelLeading),
            downloadURLLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        segmentControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        authorLabel.text = viewModel.authorName
        dimensionsInfoLabel.text = viewModel.dimensions
        urlLabel.text = viewModel.url
        downloadURLLabel.text = viewModel.downloadURL
        fetchBlurImage()
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            fetchBlurImage()
        case 1:
            fetchGreyScaleImage()
        default:
            fatalError("There are only two cases defined, Please check segment control")
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

extension DetailViewController {
    private enum Layout {
        static let segmentControlTop : CGFloat = 100.0
        static let segmentControlLeading : CGFloat = 8.0
        static let segmentControlTrailing : CGFloat = -8.0
        static let segmentControlHeight : CGFloat = 50.0
        
        static let imageViewTop : CGFloat = 8.0
        static let imageViewLeading : CGFloat = 8.0
        static let imageViewTrailing : CGFloat = -8.0
        static let imageViewHeightMultiplier : CGFloat = 1.3
        
        static let labelLeading: CGFloat = 8.0
    }
}
