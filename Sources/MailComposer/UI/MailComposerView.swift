//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 20/08/2024.
//

#if canImport(MessageUI)
import SwiftUI
import MessageUI

struct MailComposerView: UIViewControllerRepresentable {
    let mail: Mail
    var result: (MFMailComposeResult) -> Void

    @Environment(\.presentationMode) private var presentationMode

    static var canSendEmail: Bool {
        MFMailComposeViewController.canSendMail()
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let composer: MFMailComposeViewController = MFMailComposeViewController()
        composer.mailComposeDelegate = context.coordinator
        composer.setSubject(mail.subject)
        composer.setToRecipients(mail.to)
        return composer
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension MailComposerView {
    internal class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposerView

        init(_ parent: MailComposerView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.result(result)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
#endif
