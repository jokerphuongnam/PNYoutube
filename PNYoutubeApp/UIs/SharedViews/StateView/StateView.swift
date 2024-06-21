//
//  StateView.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import SwiftUI

struct StateView<T, ContentView>: View where T: Hashable, ContentView: View {
    @Binding private var state: Resource<T>
    private let loadingView: (() -> AnyView)?
    private let contentView: (_ data: T) -> ContentView
    private let errorView: ((_ error: Error) -> AnyView)?
    
    init(state: Binding<Resource<T>>, @ViewBuilder contentView: @escaping (_ data: T) -> ContentView) {
        self._state = state
        self.contentView = contentView
        self.loadingView = nil
        self.errorView = nil
    }
    
    var body: some View {
        switch state {
        case .loading:
            if let loadingView {
                loadingView()
            } else {
                ProgressView()
            }
        case .success(let data):
            contentView(data)
        case .error(let error):
            if let errorView {
                errorView(error)
            } else {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
        }
    }
}

extension StateView {
    init<LoadingView>(state: Binding<Resource<T>>, @ViewBuilder contentView: @escaping (_ data: T) -> ContentView, @ViewBuilder loadingView: @escaping () -> LoadingView) where LoadingView: View {
        self._state = state
        self.contentView = contentView
        self.loadingView = {
            AnyView(loadingView())
        }
        self.errorView = nil
    }
    
    init<ErrorView>(state: Binding<Resource<T>>, @ViewBuilder contentView: @escaping (_ data: T) -> ContentView, @ViewBuilder errorView: @escaping (_ error: Error) -> ErrorView) where ErrorView: View {
        self._state = state
        self.contentView = contentView
        self.errorView = { error in
            AnyView(errorView(error))
        }
        self.loadingView = nil
    }
    
    init<LoadingView, ErrorView>(state: Binding<Resource<T>>, @ViewBuilder contentView: @escaping (_ data: T) -> ContentView, @ViewBuilder loadingView: @escaping () -> LoadingView, @ViewBuilder errorView: @escaping (_ error: Error) -> ErrorView) where LoadingView: View, ErrorView: View {
        self._state = state
        self.contentView = contentView
        self.loadingView = {
            AnyView(loadingView())
        }
        self.errorView = { error in
            AnyView(errorView(error))
        }
    }
}

#Preview {
    StateView(state: .constant(.success(data: 0))) { data in
        Text("\(data)")
    }
}
