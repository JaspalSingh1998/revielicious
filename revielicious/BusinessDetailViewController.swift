//
//  BusinessDetailViewController.swift
//  revielicious
//
//  Created by Jaspal Singh on 15/11/22.
//

import UIKit

class BusinessDetailViewController: UIViewController {

    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessAddressLabelView: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    
    var name = ""
    var image = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        businessNameLabel.text = name
        businessImageView.contentMode = .scaleAspectFill
        businessImageView.clipsToBounds = true
        businessImageView.loadFrom(URLAddress: image)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
