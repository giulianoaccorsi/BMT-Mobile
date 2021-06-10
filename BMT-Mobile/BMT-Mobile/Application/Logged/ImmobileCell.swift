//
//  ImmobileCell.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//


import UIKit
import Kingfisher

class ImmobileCell: UITableViewCell {
    
    var viewBackgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 10/2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        title.textColor = .background
        return title
    }()
    
    let houseUIImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let overview = UILabel(frame: .zero)
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 13)
        overview.textColor = .background2
        return overview
    }()
    
    
    func setupCell(immobile: Immobile) {
        setUpView()
        titleLabel.text = immobile.title
        let url = URL(string: immobile.imgURL)
        houseUIImageView.kf.setImage(with: url)
        descriptionLabel.text = immobile.itemDescription
    }
    
    
}

extension ImmobileCell: ViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(viewBackgroundCell)
        self.viewBackgroundCell.addSubview(houseUIImageView)
        self.viewBackgroundCell.addSubview(titleLabel)
        self.viewBackgroundCell.addSubview(descriptionLabel)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            viewBackgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            viewBackgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            viewBackgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            viewBackgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            viewBackgroundCell.heightAnchor.constraint(equalToConstant: 150),
            
            houseUIImageView.leadingAnchor.constraint(equalTo: viewBackgroundCell.leadingAnchor),
            houseUIImageView.topAnchor.constraint(equalTo: viewBackgroundCell.topAnchor),
            houseUIImageView.bottomAnchor.constraint(equalTo: viewBackgroundCell.bottomAnchor),
            houseUIImageView.widthAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: houseUIImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: houseUIImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: viewBackgroundCell.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
//            descriptionLabel.bottomAnchor.constraint(equalTo: viewBackgroundCell.bottomAnchor, constant: -8)
            
        ])
        
    }
    
    func setUpAdditionalConfiguration() {
    
        self.backgroundColor = .white
    }
    
    
}
