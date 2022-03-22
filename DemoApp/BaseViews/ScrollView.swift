import DeclarativeUI

class ScrollViewController: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    @ObservableProperty var rows = Array(repeating: "Opções", count: 40)

    lazy var view = StackView(.vertical) {
        ScrollView(.vertical) {
            StackView(.vertical) {
                Spacer(.small)
                SearchBar()
                .placeholder("Placeholder")
                .changeEditing { searchBar in
                    print(searchBar.text())
                }
                .shouldReturn { searchBar in
                    searchBar.endEditing(true)
                }
                Spacer(.medium)
                SegmentedControl(["Option 1", "Option 2"])
                    .didChangeValue{ index in
                        print(index)
                    }
                .padding(.horizontal(.small))
                Spacer(.medium)
                TextFieldAnimated()
                .placeholder("Placeholder")
                .changeEditing { textField in
                    print(textField.text())
                }
                .shouldReturn { textField in
                    textField.endEditing(true)
                }
                Spacer(.small)
                SearchBar()
                .placeholder("Placeholder")
                .changeEditing { searchBar in
                    print(searchBar.text())
                }
                .shouldReturn { searchBar in
                    searchBar.endEditing(true)
                }
                Spacer(.medium)
                SegmentedControl(["Option 1", "Option 2"])
                    .didChangeValue{ index in
                        print(index)
                    }
                .padding(.horizontal(.small))
                Spacer(.medium)
                TextFieldAnimated()
                .placeholder("Placeholder")
                .changeEditing { textField in
                    print(textField.text())
                }
                .shouldReturn { textField in
                    textField.endEditing(true)
                }
                Spacer(.small)
                SearchBar()
                .placeholder("Placeholder")
                .changeEditing { searchBar in
                    print(searchBar.text())
                }
                .shouldReturn { searchBar in
                    searchBar.endEditing(true)
                }
                Spacer(.medium)
                SegmentedControl(["Option 1", "Option 2"])
                    .didChangeValue{ index in
                        print(index)
                    }
                .padding(.horizontal(.small))
                Spacer(.medium)
                TextFieldAnimated()
                .placeholder("Placeholder")
                .changeEditing { textField in
                    print(textField.text())
                }
                .shouldReturn { textField in
                    textField.endEditing(true)
                }
                Spacer(.medium)
                PickerView {
                    rows
                }.didSelectRow{ value in
                    print(value)
                }
                Spacer(.medium)
                Pager(["Option 1", "Option 2", "Option 3"])
                    .didChangeValue{ index in
                        print(index)
                    }
                Spacer(.medium)
                Label(style: .systemFont())
                    .text("Text")
                    .padding(.horizontal(.small))
                Spacer(.medium)
                Label(style: .boldSystemFont())
                    .text("Text")
                    .padding(.horizontal(.small))
                Spacer(.flexible)
            }
        }.padding(.horizontal(.zero))
    }
}
