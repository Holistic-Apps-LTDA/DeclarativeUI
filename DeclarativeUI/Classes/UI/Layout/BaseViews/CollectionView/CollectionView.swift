import UIKit

public class CollectionView: DeclarativeView {
    typealias CollectionCell = BaseCollectionViewCell
    public var rootView: BaseCollectionView { collectionView }
    private let dataSource = DataSource()
    private let delegate = Delegate()
    private var lastScrollOffset: CGFloat = 0

    private let layout = AlignedCollectionViewFlowLayout()
    private let collectionView: BaseCollectionView

    private init() {
        collectionView = BaseCollectionView(layout: layout)
        collectionView.register(CollectionCell.self,
                                forCellWithReuseIdentifier: CollectionCell.reuseIdentifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        observe(delegate.events.didSelectItem) { `self`, indexPath in
            self.dataSource.cells[indexPath.row].runTap()
        }
    }

    public convenience init<Value>(_ observable: Observable<Value>, @CellBuilder _ cells: @escaping (Value) -> [Cell]) {
        self.init()
        observable.subscribe()
            .onNext { [weak self] value in
                guard let self = self else { return }
                self.dataSource.cells = cells(value)
                self.collectionView.reloadData()
            }
            .disposedBy(self)
    }
    
    public convenience init(@CellBuilder _ cells: () -> [Cell]) {
        self.init()
        dataSource.cells = cells()
        collectionView.reloadData()
    }
    
    @discardableResult
    public func updateCells(@CellBuilder _ cells: () -> [Cell]) -> Self {
        dataSource.cells = cells()
        collectionView.reloadData()
        return self
    }
    
    @discardableResult
    public func sectionInsets(_ insets: UIEdgeInsets) -> Self {
        layout.sectionInset = insets
        return self
    }
    
    @discardableResult
    public func axis(_ axis: UICollectionView.ScrollDirection) -> Self {
        layout.scrollDirection = axis
        return self
    }
    
    @discardableResult
    public func contentSizeStyle(_ style: BaseCollectionView.ContentSizeStyle) -> Self {
        collectionView.contentSizeStyle = style
        return self
    }
    
    @discardableResult
    public func minimumLineSpacing(_ spacing: Size) -> Self {
        layout.minimumLineSpacing = spacing.value
        return self
    }
    
    @discardableResult
    public func minimumInteritemSpacing(_ spacing: Size) -> Self {
        layout.minimumInteritemSpacing = spacing.value
        return self
    }
    
    @discardableResult
    public func verticalAlignment(_ alignment: VerticalAlignment) -> Self {
        layout.verticalAlignment = alignment
        return self
    }
    
    @discardableResult
    public func horizontalAlignment(_ alignment: HorizontalAlignment) -> Self {
        layout.horizontalAlignment = alignment
        return self
    }
    
    @discardableResult
    public func pagingEnabled(_ isEnabled: Bool) -> Self {
        collectionView.isPagingEnabled = isEnabled
        return self
    }
    
    @discardableResult
    public func estimatedItemSize(_ size: CGSize) -> Self {
        layout.estimatedItemSize = size
        return self
    }
    
    @discardableResult
    public func pageControl(_ pageControl: PageControl) -> Self {
        pageControl.rootView.isUserInteractionEnabled = false
        observe(dataSource.$cells) { _, cells in
            pageControl.numberOfPages(cells.count)
            pageControl.currentPage(0)
        }
        observe(delegate.events.didScroll) { `self`, scrollView in
            let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: scrollView.frame.height / 2)
            if let indexPath = self.collectionView.rootView.indexPathForItem(at: center) {
                pageControl.currentPage(indexPath.row)
            }
        }
        return self
    }
    
    @discardableResult
    public func fadingScroll() -> Self {
        observe(delegate.events.didScroll) { `self`, scrollView in
            let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: scrollView.frame.height / 2)
            if let indexPath = self.collectionView.rootView.indexPathForItem(at: center) {
                let currentCell = self.collectionView.rootView.cellForItem(at: indexPath)
                let cellWidth = currentCell?.frame.width ?? 0
                let trueOffset = scrollView.contentOffset.x - (cellWidth * CGFloat(indexPath.row))
                currentCell?.alpha = 1 - (trueOffset / cellWidth)
            }
            self.lastScrollOffset = scrollView.contentOffset.x
        }
        return self
    }
}
