//
//  DynamicHeightTableView.swift
//  Musify
//
//  Created by Salman Afzal on 02/09/2024.
//

import UIKit
import SwiftSignatureView

struct SignatureData {
    var signatureImage: UIImage?
}

extension SwiftSignatureView {
    func getSignatureImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

class TableViewController: UITableViewController {

    var signatureDataArray: [SignatureData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize signatureDataArray with empty data if needed
        signatureDataArray = Array(repeating: SignatureData(signatureImage: nil), count: numberOfRowsInSection)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signatureDataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignatureCell", for: indexPath) as! SignatureTableViewCell
        let data = signatureDataArray[indexPath.row]
        
        // Configure the cell
        cell.signatureView.clear() // Clear any previous signatures
        if let image = data.signatureImage {
            cell.signatureView.signatureImage = image
        }
        
        // Handle saving the signature
        cell.signatureView.onSignatureDidChange = { [weak self] in
            guard let self = self else { return }
            if let signatureImage = cell.signatureView.getSignatureImage() {
                self.signatureDataArray[indexPath.row].signatureImage = signatureImage
            }
        }

        return cell
    }

    // Method to retrieve all signature images
    func getAllSignatures() -> [UIImage?] {
        return signatureDataArray.map { $0.signatureImage }
    }
    
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        let allSignatures = getAllSignatures()
        
        // Handle your signatures here, e.g., uploading or saving
        for (index, signature) in allSignatures.enumerated() {
            if let signatureImage = signature {
                print("Signature \(index) ready for submission")
                // Process the signature image
            } else {
                print("Signature \(index) is missing")
            }
        }
    }
}


