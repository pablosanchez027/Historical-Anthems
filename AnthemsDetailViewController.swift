//
//  AnthemsDetailViewController.swift
//  Historical-Anthems
//
//  Created by Alumno on 30/11/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import WebKit

class AnthemsDetailViewController: UIViewController {
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var aeContent: WKWebView!
    
    var embedContent: String = ""
    
    var anthem: Anthem?
    
    override func viewDidLoad() {
        
        
        if let selectedAnthem = anthem {
            self.title = selectedAnthem.anthemName
            
            lblCountry.text = selectedAnthem.anthemCountry
            lblYear.text = selectedAnthem.anthemYear
            lblLanguage.text = selectedAnthem.anthemLanguage
            lblInfo.text = selectedAnthem.anthemInfo
            
            aeContent.scrollView.bounces = false
            aeContent.loadHTMLString(selectedAnthem.anthemEmbed, baseURL: nil)
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMap" {
            let destiny = segue.destination as! AnthemMapViewController
            
            destiny.anthem = anthem
        }
    }
}
