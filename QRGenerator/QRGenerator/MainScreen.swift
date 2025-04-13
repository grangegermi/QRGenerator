//
//  MainScreen.swift
//  QRGenerator
//

import SwiftUI

enum Mode {
    case generation
    case library
    case settings

    var label: Label<Text, Image> {
        switch self {
        case .generation:
            return Label("Generator", systemImage: "qrcode")
        case .library:
            return Label("Library", systemImage: "books.vertical")
        case .settings:
            return Label("Settings", systemImage: "gear")
        }
    }

    var title: LocalizedStringKey {
        switch self {
        case .generation:
            return "Generator"
        case .library:
            return "Library"
        case .settings:
            return "Settings"
        }
    }
}

struct MainScreen: View {
    @State private var selectedTab: Mode = .generation

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                GeneratorScreen()
                    .tabItem { Mode.generation.label }
                    .tag(Mode.generation)

                Library()
                    .tabItem { Mode.library.label }
                    .tag(Mode.library)

                SettingsView()
                    .tabItem { Mode.settings.label }
                    .tag(Mode.settings)
            }
            .navigationTitle(selectedTab.title)
        }
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings View")
    }
}

#Preview {
    MainScreen()
}
