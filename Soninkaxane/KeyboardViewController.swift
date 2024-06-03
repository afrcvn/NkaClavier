//
//  KeyboardViewController.swift
//  Soninkaxane
//
//  Created by Samba Diawara on 2024-06-03.
//

import Foundation
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.layoutProvider = SoninkeLayoutProvider()
        services.styleProvider = SoninkeStyleProvider(keyboardContext: state.keyboardContext)
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
