import UIKit

extension CollectionView {
    class DataSource: NSObject, UICollectionViewDataSource {
        @ObservableProperty
        var cells: [Cell] = []
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            cells.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = cells[indexPath.row]
            let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseIdentifier, for: indexPath) as! CollectionCell
            collectionCell.update(with: cell.view())
            return collectionCell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            cells[indexPath.row].runTap()
        }
    }
    
    class Delegate: NSObject, UICollectionViewDelegate {
        let events = CollectionViewEvents()
        struct CollectionViewEvents {
            let didScroll = Publisher<UIScrollView>()
            let didSelectItem = Publisher<IndexPath>()
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            events.didSelectItem.publish(indexPath)
        }
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            events.didScroll.publish(scrollView)
        }
    }
}
