//
//  ViewController.swift
//  Assignment
//
//  Copyright © 2020 Giri. All rights reserved.
//

import UIKit
import CoreData

class CountryViewController: UIViewController {
    
    //MARK: Properties
    let countryTableView = UITableView()
    var countryItems: [CountryRowsDTO] = [CountryRowsDTO]()
    var dataSourceArray = [CountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isInternetAvailable = Reachability().isConnectedToNetwork()
        /* Load Data */
        if isInternetAvailable {
            dataSourceArray.removeAll()
            loadDataFromServer()
        } else {
            dataSourceArray.removeAll()
            getCountryData()
        }
        /* Setup Table */
        view.backgroundColor = .white
        countryTableView.rowHeight = UITableView.automaticDimension
        countryTableView.estimatedRowHeight = 244
        view.addSubview(countryTableView)
        setCountryTable()
    }
    
    //MARK: Table Layouts
    func setCountryTable() {
        countryTableView.translatesAutoresizingMaskIntoConstraints = false
    countryTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
    countryTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
    countryTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
    countryTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        countryTableView.dataSource = self
        countryTableView.delegate = self
        countryTableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        countryTableView.estimatedRowHeight = 100
        countryTableView.rowHeight = UITableView.automaticDimension
        countryTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "countryCell")
        
        navigationItem.title = "About Canada"
    }
}

//MARK: Configure Table
extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        
        let modal = self.dataSourceArray[indexPath.row]
        cell.descriptionLabel.text = modal.imageDescription
        cell.titleLabel.text = modal.title
        
        DispatchQueue.main.async(execute: {
            cell.countryImageView.image = UIImage(named: "SampleImage")
        })
        
        if let url = URL(string: modal.imageName) {
            if let imageD = modal.image {
                cell.countryImageView.image = imageD
                DispatchQueue.main.async(execute: {
                    cell.countryImageView.image = imageD
                })
            } else {
                cell.countryImageView.sd_setImage(with: url) { (image, error, cacheType, url) in
                    if let image = image {
                        self.dataSourceArray[indexPath.row].image = image
                        cell.countryImageView.image = image
                        DispatchQueue.main.async(execute: {
                            cell.countryImageView.image = image
                        })
                    }
                }
            }
        }
        
        return cell
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CountryViewController {
    //MARK: Load Data from Server
    private func loadDataFromServer() {
        
        ServiceHelper.request(params: [:], method: .get, apiName: "facts.json") { (response, error, httpCode) in
            if let error = error {
                print("Error Response: \(error)")
            } else {
                if let infoDictionary = response as? Dictionary<String, AnyObject> {
                    let countryModal = CountryTableModel(object: infoDictionary)
                    self.title = countryModal.title
                    self.dataSourceArray = countryModal.rows
                    self.storeCountryInLocal(countryData: countryModal)
                    self.countryTableView.reloadData()
                    self.navigationItem.title = countryModal.title
                }
            }
        }
    }
    
    //MARK: Store Data in CoreData
    func storeCountryInLocal(countryData: CountryTableModel) {
        
        let countryFields = CountryRowsDTO()
        let countryDetailData = dataSourceArray
        for country in countryDetailData {
            let predicateTitle = NSPredicate(format: "countryTitle = %@", country.title)
            let managedobject = HCoreDataHandler().fetchEntityDetailsWithRequestPredicate(entityName: "CountryDataBase", predicate: predicateTitle) as! [CountryDataBase]
            if managedobject.count == 0 {
                countryFields.description = country.imageDescription
                countryFields.title = country.title
                countryFields.image = country.imageName
                CountryDataBase.saveCountryDetails(countryInfo: countryFields, title: countryData.title)
            }
        }
    }
    
    //MARK: Load Data from CoreData
    func getCountryData() {
        let fetch = HCoreDataHandler().fetchEntityDetails(entityName: "CountryDataBase")
        dataSourceArray.removeAll()
        for data in fetch {
            let countryData = CountryModel()
            
            countryData.imageDescription = data.value(forKey: "countryDescription") as! String
            
            countryData.imageName = data.value(forKey: "countryImage") as! String
            countryData.title = data.value(forKey: "countryTitle") as! String
            dataSourceArray.append(countryData)
        }
    }    
}


