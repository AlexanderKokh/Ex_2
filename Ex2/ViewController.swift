//
//  ViewController.swift
//  Ex2
//
//  Created by Кох Александр Станиславович on 05.07.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    let systemImage = UIImage(systemName: "chevron.right")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let button = CustomButton()
        let button2 = CustomButton()
        let button3 = CustomButton()
        
        button.configuration = setButtonConfig(title: "Кнопка  1 с длинным заголовком", image: systemImage ?? UIImage())
        button2.configuration = setButtonConfig(title: "Кнопка 2", image: systemImage ?? UIImage())
        button3.configuration = setButtonConfig(title: "Кнопка 3 с текстом", image: systemImage ?? UIImage())
        
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
        
        button3.tapAction = { [weak self] in
            guard let self = self else { return }
            self.present(ViewController2(), animated: true)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
 
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button3.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setButtonConfig(title: String, image: UIImage) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .small
        config.image = UIImage(systemName: "chevron.right")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        config.imagePadding = 8
        config.imagePlacement = .trailing
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 14,
            bottom: 10,
            trailing: 14
        )
        config.title = title
        return config
    }
}

final class CustomButton: UIButton {
    
    var tapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        addTarget(self, action: #selector(buttonTouchUp(_:)), for: .touchUpInside)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 1)
        })
    }
    
    @objc
    private func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction], animations: {
            sender.transform = .identity
        }) { [weak self] _ in
            self?.tapAction?()
        }
    }
}
