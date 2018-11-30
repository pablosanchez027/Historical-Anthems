//
//  AnthemMapViewController.swift
//  Historical-Anthems
//
//  Created by Alumno on 30/11/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class AnthemMapViewController: UIViewController {
    
    @IBOutlet weak var imgAnthemMap: UIImageView!
    var anthem: Anthem?
    var mapaURL: String = ""

    override func viewDidLoad() {
        
        if let selectedAnthemMap = anthem {
            self.title = selectedAnthemMap.anthemName
            
            mapaURL = "https://historical-anthems.azurewebsites.net/" + "\(selectedAnthemMap.anthemMap)"
            
            Alamofire.request(mapaURL).responseImage {
                response in
                self.imgAnthemMap.image = response.result.value
            }
        }
    }
}
