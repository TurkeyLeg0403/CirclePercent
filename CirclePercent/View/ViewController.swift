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
    var items: Results<Item>!
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

    }
}

