//
//  UrlCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/18/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

class UrlCell: UITableViewCell, Colorable {
    
//    @IBOutlet weak var urlLabel: UILabel?
    @IBOutlet weak var linkButton: UIButton?
    
    @IBOutlet weak var urlTextField: UITextField?
    
    let applyColor = DefaultStyle()
    
    var item: CheckoutViewModelItem? {
        didSet {
            guard let item = item as? CheckoutViewModelUrl else { return }
            
            urlTextField?.text = item.url
            
            urlTextField?.isEnabled = false
            
            
            
            urlTextField?.attributedText = findHttpsRange(string: item.url)
            
            backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
            
            let image = UIImage(named: "link")
            linkButton?.setImage(image?.withTintColor(.blue, renderingMode: .alwaysTemplate), for: .normal)
            linkButton?.isHidden = ValidUrl.urlIsValid(urlString: item.url) ? false : true
        }
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        urlTextField?.text = ""
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        UIMenuController.shared.menuItems = [UIMenuItem(title: "Copy".localized(), action: #selector(UrlCell.copyUrl)), UIMenuItem(title: "Share".localized(), action: #selector(UrlCell.shareUrl)), UIMenuItem(title: "Open in Safari".localized(), action: #selector(UrlCell.openInSafari))]
        
        return action == #selector(UrlCell.copyUrl) || action == #selector(UrlCell.shareUrl) || action == #selector(UrlCell.openInSafari)
    }
    
    
    @objc func copyUrl() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = urlTextField?.text
      }
    
    @objc func shareUrl() {
        let sharingContent = [urlTextField?.text]
        let ac = UIActivityViewController(activityItems: sharingContent as [Any], applicationActivities: nil)
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
      }
    
    @objc func openInSafari() {
        guard let link = URL(string: (urlTextField?.text)!) else { return }
        UIApplication.shared.open(link)
      }
    

    @IBAction func urlButtonPressed(_ sender: Any) {
        guard let link = URL(string: (urlTextField?.text)!) else { return }
        UIApplication.shared.open(link)
    }
    
}
