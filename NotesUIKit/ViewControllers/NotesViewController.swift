//
//  NotesViewController.swift
//
//  Copyright © 2024 Adam Cvikl
//

import UIKit

// MARK: - NotesViewController

final class NotesViewController: UIViewController {
    private var notes: [String] = UserDefaults.standard.array(forKey: "notes") as? [String] ?? [] {
        didSet {
            UserDefaults.standard.set(self.notes, forKey: "notes")
        }
    }

    private let newNoteButton: UIButton = {
        let b: UIButton = .init()
        b.configuration = .plain()
        b.configuration?.image = .init(systemName: "plus")
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    private let table: UITableView = {
        let t: UITableView = .init(frame: .zero, style: .insetGrouped)
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        t.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.newNoteButton.addTarget(
            self,
            action: #selector(self.newNoteButtonTap),
            for: .touchUpInside
        )

        self.table.delegate = self
        self.table.dataSource = self

        self.view.addSubview(self.table)
        self.navigationItem.rightBarButtonItem = .init(customView: self.newNoteButton)
    }

    @objc
    private func newNoteButtonTap() {
        let newNoteVC: NewNoteViewController = .init()
        newNoteVC.newNoteDelegate = self

        self.present(
            UINavigationController(
                rootViewController: newNoteVC
            ),
            animated: true
        )
    }
}

// MARK: NewNoteDelegate

extension NotesViewController: NewNoteDelegate {
    func new(_ note: String) {
        self.notes.append(note)
        self.table.reloadData()
    }
}

// MARK: UITableViewDelegate

extension NotesViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        switch editingStyle {
            case .delete:
                self.notes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

            case .insert, .none:
                break

            @unknown default:
                assertionFailure()
        }
    }
}

// MARK: UITableViewDataSource

extension NotesViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        self.notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.notes[indexPath.row]
        return cell
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: NotesViewController())
}
