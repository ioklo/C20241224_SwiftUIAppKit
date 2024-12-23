//
//  NSViewControllerRepresentable.swift
//  HelloSwiftUI
//
//  Created by Kyuhyun Park on 12/23/24.
//

import SwiftUI
import AppKit

fileprivate struct Representable: NSViewControllerRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    func makeNSViewController(context: Context) -> Controller {
        Controller(delegate: context.coordinator)
    }

    func updateNSViewController(_ controller: Controller, context: Context) {
        controller.textView.string = text
    }
    
    @MainActor
    protocol MyDelegate {
        func textChanged(text: String)
    }

    class Controller: NSViewController, NSTextViewDelegate {
        var textView: NSTextView!
        var delegate: MyDelegate
        
        init(delegate: MyDelegate) {
            self.delegate = delegate
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func loadView() {
            let container = NSView()

            let textView = NSTextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.delegate = self
            
            self.textView = textView
            container.addSubview(textView)

            NSLayoutConstraint.activate([
                textView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                textView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                textView.topAnchor.constraint(equalTo: container.topAnchor),
                textView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])

            self.view = container
        }
        
        func textDidChange(_ notification: Notification) {
            self.delegate.textChanged(text: textView.string)
        }
    }
    
    @MainActor
    class Coordinator: NSObject, MyDelegate  {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        // AppKit 데이터를 SwiftUI 데이터로.
        func textChanged(text: String) {
            self.text = text
        }
    }
}

struct NSViewControllerRepresentableDemo: View {
    @State private var text:String = "Hello"
    
    var body: some View {
        VStack {
            Text("NSViewControllerRepresentable Demo")
                .font(.title)
                .padding()

            Text(text)
                .font(.title3)
                .padding()

            Representable(text: $text)
                .frame(width: 200, height: 80)
        }
        .padding()
    }
}

#Preview {
    NSViewControllerRepresentableDemo()
}
