import RealmSwift
import UIKit

class Item: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var value: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, value: Double){
        self.init()
        self.name = name
        self.value = value
    }
    
    public func toString() -> String{
        return "item[id:\(self.id), name:\(self.name), value:\(self.value)]"
    }
}
