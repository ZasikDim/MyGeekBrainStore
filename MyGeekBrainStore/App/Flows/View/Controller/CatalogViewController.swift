//
//  CatalogViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 24.05.22.
//

import UIKit

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var catalogTableView: UITableView! {
        didSet {
            catalogTableView.dataSource = self
            catalogTableView.delegate = self
            
        }
    }
    private var viewModel = CatalogViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    @IBAction func unwindFromCatalogItemView(unwindSegue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCatalogItemViewController" else { return }
        guard let destinationController = segue.destination as? CatalogItemViewController else { return }
        
        if let indexSelectedCell = catalogTableView.indexPathForSelectedRow {
            let item = viewModel.catalog.items[indexSelectedCell.item]
            destinationController.viewModel.item = item
        }
    }
    
    private func configureViewModel() {
        viewModel.updateView = { [unowned self] in
            DispatchQueue.main.sync {
                self.catalogTableView.reloadData()
            }
        }
    }
}

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.catalog.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultItem = viewModel.catalog.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.identifier) as! CatalogTableViewCell
        cell.configure(result: resultItem)
        return cell
    }
}
