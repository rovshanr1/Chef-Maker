//
//  CustomInputField.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 09.04.25.
//
import SwiftUI

enum FieldFocuse {
    case name, email, password
}

struct CustomInputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var submitLabel: SubmitLabel = .done
    @FocusState var focusedField: FieldFocuse?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(AppColors.adaptiveText)
            
            if isSecure {
                SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(AppColors.adaptiveText.opacity(0.4))
                    }
                    .textContentType(.password)
                    .textFieldStyle(CustomTextFieldStyle())
                    .submitLabel(submitLabel)
                    .tint(AppColors.adaptiveAccent)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            } else {
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(AppColors.adaptiveText)
                    }
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .textFieldStyle(CustomTextFieldStyle())
                    .submitLabel(submitLabel)
                    .tint(AppColors.adaptiveAccent)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(textContentType == .emailAddress ? .never : .words)
            }
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
