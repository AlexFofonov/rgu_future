//
//  BaseViewModel.swift
//
//  AlexFofonov in 2025
//

import Foundation

protocol BaseViewModel: ObservableObject {
    associatedtype ViewState: BaseViewState
    associatedtype ViewEvent: BaseViewEvent

    var state: ViewState { get set }

    func handle(_ event: ViewEvent)
}
