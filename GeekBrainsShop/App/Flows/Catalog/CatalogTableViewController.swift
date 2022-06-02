//
//  CatalogTableViewController.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 31.05.2022.
//

import UIKit

class CatalogTableViewController: UITableViewController {
    
    // MARK: - IBOutlet
    
    let requestFactory = RequestFactory()
    var catalog: [CatalogResponse] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        rightNavButton()
    }
    
    // MARK: - OBJ-C Func
    
    @objc func editProfileButtonTapped(sender: UIButton) {
        editProfile()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catalog.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogTableViewCell", for: indexPath) as! CatalogTableViewCell
        
        let item = catalog[indexPath.row]
        cell.configurationCell(model: item)
        return cell
    }
}

// MARK: - Private Func

extension CatalogTableViewController {
    
    private func fetchData() {
        let factory = requestFactory.makeGetCatalogRequestFactory()
        view.showSpinner()
        factory.getCatalog(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let result):
                self.catalog = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.dismissSpinner()
                }
            case .failure(let error):
                self.view.dismissSpinner()
                print(error.localizedDescription)
            }
        }
    }
    
    private func rightNavButton() {
        let rightNavButton =  UIBarButtonItem(image: UIImage.init(systemName: "gearshape"), style: .plain, target: self, action: #selector(editProfileButtonTapped))
        navigationItem.rightBarButtonItem = rightNavButton
    }
    
    private func editProfile() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditUserDataViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}
