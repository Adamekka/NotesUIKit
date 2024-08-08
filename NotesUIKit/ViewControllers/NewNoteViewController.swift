//
//  NewNoteViewController.swift
//
//  Copyright © 2024 Adam Cvikl
//

import UIKit

final class NewNoteViewController: UIViewController {
    weak var newNoteDelegate: NewNoteDelegate?

    private let textField: UITextField = {
        let tf: UITextField = .init()
        tf.placeholder = "Enter note text"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let submitButton: UIButton = {
        let b: UIButton = .init()
        b.setTitle(" Create ", for: .normal)
        b.backgroundColor = .systemBlue
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 8
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "New Note"
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(self.textField)
        self.view.addSubview(self.submitButton)

        self.submitButton.addTarget(
            self,
            action: #selector(self.createNote),
            for: .touchUpInside
        )

        NSLayoutConstraint.activate([
            self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.submitButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
        ])
    }

    @objc
    private func createNote() {
        self.newNoteDelegate?.new(self.textField.text ?? "")
        self.dismiss(animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: NewNoteViewController())
}
