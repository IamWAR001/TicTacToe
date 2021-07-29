//
//  ViewController.swift
//  TicTacToe
//
//  Created by Walter A Ramirez on 7/29/21.
//

import UIKit

class TicTacToeViewController: UIViewController {

    var boardViewModel: BoardViewModel = BoardViewModel(size: 3)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "Tic-Tac-Toe"
        label.textAlignment = .center
        return label
    }()
    lazy var boardView: BoardView = {
        let boardView = BoardView(boardViewModel: self.boardViewModel)
        return boardView
    }()
    lazy var resetButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15.0
        button.addTarget(self, action: #selector(self.resetButtonSelected), for: .touchUpInside)
        return button
    }()
    lazy var dimensionPicker: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.boardViewModel.bind { [weak self] message in
            self?.presentAlert(message: message)
        }
        
        self.setUpUI()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.boardView)
        self.view.addSubview(self.resetButton)
        self.view.addSubview(self.dimensionPicker)

        self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.boardView.topAnchor, constant: -8).isActive = true
        self.boardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.boardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.boardView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.boardView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.boardView.heightAnchor.constraint(equalTo: self.boardView.widthAnchor).isActive = true
        self.resetButton.topAnchor.constraint(equalTo: self.boardView.bottomAnchor, constant: 8).isActive = true
        self.resetButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.resetButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.dimensionPicker.topAnchor.constraint(equalTo: self.resetButton.bottomAnchor, constant: 8).isActive = true
        self.dimensionPicker.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.dimensionPicker.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.dimensionPicker.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    @objc
    func resetButtonSelected() {
        self.boardViewModel = BoardViewModel(size: self.dimensionPicker.selectedRow(inComponent: 0) + 3)
        self.boardView.resetBoard(with: self.boardViewModel)
        
        self.boardViewModel.bind { [weak self] message in
            self?.presentAlert(message: message)
        }
        
        self.resetButton.setTitle("Reset", for: .normal)
    }

    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Congrats", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Koo", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.resetButton.setTitle("Play Again", for: .normal)
            }
        })
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension TicTacToeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 3)"
    }
    
}
