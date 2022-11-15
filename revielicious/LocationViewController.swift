//
//  LocationViewController.swift
//  revielicious
//
//  Created by Jaspal Singh on 14/11/22.
//

import UIKit

class LocationViewController: UIViewController {
    var businessModel = BusinessModel()
    private var allBusinesses = [Business]()
    let webSeriesList:[String]=["Maharani", "Kathmandhu Connection", "Scam 1992"]
    private var viewModel = BusinessViewModel()
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllBusinsses {
            self.myTableView.dataSource = self
            self.myTableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func getAllBusinsses(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        businessModel.fetchBusinessData() { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.allBusinesses = listOf.businesses
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
}

extension LocationViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allBusinesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "businesscell", for: indexPath) as! BusinessTableViewCell
        cell.businessName.text = self.allBusinesses[indexPath.row].name
        cell.businessImage.contentMode = .scaleAspectFill
        cell.businessImage.clipsToBounds = true
        cell.businessImage.loadFrom(URLAddress: self.allBusinesses[indexPath.row].image_url!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BusinessDetailViewController") as? BusinessDetailViewController {
            vc.image = self.allBusinesses[indexPath.row].image_url!
            vc.name = self.allBusinesses[indexPath.row].name!
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        myTableView.deselectRow(at: indexPath, animated: true)
//        performSegue(withIdentifier: "BusinessDetail", sender: self)
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
            guard let url = URL(string: URLAddress) else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                if let imageData = try? Data(contentsOf: url) {
                    if let loadedImage = UIImage(data: imageData) {
                            self?.image = loadedImage
                    }
                }
            }
        }
}
