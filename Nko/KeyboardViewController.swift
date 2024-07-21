import Foundation
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.layoutProvider = NkoLayoutProvider()
        services.styleProvider = NkoStyleProvider(keyboardContext: state.keyboardContext)
        services.calloutActionProvider = NkoCalloutActionProvider()
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
                toolbar: { _ in  }
            )
        }
    }
}
