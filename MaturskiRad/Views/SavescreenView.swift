//
//  File.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 17.12.23..
//

import SwiftUI

struct SavescreenView: View {
    @State private var offsetY: CGFloat = 300
    @State private var opacity: Double = 0

    var body: some View {
        VStack {
            VStack {
                Text("Апликација за праћење цена криптовалута")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.black)
                    .offset(y: offsetY)
                    .opacity(opacity)
                Spacer()
                Text("Матурски рад Јаковљева Платона")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .offset(y: offsetY)
                    .opacity(opacity)
                    .onAppear() {
                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                            self.offsetY = 0
                            self.opacity = 1
                        }
                    }
                Spacer()
            }
        }
    }
}


#Preview {
    SavescreenView()
}

