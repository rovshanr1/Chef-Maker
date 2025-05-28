//
//  CustomInputField.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 09.04.25.
//
import SwiftUI

struct CustomInputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var submitLabel: SubmitLabel = .done
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(AppColors.adaptiveText(for: colorScheme))
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textContentType(.password)
                    .textFieldStyle(CustomTextFieldStyle())
                    .submitLabel(submitLabel)
                    .tint(AppColors.adaptiveAccent(for: colorScheme))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .textFieldStyle(CustomTextFieldStyle())
                    .submitLabel(submitLabel)
                    .tint(AppColors.adaptiveAccent(for: colorScheme))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(textContentType == .emailAddress ? .never : .words)
            }
        }
    }
}


