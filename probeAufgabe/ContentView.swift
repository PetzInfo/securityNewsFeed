// ContentView.swift
// probeaufgabe
// created by Friedrich Commichau
// 10.06.2024

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading news...")
                } else if viewModel.news.isEmpty {
                    Text("No news available.")
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) { // spacing to avoid lines between items
                            ForEach(viewModel.news.indices, id: \.self) { index in
                                NewsRowView(newsItem: viewModel.news[index])
                                    .onTapGesture {
                                        viewModel.markAsRead(at: index)
                                    }
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        viewModel.loadNews()
                    }
                    Text("Last updated: \(viewModel.lastUpdate?.formatted() ?? "Never")")
                        .font(.footnote)
                        .padding()
                }
            }
            .navigationTitle("Nachrichten")
            .onAppear {
                viewModel.loadNews()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
