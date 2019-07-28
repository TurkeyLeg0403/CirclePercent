//
//  InputFieldView.swift
//  CirclePercent
//
//  Created by Takaki Otsu on 2019/06/22.
//  Copyright © 2019 Takaki Otsu. All rights reserved.
//

import UIKit

class InputFieldView: UIView {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var determinBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }
    
    // ストーリーボードで配置した時の初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
    }

    func loadNib() {
        let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func determinBtn(_ sender: Any) {
        let iDAO = ItemDAO();
        let item = Item.init(name: nameField.text!, value: atof(valueField.text));
        iDAO.addItem(item: item, isUpdated: .all)
        let vc = self.parentViewController() as! ViewController
        vc.itemTable.reloadData()
    }
    
}
