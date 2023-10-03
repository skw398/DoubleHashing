//
//  ContentView.swift
//  DoubleHashing
//
//  Created by Shigenari Oshio on 2023/10/03.
//

import SwiftUI
import CommonCrypto

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            TextField("Text", text: $text)
            
            Button("Double Hash (SHA-256) and Copy") {
                UIPasteboard.general.string = text.SHA256Hash()?.SHA256Hash()
            }
        }
        .padding()
    }
}

extension String {
    func SHA256Hash() -> String? {
        guard let data = self.data(using: .utf8) else { return nil }
        
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        
        return Data(hash).map { String(format: "%02x", $0) }.joined()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
