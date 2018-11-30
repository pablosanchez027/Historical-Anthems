//
//  AnthemsTableViewController.swift
//  Historical-Anthems
//
//  Created by Alumno on 28/11/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class AnthemsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var urlAnthemsAPI: String = "https://historical-anthems.azurewebsites.net/?json=get_posts&post_type=anthems"
    var countAnthemsAPI: Int = 0
    var urlAnthemsAPICount: String = ""
    
    var urlCountryAPI: String = "https://historical-anthems.azurewebsites.net/?json=get_posts&post_type=country"
    var countCountryAPI: Int = 0
    var urlCountryAPICount: String = ""
    
    var urlLanguageAPI: String = "https://historical-anthems.azurewebsites.net/?json=get_posts&post_type=language"
    var countLanguageAPI: Int = 0
    var urlLanguageAPICount: String = ""
    
    var Name: String = ""
    var Country: String = ""
    var Year: String = ""
    var Language: String = ""
    var Info: String = ""
    var Map: String = ""
    var Embed: String = ""
    
    var AnthemCountryID: String = ""
    var AnthemLanguageID: String = ""
    
    var imageURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aiIndicator.startAnimating()
        
        Alamofire.request(urlAnthemsAPI).responseJSON {
            response in
            
            if let diccionarioRespuestaAnthems = response.result.value as? NSDictionary {
                if let countAPI = diccionarioRespuestaAnthems.value(forKey: "count_total") as? Int {
                    self.countAnthemsAPI = countAPI
                }
            }
        }
        
        urlAnthemsAPICount = "\(urlAnthemsAPI)" + "&count_total=" + String("\(countAnthemsAPI)")
        
        Alamofire.request(urlAnthemsAPICount).responseJSON {
        response in
        DatosAnthems.AnthemsList.removeAll()
            
        var anthem: Anthem
            
            if let dictionaryAnthems = response.result.value as? NSDictionary {
                if let arrayAnthems = dictionaryAnthems.value(forKey: "posts") as? NSArray {
                    for indexAnthems in arrayAnthems {
                        //Inside Anthem Posts
                        if let elementAnthem = indexAnthems as? NSDictionary {
                            self.Name = (elementAnthem.value(forKey: "title") as? String)!
                            
                            //Map search
                            if let attachementsArray = elementAnthem.value(forKey: "attachements") as? NSArray {
                                
                                for attachementIndex in attachementsArray {
                                    if let attachementElementDictionary = attachementIndex as? NSDictionary {
                                        self.imageURL = (attachementElementDictionary.value(forKey: "url") as? String)!
                                    }
                                }
                                
                            }
                            
                            //Inside Custom Fields
                            if let dictionaryCustomFields = elementAnthem.value(forKey: "custom_fields") as? NSDictionary {
                                //Country Array for country ID
                                if let countryArray = dictionaryCustomFields.value(forKey: "country") as? NSArray {

                                    for countryIndex in countryArray {
                                        if let countryElement = countryIndex as? String {
                                            self.AnthemCountryID = countryElement
                                        }
                                        
                                    }
                                    
                                }
                                
                                //Country Search
                                Alamofire.request(self.urlCountryAPI).responseJSON {
                                    response in
                                    if let diccionarioRespuestaCountry = response.result.value as? NSDictionary {
                                        self.countCountryAPI = (diccionarioRespuestaCountry.value(forKey: "count_total") as? Int)!
                                    }
                                }
                                self.urlCountryAPICount = "\(self.urlCountryAPI)" + "&count_total=" + String("\(self.countCountryAPI)")
                                
                                Alamofire.request(self.urlCountryAPICount).responseJSON {
                                    response in
                                    if let dictionaryCountry = response.result.value as? NSDictionary{
                                        if let arrayCountry = dictionaryCountry.value(forKey: "posts") as? NSArray {
                                            for indexCountry in arrayCountry {
                                                //Search fo Country ID
                                                if let elementCountry = indexCountry as? NSDictionary {
                                                    let countryID = elementCountry.value(forKey: "id") as? String
                                                    
                                                    if countryID == self.AnthemCountryID {
                                                        self.Country = (elementCountry.value(forKey: "title") as? String)!
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                //Year Array for Year
                                if let yearArray = dictionaryCustomFields.value(forKey: "year") as? NSArray {
        
                                    for yearIndex in yearArray {
                                        if let yearElement = yearIndex as? String {
                                            self.Year = yearElement
                                        }
                                    }
                                    
                                }
                                //Language Array for language ID
                                if let languageArray = dictionaryCustomFields.value(forKey: "language") as? NSArray {
                                    
                                    for languageIndex in languageArray {
                                        if let languageElement = languageIndex as? String {
                                            self.AnthemLanguageID = languageElement
                                        }
                                    }
                
                                }
                                
                                //Language Search
                                Alamofire.request(self.urlLanguageAPI).responseJSON {
                                    response in
                                    if let diccionarioRespuestaLanguage = response.result.value as? NSDictionary {
                                        self.countLanguageAPI = (diccionarioRespuestaLanguage.value(forKey: "count_total") as? Int)!
                                    }
                                }
                                self.urlLanguageAPICount = "\(self.urlLanguageAPI)" + "&count_total=" + String("\(self.countLanguageAPI)")
                                
                                Alamofire.request(self.urlLanguageAPICount).responseJSON {
                                    response in
                                    if let dictionaryLanguage = response.result.value as? NSDictionary{
                                        if let arrayLanguage = dictionaryLanguage.value(forKey: "posts") as? NSArray {
                                            for indexLanguage in arrayLanguage {
                                                //Search fo Language ID
                                                if let elementLanguage = indexLanguage as? NSDictionary {
                                                    let languageID = elementLanguage.value(forKey: "id") as? String
                                                    
                                                    if languageID == self.AnthemLanguageID {
                                                        self.Language = (elementLanguage.value(forKey: "title") as? String)!
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                //Info Array for Info
                                if let infoArray = dictionaryCustomFields.value(forKey: "info") as? NSArray {
                                    
                                    for infoIndex in infoArray {
                                        if let infoElement = infoIndex as? String {
                                            self.Info = infoElement
                                        }
                                    }
                                    
                                }
                                //Embed Array for Embed
                                if let embedArray = dictionaryCustomFields.value(forKey: "url_webkit_embed") as? NSArray {
                                    
                                    for embedIndex in embedArray {
                                        if let embedElement = embedIndex as? String {
                                            self.Embed = embedElement
                                        }
                                    }
                                    
                                }
                                //End Custom Fields
                            }
                            anthem = Anthem(anthemName: self.Name, anthemCountry: self.Country, anthemYear: self.Year, anthemLanguage: self.Language, anthemInfo: self.Info, anthemMap: self.Map, anthemEmbed: self.Embed)
                            
                            DatosAnthems.AnthemsList.append(anthem)
                            self.tbAnthems.reloadData()
                            self.aiIndicator.stopAnimating()
                            //End Anthem Posts
                        }
                        
                    }
                }
            }
    }
    }
    
    @IBOutlet weak var tbAnthems: UITableView!
    @IBOutlet weak var aiIndicator: UIActivityIndicatorView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatosAnthems.AnthemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAnthem") as! AnthemCell
        cell.lblAnthem.text = DatosAnthems.AnthemsList[indexPath.row].anthemName
        cell.lblCountry.text = DatosAnthems.AnthemsList[indexPath.row].anthemCountry
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}

