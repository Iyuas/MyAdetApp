//
//  CalendarViewController.swift
//  MyAdetApp
//
//  Created by Serdaly Muhammed on 09.12.2025.
//

import UIKit
import CoreData

final class CalendarViewController: UIViewController {

    private let calendarView = UICalendarView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private var habits: [Adet] = []
    private var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calendar"
        view.backgroundColor = .systemBackground

        setupCalendar()
        setupTableView()
        fetchHabits()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchHabits()
        let _: [DateComponents] = habits.compactMap { habit in
            guard let date = habit.date else { return nil }
            return Calendar.current.dateComponents([.year, .month, .day], from: date)
        }

    }

    private func setupCalendar() {
        calendarView.calendar = Calendar.current
        calendarView.locale = .current
        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)

        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 360)
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    private func fetchHabits() {
        habits = CoreDataManager.shared.fetchHabits()
        tableView.reloadData()
    }

    private func habits(for date: Date) -> [Adet] {
        let calendar = Calendar.current
        return habits.filter {
            guard let habitDate = $0.date else { return false }
            return calendar.isDate(habitDate, inSameDayAs: date)
        }
    }
}

extension CalendarViewController: UICalendarViewDelegate {

    func calendarView(
        _ calendarView: UICalendarView,
        decorationFor dateComponents: DateComponents
    ) -> UICalendarView.Decoration? {

        guard let date = Calendar.current.date(from: dateComponents) else {
            return nil
        }

        let hasHabit = habits.contains {
            guard let habitDate = $0.date else { return false }
            return Calendar.current.isDate(habitDate, inSameDayAs: date)
        }

        return hasHabit ? .default(color: .systemGreen) : nil
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {

    func dateSelection(
        _ selection: UICalendarSelectionSingleDate,
        didSelectDate dateComponents: DateComponents?
    ) {
        guard let dateComponents,
              let date = Calendar.current.date(from: dateComponents)
        else { return }

        selectedDate = date
        tableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedDate else { return 0 }
        return habits(for: selectedDate).count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let selectedDate else { return cell }
        let habit = habits(for: selectedDate)[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = habit.name ?? "Aty joq"
        content.secondaryText = "Started this day"

        cell.contentConfiguration = content
        return cell
    }
}
