//
//  FoldersViewController.swift
//  Milestone8
//
//  Created by Shawn Bierman on 5/5/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class FoldersViewController: BaseTableViewController {

    var dialog: UIAlertController?
    var folders = [Folder]() {
        didSet {
            if !folders.isEmpty { navigationItem.rightBarButtonItem?.isEnabled = true }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Folders"
        setupNavigationAndToolBar()
    }

    @objc internal func editTapped() {
        guard let barItem = navigationItem.rightBarButtonItem else { return }
        if barItem.isEqual(UIBarButtonItem.SystemItem.edit) {
            print("It is")
        } else {
            print("It isn't")
        }
//        if navigationItem.rightBarButtonItem?.Sys == UIBarButtonItem.SystemItem.edit {
//            tableView.setEditing(true, animated: true)
//        } else {
//            tableView.setEditing(false, animated: true)
//        }
    }

    @objc internal func addFolder() {
        dialog = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)
        dialog?.addTextField { [weak self] (textfield) in
            textfield.placeholder = "Name"
            textfield.autocapitalizationType = .sentences
            textfield.addTarget(self, action: #selector(self?.alertTextFieldDidChange(_:)), for: .editingChanged)
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default, handler: { [weak self, weak dialog] (_) in
            let folder = dialog?.textFields?[0].text ?? "unknown"
            self?.folders.append(Folder(id: UUID().uuidString, name: folder))
        })

        cancel.setValue(UIColor.gold, forKey: "titleTextColor")
        save.setValue(UIColor.gold, forKey: "titleTextColor")
        save.isEnabled = false

        dialog?.addAction(cancel)
        dialog?.addAction(save)

        present(dialog!, animated: true)
    }

    @objc internal func alertTextFieldDidChange(_ sender: UITextField) {
        dialog?.actions[1].isEnabled = sender.text!.count > 0
    }

    fileprivate func setupNavigationAndToolBar() {
        let rightBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = rightBtn
        navigationItem.rightBarButtonItem?.tintColor = .gold
        navigationItem.rightBarButtonItem?.style = UIBarButtonItem.Style.done
        navigationItem.rightBarButtonItem?.isEnabled = false

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let folderBtn = UIBarButtonItem(title: "New Folder", style: .done, target: self, action: #selector(addFolder))
        folderBtn.tintColor = .gold

        toolbarItems = [spacer, folderBtn]
        navigationController?.setToolbarHidden(false, animated: true)
    }
}

extension FoldersViewController {

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return folders.count }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = NotesViewController()
        controller.title = folders[indexPath.row].name
        navigationController?.pushViewController(controller, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let folder = folders[indexPath.row]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .clear
            cell.textLabel?.text = folder.name
            cell.detailTextLabel?.text = "0"
        return cell
    }
}
