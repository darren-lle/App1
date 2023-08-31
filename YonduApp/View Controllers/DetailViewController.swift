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
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    
    private var item: Rewards?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareShareButton()
        displayItemDetails()
        loading(false)
    }
    
    func set(_ item: Rewards?) {
        self.item = item
    }

}

private extension DetailViewController {
    
    func prepareShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
    }
    
    func loading(_ loading: Bool) {
        UIView.animate(withDuration: 0.5) {[weak self] in
            self?.view.isUserInteractionEnabled = !loading
            self?.loadingView.isHidden = !loading
            loading ? self?.progressIndicatorView.startAnimating() : self?.progressIndicatorView.stopAnimating()
        }
    }
    
    func displayItemDetails() {
        guard let item = item else { return }
        
        itemTitleLabel.text = item.name
        itemMoreDetailsTextView.text = item.description
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
                }
            }
        }
    }
}

extension DetailViewController {
    @objc func share(sender: UIView) {
        loading(true)
        
        guard let image = itemImageView.image else { return }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            let shareText = "Share this reward"
            var activityVC: UIActivityViewController?
            
            if let myWebsite = URL(string: self?.item?.image ?? "www.google.com") {
                let objectsToShare = [shareText, myWebsite, image] as [Any]
                activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            }
            
            DispatchQueue.main.async {
                if let activityVC = activityVC {
                    activityVC.popoverPresentationController?.sourceView = sender
                    self?.present(activityVC, animated: true, completion: nil)
                }
                
                self?.loading(false)
            }
        }
    }
        
}
