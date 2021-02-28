//
//  ViewController.swift
//  Testable
//
//  Created by Fernando Martín Ortiz on 27/02/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var subButton: UIButton!
    
    let viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueLabel.accessibilityIdentifier = "value_label"
        addButton.accessibilityIdentifier = "add_button"
        subButton.accessibilityIdentifier = "sub_button"
        
        viewModel.$value
            .map { $0.description }
            .assign(to: \.text, on: valueLabel)
            .store(in: &cancellables)
    }

    @IBAction private func addButtonPressed() {
        viewModel.add()
    }
    
    @IBAction private func subButtonPressed() {
        viewModel.sub()
    }
}

final class ViewModel {
    @Published private(set) var value = 0
    
    func add() {
        value += 1
    }
    
    func sub() {
        value -= 1
    }
}
