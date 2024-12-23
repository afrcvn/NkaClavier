import Foundation
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.layoutProvider = BambaraLayoutProvider()
        services.styleProvider = BambaraStyleProvider(keyboardContext: state.keyboardContext)
        services.calloutActionProvider = BambaraCalloutActionProvider()
        lazy var words: [String] = (try? Bundle.main.decode("suggestion")) ?? []
        services.autocompleteProvider = CustomAutocompleteProvider(
            context: state.autocompleteContext,
            keyboardContext: state.keyboardContext,
            words: words
        )
        
        super.viewDidLoad()
    }

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
        }
    }
}

