//
//  ViewController.swift
//  CryptoWatch
//
//  Created by Ashish Sharma on 12/27/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var cryptoListViewModel: CryptoListViewModel!
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.colorArray = [UIColor(red: 75/255, green: 57/255, blue: 204/255, alpha: 1.0),
                           UIColor(red: 15/255, green: 147/255, blue: 14/255, alpha: 1.0),
                           UIColor(red: 104/255, green: 57/255, blue: 54/255, alpha: 1.0),
                           UIColor(red: 104/255, green: 127/255, blue: 64/255, alpha: 1.0),
                           UIColor(red: 114/255, green: 57/255, blue: 204/255, alpha: 1.0),
                           UIColor(red: 154/255, green: 67/255, blue: 224/255, alpha: 1.0)]
        
        getData()
    }
    
    func getData() {
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        WebService().downloadCurrencies(url: url) { (cryptos) in
            if let cryptos = cryptos {
                print(cryptos)
                
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.currencyText.text = cryptoViewModel.name
        cell.priceText.text = cryptoViewModel.price
        
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        
        return cell
    }
    


}

