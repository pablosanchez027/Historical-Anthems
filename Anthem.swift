//
//  Anthem.swift
//  Historical-Anthems
//
//  Created by Alumno on 29/11/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import Foundation
import UIKit

class Anthem {
    var anthemName: String = ""
    var anthemCountry: String = ""
    var anthemYear: String = ""
    var anthemLanguage: String = ""
    var anthemInfo: String = ""
    var anthemMap: String = ""
    var anthemEmbed: String = ""
    
    init(anthemName: String, anthemCountry: String, anthemYear: String, anthemLanguage: String, anthemInfo: String, anthemMap: String, anthemEmbed: String) {
        self.anthemName = anthemName
        self.anthemCountry = anthemCountry
        self.anthemYear = anthemYear
        self.anthemLanguage = anthemLanguage
        self.anthemInfo = anthemInfo
        self.anthemMap = anthemMap
        self.anthemEmbed = anthemEmbed
    }
}
