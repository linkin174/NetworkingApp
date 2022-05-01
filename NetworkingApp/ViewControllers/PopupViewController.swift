//
//  PopupViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 16.04.2022.
//

import UIKit

protocol PopUpDelegate {
    func createEndPoint(page: Int, limit: Int)
}

class PopupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    // MARK: - IB Outlets

    @IBOutlet var stepper: UIStepper!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var pageTextField: UITextField!
    
    // MARK: - Public properties
    
    var delegate: PopUpDelegate?

    // MARK: - Private properties
    
    private var limit = 10
    private var page = 1
    private var pagesMax: Int {
        1000 / limit
    }

    private var pickerData: [Int]!

    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialValues()
        pickerSetup()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        pageTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed() {
        guard let text = pageTextField.text, let enteredPage = Int(text) else { return }
      
        if enteredPage <= pagesMax {
            page = enteredPage
            UserDefaults.standard.set(page, forKey: "page")
            UserDefaults.standard.set(limit, forKey: "limit")
            delegate?.createEndPoint(page: page, limit: limit)
            dismiss(animated: true)
        } else {
            view.endEditing(true)
        }
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        pageTextField.text = String(Int(sender.value))
    }
    
    // MARK: - Private methods
    
    private func setInitialValues() {
        limit = UserDefaults.standard.value(forKey: "limit") as? Int ?? 10
        page = UserDefaults.standard.value(forKey: "page") as? Int ?? 1
        pageTextField.text = String(page)
        stepper.value = Double(page)
        stepper.maximumValue = Double(pagesMax)
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
        limit = pickerData[picker.selectedRow(inComponent: 0)]
        stepper.maximumValue = Double(pagesMax)
        guard let text = pageTextField.text, let number = Int(text) else { return }
        if number > pagesMax {
            pageTextField.text = String(pagesMax)
            stepper.value = stepper.maximumValue
        } else {
            stepper.value = Double(number)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let numberOfPages = Int(text) else {
            textField.text = "1"
            return
        }
        stepper.value = Double(numberOfPages)
        if numberOfPages > pagesMax {
            textField.text = String(pagesMax)
            stepper.value = Double(pagesMax)
        }
    }
}
