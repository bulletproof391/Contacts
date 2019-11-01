//
//  LoaderView.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 01/11/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import SnapKit
import UIKit

final class LoaderView: UIView {

    private let activityIndicatorView = UIActivityIndicatorView()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func startAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.startAnimating()
            self?.isHidden = false
        }
    }

    func stopAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.isHidden = true
        }
    }

    private func configure() {
        configureViews()
        configureAppearance()
    }

    private func configureViews() {
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(activityIndicatorView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureAppearance() {
        isHidden = true
        descriptionLabel.text = "Loading contacts..."
        activityIndicatorView.color = .black
    }
}
