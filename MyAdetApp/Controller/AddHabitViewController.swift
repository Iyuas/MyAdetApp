//
//  AddHabitViewController.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 09.12.2025.
//

import CoreData
import SnapKit
import UIKit

class AddHabitViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerView: GradientView = {
        let view = GradientView()
        view.colors = AppConstants.Colors.primaryGradient
        view.layer.cornerRadius = AppConstants.Layout.cornerRadius
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Jana Adet"
        label.font = AppConstants.Typography.title
        label.textColor = .white
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ádet Aty + maksat(kun)"
        label.font = AppConstants.Typography.caption
        label.textColor = .white
        label.alpha = 0.9
        return label
    }()

    private let formCard: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.Colors.cardBackground
        view.layer.cornerRadius = AppConstants.Layout.cornerRadius
        view.addShadow()
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Adet aty"
        label.font = AppConstants.Typography.callout
        label.textColor = AppConstants.Colors.primaryText
        return label
    }()

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Adet aty"
        tf.borderStyle = .none
        tf.font = AppConstants.Typography.body
        tf.autocorrectionType = .no
        tf.backgroundColor = UIColor.systemGray6
        tf.layer.cornerRadius = AppConstants.Layout.smallCornerRadius
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        tf.leftViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        tf.rightViewMode = .always
        return tf
    }()

    private let goalLabel: UILabel = {
        let label = UILabel()
        label.text = "Kundik Maqsat"
        label.font = AppConstants.Typography.callout
        label.textColor = AppConstants.Colors.primaryText
        return label
    }()

    private let goalTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Mysaly: 5"
        tf.borderStyle = .none
        tf.font = AppConstants.Typography.body
        tf.autocorrectionType = .no
        tf.backgroundColor = UIColor.systemGray6
        tf.layer.cornerRadius = AppConstants.Layout.smallCornerRadius
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        tf.leftViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        tf.rightViewMode = .always
        tf.keyboardType = .numberPad
        return tf
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Quru", for: .normal)
        button.titleLabel?.font = AppConstants.Typography.callout
        button.backgroundColor = AppConstants.Colors.accent
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = AppConstants.Layout.smallCornerRadius
        button.addShadow(radius: 12, opacity: 0.3)
        button.addTarget(self, action: #selector(saveHabitTapped), for: .touchUpInside)
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Qaitu", for: .normal)
        button.titleLabel?.font = AppConstants.Typography.callout
        button.setTitleColor(AppConstants.Colors.secondaryText, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Habit"
        view.backgroundColor = .systemBackground
        setupUI()
        hideKeyboardOnTap()
        animateViewsIn()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(subtitleLabel)

        contentView.addSubview(formCard)
        formCard.addSubview(nameLabel)
        formCard.addSubview(nameTextField)
        formCard.addSubview(goalLabel)
        formCard.addSubview(goalTextField)

        contentView.addSubview(saveButton)
        contentView.addSubview(cancelButton)

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
            make.height.equalTo(120)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(AppConstants.Spacing.l)
            make.trailing.equalToSuperview().offset(-AppConstants.Spacing.l)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(AppConstants.Spacing.xs)
            make.trailing.equalToSuperview().offset(-AppConstants.Spacing.l)
        }

        formCard.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(AppConstants.Spacing.l)
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppConstants.Spacing.l)
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(AppConstants.Spacing.s)
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
            make.height.equalTo(50)
        }

        goalLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
            make.top.equalTo(nameTextField.snp.bottom).offset(AppConstants.Spacing.l)
        }

        goalTextField.snp.makeConstraints { make in
            make.top.equalTo(goalLabel.snp.bottom).offset(AppConstants.Spacing.s)
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-AppConstants.Spacing.l)
        }

        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(AppConstants.Spacing.l)
            make.top.equalTo(formCard.snp.bottom).offset(AppConstants.Spacing.xl)
            make.height.equalTo(56)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(AppConstants.Spacing.m)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-AppConstants.Spacing.xl)
        }

        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }

    @objc private func saveHabitTapped() {
        let name = (nameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if name.isEmpty {
            nameTextField.shake()
            return
        }

        let goalText = (goalTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let goal = Int32(goalText) ?? 0
        if goal <= 0 {
            goalTextField.shake()
            return
        }

        UIView.animate(withDuration: 0.1, animations: {
            self.saveButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.saveButton.transform = .identity
            }
        }

        CoreDataManager.shared.saveNewHabit(name: name, goalDays: goal)

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        navigationController?.popViewController(animated: true)
    }

    @objc private func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func animateViewsIn() {
        headerView.alpha = 0
        formCard.alpha = 0
        saveButton.alpha = 0
        cancelButton.alpha = 0

        headerView.transform = CGAffineTransform(translationX: 0, y: -20)
        formCard.transform = CGAffineTransform(translationX: 0, y: 20)

        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.headerView.alpha = 1
            self.headerView.transform = .identity
        }

        UIView.animate(withDuration: 0.6, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.formCard.alpha = 1
            self.formCard.transform = .identity
        }

        UIView.animate(withDuration: 0.4, delay: 0.3) {
            self.saveButton.alpha = 1
            self.cancelButton.alpha = 1
        }
    }
}
