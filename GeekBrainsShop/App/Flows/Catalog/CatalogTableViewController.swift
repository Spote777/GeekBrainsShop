//
//  CatalogTableViewController.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 31.05.2022.
//

import UIKit

class CatalogTableViewController: UITableViewController {
    
    // MARK: - Propreties
    
    let requestFactory = RequestFactory()
    var catalog: [CatalogResponse] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        NavButton()
    }
    
    // MARK: - OBJ-C Func
    
    @objc func editProfileButtonTapped(sender: UIButton) {
        editProfile()
    }
    
    @objc func openCartButtonTapped(sender: UIButton) {
        openCart()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = catalog[indexPath.row].productId
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        vc.productId = item
        navigationController?.pushViewController(vc, animated: true)
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
    
    private func NavButton() {
        let leftNavButton = UIBarButtonItem(image: UIImage.init(systemName: "gearshape"), style: .plain, target: self, action: #selector(editProfileButtonTapped))
        let rightNavButton = UIBarButtonItem(image: UIImage.init(systemName: "cart"), style: .plain, target: self, action: #selector(openCartButtonTapped))
        navigationItem.rightBarButtonItem = rightNavButton
        navigationItem.leftBarButtonItem = leftNavButton
    }
    
    private func editProfile() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditUserDataViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func openCart() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartTableViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}
