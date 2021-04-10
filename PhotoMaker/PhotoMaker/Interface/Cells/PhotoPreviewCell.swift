//
//  PhotoPreviewCell.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import UIKit

final class PhotoPreviewCell: UITableViewCell {
    static let reuseIdentifier = "PhotoPreviewCell"

    private let photoView = UIImageView()
    private let stackView = UIStackView()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        stackView.axis = .vertical

        photoView.layer.cornerRadius = 8
        photoView.layer.masksToBounds = true
        photoView.contentMode = .scaleAspectFill

        addSubview(photoView)
        addSubview(stackView)
        stackView.addArrangedSubview(topLabel)
        stackView.addArrangedSubview(bottomLabel)

        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate(
            [
                photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                photoView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                photoView.heightAnchor.constraint(equalToConstant: 40),
                photoView.widthAnchor.constraint(equalToConstant: 40),

                stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ]
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoPreviewCell {
    func update(with image: Image) {
        photoView.image = image.image
        topLabel.text = image.name
        bottomLabel.text = image.creationDate.description(with: .current)
    }
}
