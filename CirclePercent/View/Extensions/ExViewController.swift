import UIKit

//MARK: - TableView Conf
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // section count
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.iDAO.findAll().count
    }
    
    // cell contents
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //set cell informations
        let items = self.iDAO.findAll();
        let cell = self.itemTable.dequeueReusableCell(withIdentifier: "itemTableCell") as! ItemTableCell
        cell.name.text = items[indexPath.row].name
        cell.value.text = String(items[indexPath.row].value)
        return cell
    }
    
    //tap to the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - cellContentField
extension ViewController: UITextFieldDelegate{
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.inputFieldView.determinBtn.isEnabled = !(textField.text?.isEmpty ?? true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // close the keyboard
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - keyboard hide options
extension ViewController{
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        let itemTableHeight = self.itemTable.frame.size.height
        if self.inputViewTop.constant == additionalSafeAreaInsets.bottom {
            self.inputViewTop.constant -= keyboardFrame.height
            self.inputViewTop.constant += itemTableHeight
        }
        
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.inputViewTop.constant != additionalSafeAreaInsets.bottom {
            self.inputViewTop.constant = additionalSafeAreaInsets.bottom
        }
    }
}

