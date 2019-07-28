import RealmSwift
import UIKit

class Numbering: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var itemId: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(itemId: Int){
        self.init()
        self.itemId = itemId;
    }
    
    public func toString() -> String{
        return "Numbering[itemId:\(self.itemId)]"
    }
}
