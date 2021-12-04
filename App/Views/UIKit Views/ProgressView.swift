//
//  ProgressView.swift
//  Authenticator
//
//  Created by Cassio Diego T. Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego T. Campos. All rights reserved.
//

import UIKit
import SwiftUI

struct ProgressView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ProgressView>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ProgressView>) {
        uiView.startAnimating()
    }
}
