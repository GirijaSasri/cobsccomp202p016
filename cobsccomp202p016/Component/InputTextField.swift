import SwiftUI

struct InputTextField: View {
    var title:String
    @Binding var value:String
    var keyboardType = UIKeyboardType.default
    
    var body: some View {
            TextField(title,
                      text: $value)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1.0)))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(keyboardType)
    }
}

struct InputTextField_Previews: PreviewProvider {
    @State static var name:String = ""
    static var previews: some View {
        InputTextField(
            title: "Input Text Field", value: $name
        )
    }
}
