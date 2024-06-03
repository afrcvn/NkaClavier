import SwiftUI

struct PopButton<Content: View>: View {
    var title: String
    var systemImage: String?
    @State var isPresented: Bool = false
    var content: (Binding<Bool>) -> Content
    var label: AnyView?
    
    init(
        _ title: String,
        systemImage: String? = nil,
        @ViewBuilder content: @escaping (Binding<Bool>) -> Content
    ) {
        self.title = title
        self.systemImage = systemImage
        self.content = content
    }
    
    init(
        @ViewBuilder label: @escaping () -> some View,
        @ViewBuilder content: @escaping (Binding<Bool>) -> Content
    ) {
        self.title = ""
        self.systemImage = nil
        self.label = AnyView(label())
        self.content = content
    }
    
    var body: some View {
        Button { isPresented.toggle() } label: {
            Group {
                if let label {
                    label
                } else if let systemImage {
                    Label(title, systemImage: systemImage)
                } else {
                    Text(title)
                }
            }
            .popover(isPresented: $isPresented) {
                content($isPresented)
                    .presentationCompactAdaptation(.none)
                    .presentationBackground(.clear)
            }

        }
    }
}

struct PopoverContainer: Layout {
    /// Calculates the size that fits for the subview based on the proposal.
    /// - Parameters:
    ///   - proposal: The proposed view size.
    ///   - subviews: The subviews contained within this layout.
    ///   - cache: A cache used for layout calculations.
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard subviews.count == 1 else {
            fatalError("PopoverContainer should contain exactly one subview.")  // Ensure there's only one subview.
        }
        
        // Adjust the proposed width and height if needed.
        var p = proposal
        p.width = min(p.width ?? UIScreen.main.bounds.width, 350)
        p.height = p.height ?? UIScreen.main.bounds.height

        return subviews[0].sizeThatFits(p)  // Calculate the fitting size for the subview.
    }
    
    /// Places the subviews within the given bounds.
    /// - Parameters:
    ///   - bounds: The bounds in which to place the subviews.
    ///   - proposal: The proposed view size.
    ///   - subviews: The subviews contained within this layout.
    ///   - cache: A cache used for layout calculations.
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Since there's only one subview, place it within the given bounds.
    }
}

