import PDFKit

public class PDFKitView: DeclarativeView {
    public var rootView: BasePDFView { pdfView }
    private let pdfView = BasePDFView()
    
    public init() {
        pdfView.backgroundColor = .clear
        pdfView.isOpaque = false
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
    }

    @discardableResult
    public func document(_ data: Data) -> Self {
        pdfView.document = PDFDocument(data: data)
        return self
    }
    
    @discardableResult
    public func document(_ base64: String) -> Self {
        guard let data = Data(base64Encoded: base64) else { return self }
        document(data)
        return self
    }
}
