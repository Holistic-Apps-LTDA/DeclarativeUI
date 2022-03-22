import Foundation

public class NavigationBarConfiguration {
    public var hidden: Bool
    public var options: NavigationOptions
    public var style: NavigationBarStyle
    public var progress: ProgressStep
    public var leftButton: NavigationBar.CustomButton?
    public var rightButton: NavigationBar.CustomButton?

    public init(hidden: Bool = false,
                options: NavigationOptions = .default,
                style: NavigationBarStyle = .light,
                progress: ProgressStep = ProgressStep(),
                leftButton: NavigationBar.CustomButton? = nil,
                rightButton: NavigationBar.CustomButton? = nil) {
        self.hidden = hidden
        self.options = options
        self.style = style
        self.progress = progress
        self.rightButton = rightButton
        self.leftButton = leftButton
    }
}
