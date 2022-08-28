//
//  ContentView.swift
//  ManageUIState
//
//  Created by cm0679 on 2022/8/28.
//

import SwiftUI

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 1)) {
                self.isPlaying.toggle()
            }
        }) {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                .scaleEffect(isPlaying ? 1 : 1.5)
        }
    }
}

struct PlayerView: View {
    var episode: Episode
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            Text(episode.title)
            Text(episode.showTitle)
            PlayButton(isPlaying: $isPlaying)
        }
        .background(isPlaying ? Color.green : Color.red) // Transitions with animation.
    }
}

struct ContentView: View {
    
    @State var episode = Episode(title: "Some Episode", showTitle: "Great show", isFavorite: false)
    
    var body: some View {
        PlayerView(episode: episode)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var episode: Episode = Episode(title: "Some Episode", showTitle: "Great show", isFavorite: false)
    
    static var previews: some View {
        ContentView()
        PlayerView(episode: episode)
    }
}
