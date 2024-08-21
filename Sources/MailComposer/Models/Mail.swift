//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 20/08/2024.
//

import Foundation

public struct Mail {
    public var subject: String = ""
    public var to: [String]?

    public init(subject: String, to: [String]? = nil) {
        self.subject = subject
        self.to = to
    }
}
