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

class PopupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    // MARK: - IB Outlets

    @IBOutlet var stepper: UIStepper!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var pageTextField: UITextField!
    
    // MARK: - Public properties

    var pickerData: [Int]!
    var delegate: PopUpDelegate?

    // MARK: - Private properties
    
    private var limit = 10
    private var page = "1"
    private var pagesMax = 10
    var settings = UserDefaults()
    
    
    static var currentEndPoint = ""

    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialValues()
        pickerSetup()
        stepper.maximumValue = Double(pagesMax)
        stepper.value = Double(page) ?? 1
        view.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        pageTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldDidEndEditing(pageTextField)
//        self.dismiss(animated: true)
    }
    
    // MARK: - IB Actions
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed() {
        let count = Int(pageTextField.text ?? "0") ?? 0
        if count <= pagesMax {
            delegate?.getNew(endPoint: generateEndPoint())
            dismiss(animated: true)
        } else {
            textFieldDidEndEditing(pageTextField)
        }
        settings.set(pagesMax, forKey: "pagesMax")
        settings.set(limit, forKey: "limit")
        settings.set(page, forKey: "page")
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        pageTextField.text = String(Int(sender.value))
    }
    
    // MARK: - Private methods
    
    private func generateEndPoint() -> String {
        page = String(pageTextField.text ?? "1")
        limit = pickerData[picker.selectedRow(inComponent: 0)]
        let endPoint = "?page=\(page)&limit=\(limit)"
        return endPoint
    }
    
    private func setInitialValues() {
        pagesMax = settings.value(forKey: "pagesMax") as? Int ?? 100
        limit = settings.value(forKey: "limit") as? Int ?? 10
        pageTextField.text = settings.value(forKey: "page") as? String ?? "1"
        page = settings.value(forKey: "page") as? String ?? "1"
    }

    // MARK: - Protocol methods
    
    static func showPopup(parentVC: UICollectionViewController) {
        if let newEventVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as? PopupViewController {
            newEventVC.modalPresentationStyle = .custom
            newEventVC.modalTransitionStyle = .crossDissolve
            newEventVC.delegate = parentVC as? PopUpDelegate
            parentVC.present(newEventVC, animated: true)
        }
    }
    
    // MARK: - Picker view data source
    
    private func pickerSetup() {
        picker.delegate = self
        picker.dataSource = self
        let minNum = 10
        let maxNum = 100
        pickerData = Array(stride(from: minNum, to: maxNum + 1, by: 10))
        let pickerIndex = pickerData.firstIndex(of: limit)
        picker.selectRow(pickerIndex ?? 0, inComponent: 0, animated: true)
        pagesMax = 1000 / pickerData[picker.selectedRow(inComponent: 0)]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(pickerData[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        45
    }
    
    // MARK: - Picker view delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pagesMax = 1000 / pickerData[picker.selectedRow(inComponent: 0)]
        stepper.maximumValue = Double(pagesMax)
        guard let number = Int(pageTextField.text ?? "0") else { return }
        if number > pagesMax {
            pageTextField.text = String(pagesMax)
            stepper.maximumValue = Double(pagesMax)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let numberOfPages = Int(text) else {
            textField.text = "1"
            return
        }
        if numberOfPages > 100 {
            textField.text = "100"
        } else if numberOfPages > (1000 / limit) {
            textField.text = String(1000 / limit)
        }
    }
}

extension UIViewController {
    
}
