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
    
    var urlPostIDAPI: String = "https://historical-anthems.azurewebsites.net/api/get_post/?post_id="
    var urlCountryIDAPI: String = ""
    var urlLanguageIDAPI: String = ""
    
    var Name: String = ""
    var Country: String = ""
    var Year: String = ""
    var Language: String = ""
    var Info: String = ""
    var Map: String = ""
    var Embed: String = ""
    
    var AnthemCountryID: String = ""
    var AnthemLanguageID: String = ""
    
    override func viewDidLoad() {
        self.title = "Anthems"
        super.viewDidLoad()
        aiIndicator.startAnimating()
        

        Alamofire.request(urlAnthemsAPI).responseJSON {
            response in
            
            if let diccionarioRespuestaAnthems = response.result.value as? NSDictionary {
                if let countAPI = diccionarioRespuestaAnthems.value(forKey: "count_total") as? Int {
                    self.countAnthemsAPI = countAPI
                }
            }
            
            self.urlAnthemsAPICount = "\(self.urlAnthemsAPI)" + "&count=" + String("\(self.countAnthemsAPI)")
            
            Alamofire.request(self.urlAnthemsAPICount).responseJSON {
                response in
                //DatosAnthems.AnthemsList.removeAll()
                
                var anthem: Anthem
                
                if let dictionaryAnthems = response.result.value as? NSDictionary {
                    if let arrayAnthems = dictionaryAnthems.value(forKey: "posts") as? NSArray {
                        for indexAnthems in arrayAnthems {
                            //Inside Anthem Posts
                            if let elementAnthem = indexAnthems as? NSDictionary {
                                self.Name = (elementAnthem.value(forKey: "title") as? String)!
                                
                                //Map search
                                if let attachmentsArray = elementAnthem.value(forKey: "attachments") as? NSArray {
                                    
                                    for attachmentsIndex in attachmentsArray {
                                        if let attachmentsElementDictionary = attachmentsIndex as? NSDictionary {
                                            if let attachmentsElement = attachmentsElementDictionary.value(forKey: "url") as? String {
                                                self.Map = attachmentsElement
                                            }
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
                                        
                                        //Country Search
                                        self.urlCountryIDAPI = "\(self.urlPostIDAPI)" + "\(self.AnthemCountryID)"  + "&post_type=country"
                                            Alamofire.request(self.urlCountryIDAPI).responseJSON {
                                            response in
                                            if let dictionaryCountry = response.result.value as? NSDictionary{
                                                if let dictionaryPosts = dictionaryCountry.value(forKey: "post") as? NSDictionary {
                                                    if let titleCountry = dictionaryPosts.value(forKey: "title") as? String {
                                                        self.Country = titleCountry
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
                                        
                                        //Language Search
                                        self.urlLanguageIDAPI = "\(self.urlPostIDAPI)" + "\(self.AnthemLanguageID)"  + "&post_type=language"
                                        var requestMID = Alamofire.request(self.urlLanguageIDAPI).responseJSON {
                                            response in
                                            if let dictionaryLanguage = response.result.value as? NSDictionary {
                                                if let dictionaryPosts = dictionaryLanguage.value(forKey: "post") as? NSDictionary {
                                                    if let titleLanguage = dictionaryPosts.value(forKey: "title") as? String {
                                                        self.Language = titleLanguage
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destiny = segue.destination as? AnthemsDetailViewController
            
            destiny?.anthem = DatosAnthems.AnthemsList[(tbAnthems.indexPathForSelectedRow?.row)!]
        }
    }
    
}

