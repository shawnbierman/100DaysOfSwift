//
//  ViewController.swift
//  Project25
//
//  Created by Shawn Bierman on 5/22/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import MultipeerConnectivity
import UIKit

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {

    let projectIdentifier = "hws-project25"
    var images = [UIImage]()

    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCAdvertiserAssistant?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Selfie Share"

        setupNavbar()

        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }

    fileprivate func setupNavbar() {

        // right buttons
        let infoButton = UIButton(type: .infoLight)
            infoButton.addTarget(self, action: #selector(showConnections), for: .touchUpInside)
        let importPictureButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        let showConnectionsButton = UIBarButtonItem(customView: infoButton)
        let rightBarButtonItems = [importPictureButton, showConnectionsButton]

        // left buttons
        let connectionButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        let chatButton = UIButton(type: .contactAdd)
            chatButton.addTarget(self, action: #selector(showChatDialog), for: .touchUpInside)
        let startChatButton = UIBarButtonItem(customView: chatButton)
        let leftBarButtonItems = [connectionButton, startChatButton]

        navigationItem.rightBarButtonItems = rightBarButtonItems
        navigationItem.leftBarButtonItems = leftBarButtonItems
    }

    deinit {
        mcSession?.disconnect()
        mcAdvertiserAssistant?.stop()
    }

    func startHosting(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: projectIdentifier, discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
    }

    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: projectIdentifier, session: mcSession)
            mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }

    // -- MARK: Challenge #3
    @objc func showConnections() {
        guard let connections = mcSession else { return }
        let peers = connections.connectedPeers.map { $0.displayName }
        let ac = UIAlertController(title: "Connections \(peers.count)", message: peers.joined(separator: "\n"), preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }

    @objc func importPicture() {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
        present(picker, animated: true)
    }

    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
            ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }

    // -- MARK: Challenge #2
    @objc func showChatDialog() {
        let ac = UIAlertController(title: "Send Message", message: nil, preferredStyle: .alert)
            ac.addTextField(configurationHandler: nil)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Send", style: .default, handler: { [weak self, weak ac] _ in
                guard let text = ac?.textFields?[0].text else { return }
                self?.sendChatText(text: text)
            }))
        present(ac, animated: true)
    }

    // -- MARK: Challenge #2
    fileprivate func sendChatText(text: String) {
        guard let mcSession = mcSession else { return }

        if mcSession.connectedPeers.count > 0 {
            let textData = Data(text.utf8)
            do {
                try mcSession.send(textData, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch {
                let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(ac, animated: true)
            }
        }
    }
}

extension ViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        return cell
    }
}

extension ViewController {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)

        images.insert(image, at: 0)
        collectionView.reloadData()

        guard let mcSession = mcSession else { return }

        if mcSession.connectedPeers.count > 0 {
            if let imageData = image.pngData() {
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(ac, animated: true)
                }
            }
        }
    }
}

extension ViewController {

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) { }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) { }

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")

        case .connecting:
            print("Connecting: \(peerID.displayName)")

        case .notConnected:
            print("notConnected: \(peerID.displayName)")

            // -- MARK: Challenge #1
            let message = "\(peerID.displayName) has disconnected."
            let ac = UIAlertController(title: "Disconnection", message: message, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            DispatchQueue.main.async { [weak self] in
                self?.present(ac, animated: true)
            }

        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        DispatchQueue.main.async { [weak self] in
            if let image = UIImage(data: data) {
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
            } else {
                let ac = UIAlertController(title: "Message", message: String(data: data, encoding: .utf8), preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(ac, animated: true)
                print("received> \(String(describing: String(data: data, encoding: .utf8)))")
            }
        }
    }
}
