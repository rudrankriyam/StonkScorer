//
//  AboutAppSectionView.swift
//  StonkScorer
//
//  Created by Alexandru Turcanu on 04/01/2020.
//  Copyright © 2020 CodingBytes. All rights reserved.
//

import SwiftUI

struct AboutAppSectionView: View {
    @Binding var isShowingSplashScreen: Bool

    var body: some View {
        let shouldAssistScoring = Binding(
            get: { UserDefaults.Keys.retrieveObject(for: .shouldAssistScoring) as? Bool ?? false},
            set: { test in UserDefaults.Keys.setObject(for: .shouldAssistScoring, with: test) }
        )

        return Section(header: Text("About the App").font(.headline)) {

            //MARK: - Splash Screen
            Button(action: {
                self.isShowingSplashScreen.toggle()
            }) {
                SettingsRowView(
                    image: Image(systemName: "book.circle.fill"),
                    imageColor: Color(UIColor.systemIndigo),
                    title: "Splash Screen"
                )
            }
            .sheet(isPresented: $isShowingSplashScreen) {
                SplashScreenView(isPresented: self.$isShowingSplashScreen,
                                 splashScreenInfo: SplashScreen.Information(version: .firstUpdate))
            }

            ZStack { //embedding the NavLink inside the ZStack and giving it an EmptyView() in order to hide the automatic disclorure indicator
                NavigationLink(destination: SavedScoresListView()
                    .environment(\.managedObjectContext, SkystoneScore.persistentContainer.viewContext)) {
                    EmptyView()
                }

                SettingsRowView(
                    image: Image(systemName: "bookmark.fill"),
                    imageColor: Color(UIColor.systemBlue),
                    title: "Saved Scores"
                )
            }

            Toggle(isOn: shouldAssistScoring) {
                SettingsRowView(
                    image: Image(systemName: "wand.and.stars"),
                    imageColor: Color(UIColor.systemYellow),
                    title: "Scorer Assist",
                    description: "Brain of the app",
                    shouldShowDisclosureIcon: false
                )
            }

            ZStack { //embedding the NavLink inside the ZStack and giving it an EmptyView() in order to hide the automatic disclorure indicator
                NavigationLink(destination: AlternateAppIconsListView()) {
                    EmptyView()
                }

                SettingsRowView(
                    image: Image(systemName: "square.stack.fill"),
                    imageColor: Color(UIColor.systemIndigo),
                    title: "App Icons"
                )
            }
        }
    }
}

struct AboutAppSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppSectionView(isShowingSplashScreen: .constant(false))
    }
}
