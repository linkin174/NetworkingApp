//
//  PopupViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 16.04.2022.
//

import UIKit

protocol PopUpDelegate {
    func generate(URL: String)
}

class PopupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(pickerData[row])"
    }
    

    @IBOutlet var picker: UIPickerView!
    
    var pickerData: [Int]!
    var delegate: PopUpDelegate?
    private var imagesPerPage: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerSetup()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.55)
    }
    
    @IBAction func cancelButtonPressed() {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed() {
        delegate?.generate(URL: generateURL())
        self.dismiss(animated: true)
    }
    
    private func generateURL() -> String {
        let page = 1
        let limit = pickerData[self.picker.selectedRow(inComponent: 0)]
        let urlString = NetworkManager.Links.randomImageSetupList.rawValue + "page=\(page)&limit=\(limit)"
        imagesPerPage = limit
        return urlString
    }
    
    static func showPopup(parentVC: UICollectionViewController) {
        if let newEventVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as? PopupViewController {
            newEventVC.modalPresentationStyle = .custom
            newEventVC.modalTransitionStyle = .crossDissolve
            newEventVC.delegate = parentVC as? PopUpDelegate
            parentVC.present(newEventVC, animated: true)
        }
    }
    
    private func pickerSetup() {
        picker.delegate = self
        picker.dataSource = self
        let minNum = 10
        let maxNum = 200
        pickerData = Array(stride(from: minNum, to: maxNum + 1, by: 10))
        let pickerIndex = pickerData.firstIndex(where: { $0 == imagesPerPage })
        picker.selectRow(pickerIndex ?? 0, inComponent: 0, animated: true)
    }

}
