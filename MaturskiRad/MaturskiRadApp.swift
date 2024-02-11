//
//  MaturskiRadApp.swift
//  MaturskiRad
//
//  Created by Platon Yakovlev on 17.12.23..
//

import SwiftUI

@main
struct MaturskiRadApp: App {
    @State private var showIntro = true

    var body: some Scene {
        WindowGroup {
            if showIntro {
                SavescreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                showIntro = false
                            }
                        }
                    }
            } else {
                TabbedView()
            }
        }
    }
}
