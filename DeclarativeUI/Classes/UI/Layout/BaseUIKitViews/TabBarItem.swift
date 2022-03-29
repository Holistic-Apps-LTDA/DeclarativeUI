import UIKit

public class TabBarItem: UITabBarItem {
    public init(title: String,
                icon: FontIcon,
                normalStyle: TextStyle = .systemFont(ofSize: 12.0),
                iconSelected: FontIcon,
                selectedStyle: TextStyle = .boldSystemFont(ofSize: 12.0)) {
        super.init()
        setTitleTextAttributes([.font: normalStyle.font], for: .normal)
        setTitleTextAttributes([.font: selectedStyle.font], for: .selected)
        self.title = title
        image = Icon(icon, size: .small, color: .black).asImage()
        selectedImage = Icon(iconSelected, size: .small, color: .black).asImage()
    }
    
    public init(title: String,
                icon: UIImage,
                normalStyle: TextStyle = .systemFont(ofSize: 12.0),
                iconSelected: UIImage,
                selectedStyle: TextStyle = .boldSystemFont(ofSize: 12.0)) {
        super.init()
        setTitleTextAttributes([.font: normalStyle.font], for: .normal)
        setTitleTextAttributes([.font: selectedStyle.font], for: .selected)
        self.title = title
        image = icon
        selectedImage = iconSelected
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}
