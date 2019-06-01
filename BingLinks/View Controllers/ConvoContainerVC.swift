//
//  ConvoContainerVC.swift
//  BingLinks
//
//  Created by Matthew Reid on 7/29/18.
//  Copyright © 2018 Matthew Reid. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ConvoContainerVC: UIViewController {

    // IBOutlets
    @IBOutlet weak var titleLabel : UILabel?
    @IBOutlet weak var backButton : UIButton?
    
    // array of JSQMessage objects
    var messages = [JSQMessage]()
    
    // array of the times that each message was sent
    var timestamps = [Double]()
    
    // user's name and ID
    var recipientName : String?
    var recipientID : String?
    
    var img : UIImage?
    
    // the conversation is displayed in a containerView, which essentially enables a ViewController to be placed inside of another ViewController d
    @IBOutlet var containerView: UIView!
    var containerViewController: ConversationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display who the message will be sent to
        self.titleLabel?.text = recipientName!

        backButton?.addTarget(self, action: #selector(backPressed), for: UIControlEvents.touchUpInside)
        
    }
    
    // exit conversation
    @objc func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // pass data between View Controllers via segue (this -> ConversationViewController)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerViewSegue" {
            containerViewController = segue.destination as?
            ConversationViewController
            
            containerViewController?.timestamps = timestamps
            containerViewController?.recipientName = recipientName
            containerViewController?.recipientID = recipientID
            containerViewController?.img = self.img
            containerViewController?.messages = messages
            
        }
    }

}
