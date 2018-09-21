//
//  EventsListViewController.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal final class EventsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet { tableView.register(EventCell.self) }
    }
    
    private let presenter: EventsListPresenter
    
    init (presenter: EventsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onUpdate = { [weak self] in
            self?.configure()
        }
        presenter.load()
    }
    
    private func configure() {
        title = presenter.title
        tableView.reloadData()
    }
}

extension EventsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: presenter.itemPresenter(at: indexPath))
        return cell
    }
}

extension EventsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
