//
//  Business.swift
//  revielicious
//
//  Created by Jaspal Singh on 14/11/22.
//

import Foundation

class BusinessViewModel {
    var businessModel = BusinessModel()
    private var allBusinesses = [Business]()
    
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
    
    func numberOfRowsInSection(section: Int) -> Int {
        if allBusinesses.count != 0 {
            return allBusinesses.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Business {
        return allBusinesses[indexPath.row]
    }
}
