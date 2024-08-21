//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 20/08/2024.
//

#if canImport(MessageUI)
import SwiftUI
import MessageUI

struct MailComposerViewModifier: ViewModifier {
    @Binding var mail: Mail?
    var onDismiss: ((_ result: MFMailComposeResult) -> Void)?

    private var isPresented: Binding<Bool> {
        .init {
            mail != nil
        } set: { isPresented in
            if !isPresented {
                mail = nil
            }
        }
    }
    private var canSendEmail: Bool {
        MFMailComposeViewController.canSendMail()
    }

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: isPresented, onDismiss: {
                onDismiss?(.cancelled)
            }) {
                if canSendEmail {
                    if let mail {
                        MailComposerView(mail: mail) { result in
                            onDismiss?(result)
                        }
                    }
                } else {
                    cannotSendEmailView
                }
            }
    }

    private var cannotSendEmailView: some View {
        ContentUnavailableView(label: {
            Label("cannotSendEmail.title", systemImage: "envelope.fill")
        }, description: {
            Text("cannotSendEmail.message")
        }, actions: {
            Button {
                isPresented.wrappedValue = false
            } label: {
                Text("cannotSendEmail.okButton.title")
            }
        })
        .padding()
    }
}

public extension View {
    func mailComposer(
        mail: Binding<Mail?>,
        onDismiss: ((MFMailComposeResult) -> Void)? = nil
    ) -> some View {
        modifier(
            MailComposerViewModifier(
                mail: mail,
                onDismiss: onDismiss
            )
        )
    }
}
#endif
