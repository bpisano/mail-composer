//
//  File.swift
//
//
//  Created by Benjamin Pisano on 20/08/2024.
//

import SwiftUI
import MessageUI

public struct MailComposerButton<Content: View>: View {
    private let content: Content
    private let mail: Mail
    private var onDismiss: ((MFMailComposeResult) -> Void)?

    @State private var displayedMail: Mail?

    public init(
        mail: Mail,
        @ViewBuilder _ content: () -> Content
    ) {
        self.mail = mail
        self.displayedMail = mail
        self.content = content()
    }

    public var body: some View {
        Button {
            displayedMail = mail
        } label: {
            content
        }
        .mailComposer(mail: $displayedMail, onDismiss: onDismiss)
    }

    public func onDismiss(_ completion: @escaping (MFMailComposeResult) -> Void) -> Self {
        var button: Self = self
        button.onDismiss = completion
        return button
    }
}

public extension MailComposerButton where Content == Text {
    init(
        _ title: LocalizedStringKey,
        mail: Mail
    ) {
        self.mail = mail
        self.content = Text(title)
        self.displayedMail = displayedMail
    }
}

public extension MailComposerButton where Content == Label<Text, Image> {
    init(
        _ title: LocalizedStringKey,
        image: ImageResource,
        mail: Mail
    ) {
        self.mail = mail
        self.content = Label(title, image: image)
        self.displayedMail = mail
    }
    
    init(
        _ title: LocalizedStringKey,
        systemImage: String,
        mail: Mail
    ) {
        self.mail = mail
        self.content = Label(title, systemImage: systemImage)
        self.displayedMail = mail
    }
}
