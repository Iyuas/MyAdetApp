//
//  HabitDetailViewController.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 09.12.2025.
//

import SnapKit
import UIKit

class HabitDetailViewController: UIViewController {
    
    private let habit: Adet
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerView: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = AppConstants.Layout.cornerRadius
        return view
    }()

    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Typography.title
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let progressRing: ProgressRingView = {
        let ring = ProgressRingView()
        ring.lineWidth = 12
        ring.showsPercentage = true
        ring.progressColor = .white
        ring.trackColor = UIColor.white.withAlphaComponent(0.3)
        return ring
    }()

    private let streakCard: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.Colors.cardBackground
        view.layer.cornerRadius = AppConstants.Layout.cornerRadius
        view.addShadow()
        return view
    }()

    private let streakTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Streak"
        label.font = AppConstants.Typography.callout
        label.textColor = AppConstants.Colors.secondaryText
        return label
    }()

    private let streakValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.textColor = AppConstants.Colors.primaryText
        return label
    }()

    private let fireLabel: UILabel = {
        let label = UILabel()
        
        label.text = "🔥"
        label.font = .systemFont(ofSize: 48)
        
        return label
    }()

    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Typography.body
        label.textColor = AppConstants.Colors.secondaryText
        return label
    }()

    private let completionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Eger bitse basynyz", for: .normal)
        button.setTitle("Buginge Bitti", for: .selected)
        button.titleLabel?.font = AppConstants.Typography.callout
        button.backgroundColor = AppConstants.Colors.accent
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = AppConstants.Layout.smallCornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        return button
    }()


    init(habit: Adet) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureWithHabit()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Habit Details"

        setupUI()
        configureWithHabit()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(headerView)
        headerView.addSubview(habitNameLabel)
        headerView.addSubview(progressRing)

        contentView.addSubview(streakCard)
        streakCard.addSubview(streakTitleLabel)
        streakCard.addSubview(streakValueLabel)
        streakCard.addSubview(fireLabel)

        contentView.addSubview(startDateLabel)
        contentView.addSubview(completionButton)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppConstants.Spacing.l)
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
            make.height.equalTo(200)
        }

        habitNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(AppConstants.Spacing.l)
            make.trailing.equalTo(progressRing.snp.leading).offset(-AppConstants.Spacing.m)
        }

        progressRing.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-AppConstants.Spacing.l)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(120)
        }

        streakCard.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(AppConstants.Spacing.l)
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
            make.height.equalTo(150)
        }

        streakTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppConstants.Spacing.l)
            make.leading.equalToSuperview().offset(AppConstants.Spacing.l)
        }

        streakValueLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(AppConstants.Spacing.l)
            make.top.equalTo(streakTitleLabel.snp.bottom).offset(AppConstants.Spacing.s)
        }

        fireLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-AppConstants.Spacing.l)
            make.centerY.equalToSuperview()
        }

        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(streakCard.snp.bottom).offset(AppConstants.Spacing.l)
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
        }

        completionButton.snp.makeConstraints { make in
            make.top.equalTo(startDateLabel.snp.bottom).offset(AppConstants.Spacing.xl)
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-AppConstants.Spacing.xl)
        }

        completionButton.addTarget(self, action: #selector(toggleCompletion), for: .touchUpInside)
    }


    private func configureWithHabit() {
        habitNameLabel.text = habit.name ?? "Aty joq"

        let streak = Int(habit.streak)
        let goalDaysRaw = Int(habit.goalDays)
        
        let goalDays: Int
        if goalDaysRaw > 0 {
            goalDays = goalDaysRaw
        } else {
            goalDays = 1
        }

        streakValueLabel.text = "\(streak)/\(goalDays)"

        let progress: CGFloat
        if goalDaysRaw > 0 {
            progress = min(CGFloat(streak) / CGFloat(goalDays), 1.0)
        } else {
            progress = 0
        }

        progressRing.setProgress(progress, animated: true)

        if progress >= 1.0 {
            headerView.colors = AppConstants.Colors.successGradient
        } else if progress >= 0.5 {
            headerView.colors = AppConstants.Colors.secondaryGradient
        } else {
            headerView.colors = AppConstants.Colors.primaryGradient
        }

        if let date = habit.date {
            let daysAgo = date.daysAgo()
            if goalDaysRaw > 0 {
                startDateLabel.text = "Bastaldy \(daysAgo) kun buryn • Maqsat: \(goalDays) kun"
            } else {
                startDateLabel.text = "Bastaldy \(daysAgo) kun buryn • Maqsat qoiylmady"
            }
        } else {
            startDateLabel.text = goalDaysRaw > 0 ? "Maqsat: \(goalDays) kun" : "Maqsat qoiylmady"
        }

        completionButton.isSelected = habit.completed

        headerView.alpha = 0
        streakCard.alpha = 0

        UIView.animate(
            withDuration: 0.6,
            delay: 0.1,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5
        ) {
            self.headerView.alpha = 1
        }

        UIView.animate(
            withDuration: 0.6,
            delay: 0.2,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5
        ) {
            self.streakCard.alpha = 1
        }
    }

    @objc private func toggleCompletion() {

        let goal = Int(habit.goalDays)

        habit.completed.toggle()

        if habit.completed {
            if habit.streak < goal {
                habit.streak += 1
                completionButton.pop()
            }
        }

        completionButton.isSelected = habit.completed
        CoreDataManager.shared.saveContext()

        configureWithHabit()
    }
}
