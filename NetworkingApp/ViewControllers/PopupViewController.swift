//
//  PopupViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 16.04.2022.
//

import UIKit

protocol PopUpDelegate {
    func getNew(endPoint: String)
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
    

    @IBOutlet var stepper: UIStepper!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var pageTextField: UITextField!
    
    var pickerData: [Int]!
    var delegate: PopUpDelegate?
    private var endPoint = ""
    private var limit = 10
    private var page = "1"
    static var currentEndPoint = ""
    private var pagesMax = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialValues(from: PopupViewController.currentEndPoint)
        pickerSetup()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.55)
    }
    
    @IBAction func cancelButtonPressed() {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed() {
        let count = Int(pageTextField.text ?? "0") ?? 0
//        print(count)
        if count <= pagesMax {
            delegate?.getNew(endPoint: generateEndPoint())
            self.dismiss(animated: true)
        } else {
            alert()
        }
       
    }

    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        pageTextField.text = String(Int(sender.value))
    }
    
    private func generateEndPoint() -> String {
        page = String(pageTextField.text ?? "1")
        self.limit = pickerData[self.picker.selectedRow(inComponent: 0)]
        endPoint = "?page=\(page)&limit=\(limit)"
        return endPoint
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
        let maxNum = 100
        pickerData = Array(stride(from: minNum, to: maxNum + 1, by: 10))
        let pickerIndex = pickerData.firstIndex(of: limit)
        picker.selectRow(pickerIndex ?? 0, inComponent: 0, animated: true)
    }
    
    private func setInitialValues(from endPoint: String) {
        guard let pageIndex = endPoint.distance(of: "=") else { return }
        print("Index of char = is \(pageIndex)")
        if let page = Int(endPoint[(pageIndex + 1)..<(pageIndex + 3)]) {
            self.limit = Int(endPoint[(pageIndex + 10)..<(pageIndex + 12)]) ?? 10
            self.page = String(page)
            stepper.value = Double(self.page) ?? 1.0
        } else {
            self.limit = Int(endPoint[(pageIndex + 9)..<(pageIndex + 11)]) ?? 10
            page = String(Int(endPoint[(pageIndex + 1)..<(pageIndex + 2)]) ?? 10)
            stepper.value = Double(self.page) ?? 1.0
        }
        pageTextField.text = page
        stepper.maximumValue = Double(pagesMax)
    }

    private func alert() {
        let alert = UIAlertController(title: "Error", message: "Maximum pages is \(pagesMax)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.pageTextField.text = String(self.pagesMax)
        }))
        present(alert, animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        45
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pagesMax = 1000 / pickerData[picker.selectedRow(inComponent: 0)]
        stepper.maximumValue = Double(pagesMax)
        guard let number = Int(pageTextField.text ?? "0") else { return }
        if number > pagesMax {
            pageTextField.text = String(pagesMax)
        }
    }
    
}
