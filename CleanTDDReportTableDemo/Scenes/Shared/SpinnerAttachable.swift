//  Copyright © 2020 Lyle Resnick. All rights reserved.

import UIKit

protocol SpinnerAttachable {}

extension SpinnerAttachable where Self: UIViewController {
    func attachSpinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.backgroundColor = .darkGray

        spinner.isHidden = true
        view.addSubview(spinner)
        view.bringSubviewToFront(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return spinner
    }
}

