import UIKit

final class TapGestureRecognizer: UITapGestureRecognizer {
    public let onTap = Publisher<TapGestureRecognizer>()
    
    init() {
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(executeAction))
    }

    @objc private func executeAction() {
        onTap.publish(self)
    }
}

public extension DeclarativeView {
    private var tapRecognizer: TapGestureRecognizer {
        guard let recognizer = rootView.gestureRecognizers?.first(where: { $0 is TapGestureRecognizer }) as? TapGestureRecognizer else {
            let recognizer = TapGestureRecognizer()
            addGestureRecognizer(recognizer)
            return recognizer
        }
        return recognizer
    }

    @discardableResult
    func onTap(_ action: @escaping () -> Void) -> Self {
        observe(tapRecognizer.onTap) { _ in
            action()
        }
        return self
    }

    @discardableResult
    func onTap(_ action: @escaping (Self) -> Void) -> Self {
        onTap { [weak self] in
            guard let self = self else { return }
            action(self)
        }
    }

    @discardableResult
    func onTap<Object: AnyObject>(weak object: Object, action: @escaping (Object) -> Void) -> Self {
        onTap { [weak object] in
            guard let object = object else { return }
            action(object)
        }
    }

    @discardableResult
    func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) -> Self {
        rootView.addGestureRecognizer(gestureRecognizer)
        rootView.isUserInteractionEnabled = true
        return self
    }
}
