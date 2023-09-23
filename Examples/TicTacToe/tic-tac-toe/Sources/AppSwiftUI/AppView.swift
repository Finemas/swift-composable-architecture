import AppCore
import ComposableArchitecture
import LoginSwiftUI
import NewGameSwiftUI
import SwiftUI

public struct AppView: View {
  @State var store: StoreOf<TicTacToe>

  public init(store: StoreOf<TicTacToe>) {
    self.store = store
  }

  public var body: some View {
    switch self.store.state {
    case .login:
      // self.store.scope(#feature(\.login)).map { store in
      if let store = self.store.scope(state: \.login, action: { .login($0) }) {
        NavigationStack {
          LoginView(store: store)
        }
      }
    case .newGame:
      if let store = self.store.scope(state: \.newGame, action: { .newGame($0) }) {
        NavigationStack {
          NewGameView(store: store)
        }
      }
    }
  }
}
