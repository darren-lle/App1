//
//  ImageTextTableViewCell.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

class ImageTextCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var cardContainerInnerView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardContainerView.layer.borderWidth = 1
        cardContainerView.layer.borderColor = UIColor.gray.cgColor
        cardContainerView.layer.cornerRadius = 15
        cardContainerInnerView.clipsToBounds = true
        cardContainerInnerView.layer.cornerRadius = 15
        cardContainerInnerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        cardContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        cardContainerView.layer.shadowRadius = 6
        cardContainerView.layer.shadowOffset = .zero
        cardContainerView.layer.shadowOpacity = 1
    }
    
    func display(_ item: Rewards) {
        itemTitleLabel.text = item.name
        progressIndicatorView.startAnimating()
        itemImageView.isHidden = true
        
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            
            if let url = URL(string: item.image),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)  {
                
                DispatchQueue.main.async {
                    self?.itemImageView.image = image
                    self?.itemImageView.isHidden = false
                    self?.progressIndicatorView.stopAnimating()
                    self?.cardContainerView.layoutIfNeeded()
                }
            }
        }
    }
    
}

