//
//  DetailViewController.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemMoreDetailsTextView: UITextView!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    private var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareShareButton()
        displayItemDetails()
    }
    
    func set(_ item: Item?) {
        self.item = item
    }

}

private extension DetailViewController {
    
    func prepareShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
    }
    
    func displayItemDetails() {
        guard let item = item else { return }
        
        itemTitleLabel.text = item.title
        itemMoreDetailsTextView.text = item.moreDetails
        progressIndicatorView.startAnimating()
        itemImageView.isHidden = true
        
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            
            if let url = URL(string: item.imageURL),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)  {
                
                DispatchQueue.main.async {
                    self?.itemImageView.image = image
                    self?.itemImageView.isHidden = false
                    self?.progressIndicatorView.stopAnimating()
                }
            }
        }
    }
}

extension DetailViewController {
    @objc func share(sender: UIView) {
        let shareText = "Share this reward"
        
        guard let image = itemImageView.image else { return }
        
        if let myWebsite = URL(string: "http://www.google.com") {
            let objectsToShare = [shareText, myWebsite, image] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
            
        }
    }
}
