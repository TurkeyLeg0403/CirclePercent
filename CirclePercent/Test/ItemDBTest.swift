class ItemDBTest {
    let iDAO = ItemDAO();
    let nDAO = NumberingDAO();
    
    public func addItem(item: Item) {
        iDAO.addItem(item: item, isUpdated: .all)
    }
}
