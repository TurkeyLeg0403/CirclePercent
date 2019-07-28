import UIKit
import Charts
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var pieChartsView: PieChartView!
    @IBOutlet weak var inputFieldView: InputFieldView!
    @IBOutlet weak var inputViewTop: NSLayoutConstraint!
    @IBOutlet weak var pieChartsViewTop: NSLayoutConstraint!
    @IBOutlet weak var itemTable: UITableView!
    
    let iDAO = ItemDAO();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputFieldView.nameField.delegate = self
        self.inputFieldView.nameField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                        for: UIControl.Event.editingChanged)
        self.inputFieldView.valueField.delegate = self
        self.inputFieldView.valueField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                                for: UIControl.Event.editingChanged)
        
        self.itemTable.delegate = self
        self.itemTable.dataSource = self
        self.itemTable.register(UINib(nibName: "ItemTableCell", bundle: nil), forCellReuseIdentifier: "itemTableCell")
        
        // set keyboard hide options
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        var items: Results<Item>
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
        
        view.addSubview(self.pieChartsView)
    }
}

