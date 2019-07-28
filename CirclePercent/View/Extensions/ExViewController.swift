import UIKit
import Charts

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
        self.reloadPieChart()
        return cell
    }
    
    // delete method
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let iDAO = ItemDAO()
            print("count1: \(self.items.count)")
            iDAO.deleteByCode(id: self.items[indexPath.row].id)
            print("count2: \(self.items.count)")
            tableView.reloadData()
        }
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

extension ViewController{
    func reloadPieChart() {
//        if let viewWithTag = self.view.viewWithTag(10) {
//            viewWithTag.removeFromSuperview()
//        }else{
//            print("No!")
//        }
        
        var dataEntries: Array<ChartDataEntry> = []
        // 円グラフの中心に表示するタイトル
        self.pieChartsView.centerText = "テストデータ"
        // グラフに表示するデータのタイトルと値
        items = iDAO.findAll()
        for item in items{
            dataEntries.append(PieChartDataEntry(value: item.value, label: item.name));
        }
        let dataSet = PieChartDataSet(entries: dataEntries, label: "テストデータ")
        // グラフの色
        dataSet.colors = ChartColorTemplates.vordiplom()
        // グラフのデータの値の色
        dataSet.valueTextColor = UIColor.black
        // グラフのデータのタイトルの色
        dataSet.entryLabelColor = UIColor.black
        self.pieChartsView.data = PieChartData(dataSet: dataSet)
        
        // データを％表示にする
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1.0
        self.pieChartsView.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        self.pieChartsView.usePercentValuesEnabled = true
        self.pieChartsView.tag = 10;
        self.view.addSubview(self.pieChartsView)
    }
}

extension UIView {
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while true {
            guard let nextResponder = parentResponder?.next else { return nil }
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }
}
