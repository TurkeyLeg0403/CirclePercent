import RealmSwift

class ItemDAO {
    let realm = try! Realm();
    
    public func addItem(item:Item, isUpdated:Realm.UpdatePolicy) {
        let nDAO = NumberingDAO();
        item.id = nDAO.nextItemId();
        do {
            try realm.write {
                realm.add(item, update: isUpdated)
            }
        } catch {
            print("Realm AddItem Error: \(item.toString())")
        }
    }
    
    public func findByCode(id: Int) -> Item{
        let item: Item = realm.object(ofType: Item.self, forPrimaryKey: id)!
        return item
    }
    
    public func findAll() -> Results<Item>{
        let items: Results<Item> = realm.objects(Item.self)
        return items
    }
    
    public func deleteByCode(id: Int){
        let item = self.findByCode(id: id);
        try! realm.write {
            realm.delete(item);
        }
    }
}
