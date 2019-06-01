//
//  InviteFriendsVC.swift
//  Swollmeights
//
//  Created by Matthew Reid on 3/7/18.
//  Copyright © 2018 Matthew Reid. All rights reserved.
//

import UIKit
import MessageUI

class InviteFriendsVC: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var open: UIButton!
    @IBOutlet weak var invBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make button round
        invBtn.layer.cornerRadius = 5.0
        invBtn.clipsToBounds = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        open.addTarget(self.revealViewController(), action:#selector(SWRevealViewController.revealToggle(_:)), for:UIControlEvents.touchUpInside)
        
        // support pan to open menu functionality
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    
    @IBAction func invPressed(_ sender: UIButton) {
        let options = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // allow user to copy App Store link
        options.addAction(UIAlertAction(title: "Copy link", style: .default, handler: { action in
            
            UIPasteboard.general.string = "https://itunes.apple.com/us/genre/ios/id36?mt=8"
        }))
        
        // allow users to send a link to the app via iMessage
        options.addAction(UIAlertAction(title: "iMessage", style: .default, handler: { action in
                if MFMessageComposeViewController.canSendText() == true {
                    let recipients:[String] = [""]
                    let messageController = MFMessageComposeViewController()
                    messageController.messageComposeDelegate  = self
                    messageController.recipients = recipients
                    messageController.body = "Hey! Start meeting members of Binghamton's alumni network with BingnLinks, at itunes.apple.com/us/app/"
                    self.present(messageController, animated: true, completion: nil)
                } else {
                    //handle text messaging not available
                    
                }
        }))
        options.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(options, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
