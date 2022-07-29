//
//  ContentView.swift
//  Hacker News Reader
//
//  Created by user220431 on 7/28/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var selectedTab = 0
    
    var body: some View {
            NavigationView {
                ZStack {
                    
                TabView(selection: $selectedTab) {
                    PostList(postList: networkManager.posts)
                        .tabItem {
                            Label("Front Page", systemImage: "newspaper")
                                
                        }.tag(0)
                    PostList(postList: networkManager.posts)
                        .tabItem {
                            Label("New Posts", systemImage: "envelope")
                        }
                        .tag(1)
                        
                }
                
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                .navigationTitle("H4X0R NEWS")
                }
                            }
           

            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                getDataForView()
            }
        .id(selectedTab)
        
    }
    
    func getDataForView() {
        switch selectedTab {
            case 0:
                self.networkManager.fetchFrontPageStories()
            case 1:
                self.networkManager.fetchNewStories()
            default:
                self.networkManager.fetchFrontPageStories()
        }
    }
}
    
struct PostList: View {
    let postList: [Post]
    
    var body: some View {
        
        List(postList) {post in
            NavigationLink(destination: DetailView(url: post.url)) {
                HStack (alignment: .center, spacing: 10.0) {
                    VStack(alignment: .leading, spacing: 1.0) {
                    Text(String(post.points))
                        .foregroundColor(Color.green)
                    }
                    Text(post.title)
                        .foregroundColor(Color.green)
                    
                }
            }
            .listRowBackground(Color.black)
            .padding()
            .listRowSeparator(.visible)
            .listRowSeparatorTint(Color.white, edges: .all)
        }
        .listStyle(.inset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



