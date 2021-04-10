//
//  HomeViewController.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/9/21.
//

import UIKit

class HomeViewController: UIViewController {
    private let stackView = UIStackView()
    private let makeButton = UIButton()
    private let viewButton = UIButton()

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()

        makeButton.setTitle("Take the photo", for: .normal)
        makeButton.setTitleColor(.white, for: .normal)
        makeButton.backgroundColor = .black
        makeButton.layer.cornerRadius = 12

        viewButton.setTitle("View photos", for: .normal)
        viewButton.setTitleColor(.white, for: .normal)
        viewButton.backgroundColor = .black
        viewButton.layer.cornerRadius = 12
    }

    private func setupViews() {
        stackView.spacing = 32
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white

        makeButton.addTarget(
            self,
            action: #selector(onMakeButtonTapped),
            for: .touchUpInside
        )

        viewButton.addTarget(
            self,
            action: #selector(onViewButtonTapped),
            for: .touchUpInside
        )
    }

    private func setupHierarchy() {
        view.addSubview(stackView)

        stackView.addArrangedSubview(makeButton)
        stackView.addArrangedSubview(viewButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                makeButton.heightAnchor.constraint(equalToConstant: 88),
                viewButton.heightAnchor.constraint(equalToConstant: 88)
            ]
        )
    }
}

extension HomeViewController {
    @objc private func onMakeButtonTapped() {
        viewModel.onMakePhoto()
    }

    @objc private func onViewButtonTapped() {
        viewModel.onViewPhotos()
    }
}

