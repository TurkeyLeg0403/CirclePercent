import RealmSwift

class NumberingDAO {
    let realm = try! Realm();
    
    public func nextItemId() -> Int{
        let numberingDB = realm.objects(Numbering.self);
        var nextItemId = 0;
        if numberingDB.isEmpty{
            nextItemId = 0;
        } else {
           nextItemId = numberingDB[0].itemId + 1;
        }
        let numbering = Numbering(itemId: nextItemId);
        self.addNumbering(numbering: numbering);
        return nextItemId;
    }
    
    private func addNumbering(numbering: Numbering){
        do {
            try realm.write {
                realm.add(numbering, update: .all);
            }
        } catch {
            print("Realm AddItem Error: \(numbering.toString())");
        }
    }
}
