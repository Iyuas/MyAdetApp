//
//  HabitListViewController.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 09.12.2025.
//

import UIKit
import CoreData

final class HabitListViewController: UIViewController {

    private let headerView: GradientView = {
        let v = GradientView()
        v.colors = AppConstants.Colors.primaryGradient
        return v
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Menin Ádetterim"
        label.shadowColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private let quoteLabel: UILabel = {
        let l = UILabel()
        l.font = AppConstants.Typography.caption
        l.textColor = .white
        l.alpha = 0.9
        l.numberOfLines = 4
        l.text = "oilanuda kutiniz..."
        return l
    }()

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var habits: [Adet] = []

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Ádetter joq!\n \"+\" Jańadan qurynyz"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = ""

        setupNavBar()
        setupLayout()
        setupTableView()
        
        loadHabits()
        loadMotivationalQuote()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHabits()
    }

    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addHabit)
        )
    }

    private func setupLayout() {
        view.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(quoteLabel)

        view.addSubview(tableView)
        view.addSubview(emptyLabel)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 230),

            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: AppConstants.Spacing.l),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 72),

            quoteLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: AppConstants.Spacing.l),
            quoteLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -AppConstants.Spacing.l),
            quoteLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -80),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear

        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }

    @objc private func addHabit() {
        let vc = AddHabitViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func loadHabits() {
        habits = CoreDataManager.shared.fetchHabits()
        tableView.reloadData()
        emptyLabel.isHidden = !habits.isEmpty
    }

    private func loadMotivationalQuote() {
        NetworkManager.shared.fetchRandomQuote { [weak self] quote in
            guard let self else { return }
            guard let first = quote.first else { return }

            self.quoteLabel.text = "“\(first.q)”\n— \(first.a)"
            self.quoteLabel.alpha = 0

            UIView.animate(withDuration: 0.4) {
                self.quoteLabel.alpha = 0.9
            }
        }
    }

    private func deleteHabit(at indexPath: IndexPath) {
        let habit = habits[indexPath.row]
        CoreDataManager.shared.mainContext.delete(habit)
        CoreDataManager.shared.saveContext()

        habits.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        emptyLabel.isHidden = !habits.isEmpty
    }
}

extension HabitListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        habits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let habit = habits[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = habit.name ?? "Aty joq"

        let goal = Int(habit.goalDays)
        if let date = habit.date {
            if goal > 0 {
                content.secondaryText = "Maqsat: \(goal) kun • Bastaldy: \(date.formatted())"
            } else {
                content.secondaryText = "Bastaldy: \(date.formatted())"
            }
        } else {
            content.secondaryText = goal > 0 ? "Maqsat: \(goal) kun" : nil
        }

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension HabitListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let habit = habits[indexPath.row]
        let vc = HabitDetailViewController(habit: habit)
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .destructive, title: "Joyu") { [weak self] _, _, done in
            self?.deleteHabit(at: indexPath)
            done(true)
        }
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
