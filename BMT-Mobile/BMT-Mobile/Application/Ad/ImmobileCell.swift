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
    
    var barUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let houseUIImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let stateCityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }()
    
    let districtLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = .black
        return title
    }()
    
    let addressLabel: UILabel = {
        let overview = UILabel(frame: .zero)
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 12)
        overview.textColor = .black
        return overview
    }()
    
    let telephoneLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 12.0)
        title.textColor = .black
        return title
    }()
    
    var descriptionBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundLightGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner ]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let overview = UILabel(frame: .zero)
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 12)
        overview.textColor = .black
        return overview
    }()
    
    let priceLabel: UILabel = {
        let overview = UILabel(frame: .zero)
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 17)
        overview.textColor = .black
        return overview
    }()
    
    
    func setupCell(immobile: Immobile) {
        setUpView()
        let url = URL(string: immobile.imgURL)
        houseUIImageView.kf.setImage(with: url)
        
        priceLabel.text = "R$ \(immobile.price)"
        descriptionLabel.text = immobile.itemDescription
        stateCityLabel.text = "\(immobile.state ?? "") - \(immobile.city ?? "")"
        districtLabel.text = immobile.district
        addressLabel.text = immobile.address
        telephoneLabel.text = immobile.telephone 
    }
    
    
}

extension ImmobileCell: ViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(viewBackgroundCell)
        self.viewBackgroundCell.addSubview(houseUIImageView)
        self.viewBackgroundCell.addSubview(barUIView)
        self.viewBackgroundCell.addSubview(stateCityLabel)
        self.viewBackgroundCell.addSubview(districtLabel)
        self.viewBackgroundCell.addSubview(addressLabel)
        self.viewBackgroundCell.addSubview(telephoneLabel)
        self.viewBackgroundCell.addSubview(descriptionBackgroundView)
        self.descriptionBackgroundView.addSubview(descriptionLabel)
        self.viewBackgroundCell.addSubview(priceLabel)
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            viewBackgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            viewBackgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            viewBackgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            viewBackgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            houseUIImageView.leadingAnchor.constraint(equalTo: viewBackgroundCell.leadingAnchor),
            houseUIImageView.topAnchor.constraint(equalTo: viewBackgroundCell.topAnchor),
            houseUIImageView.trailingAnchor.constraint(equalTo: viewBackgroundCell.trailingAnchor),
            houseUIImageView.heightAnchor.constraint(equalToConstant: 150),
            houseUIImageView.widthAnchor.constraint(equalToConstant: 150),
            
            barUIView.topAnchor.constraint(equalTo: viewBackgroundCell.topAnchor),
            barUIView.bottomAnchor.constraint(equalTo: viewBackgroundCell.bottomAnchor),
            barUIView.trailingAnchor.constraint(equalTo: viewBackgroundCell.trailingAnchor),
            barUIView.widthAnchor.constraint(equalToConstant: 30),
            
            priceLabel.topAnchor.constraint(equalTo: houseUIImageView.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: barUIView.leadingAnchor, constant: -4),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionBackgroundView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            descriptionBackgroundView.bottomAnchor.constraint(equalTo: viewBackgroundCell.bottomAnchor, constant: -16),
            descriptionBackgroundView.trailingAnchor.constraint(equalTo: viewBackgroundCell.trailingAnchor),
            descriptionBackgroundView.widthAnchor.constraint(equalToConstant: 200),
            descriptionBackgroundView.heightAnchor.constraint(equalToConstant: 80),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionBackgroundView.topAnchor, constant: 4),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionBackgroundView.bottomAnchor, constant: -4),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionBackgroundView.leadingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionBackgroundView.trailingAnchor, constant: -4),
            
            stateCityLabel.topAnchor.constraint(equalTo: houseUIImageView.bottomAnchor, constant: 8),
            stateCityLabel.leadingAnchor.constraint(equalTo: houseUIImageView.leadingAnchor, constant: 4),
            stateCityLabel.trailingAnchor.constraint(equalTo: descriptionBackgroundView.leadingAnchor, constant: -4),
            stateCityLabel.heightAnchor.constraint(equalToConstant: 40),
            
            districtLabel.topAnchor.constraint(equalTo: stateCityLabel.bottomAnchor, constant: 4),
            districtLabel.leadingAnchor.constraint(equalTo: stateCityLabel.leadingAnchor),
            districtLabel.trailingAnchor.constraint(equalTo: stateCityLabel.trailingAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: districtLabel.bottomAnchor, constant: 4),
            addressLabel.leadingAnchor.constraint(equalTo: stateCityLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: stateCityLabel.trailingAnchor),
            
            telephoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4),
            telephoneLabel.leadingAnchor.constraint(equalTo: stateCityLabel.leadingAnchor),
            telephoneLabel.trailingAnchor.constraint(equalTo: stateCityLabel.trailingAnchor),
            telephoneLabel.bottomAnchor.constraint(equalTo: viewBackgroundCell.bottomAnchor, constant: -8)
        ])
        
    }
    
    func setUpAdditionalConfiguration() {
    
        self.backgroundColor = .clear
    }
    
    
}
