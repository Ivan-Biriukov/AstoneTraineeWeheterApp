import UIKit
import SnapKit

final class BaseAlertView {
    
    // MARK: - Properties
    
    struct Constants {
        static let backgroundAlpha: CGFloat = 0.8
    }
    
    static let shared = BaseAlertView()
    private var myTargetView: UIView?
    
    // MARK: - UI Elements
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 1, alpha: 0.8)
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold(of: 16)
        lb.textAlignment = .center
        lb.textColor = .systemBackground
        return lb
    }()
    
    let predictibleTempLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular(of: 14)
        lb.textAlignment = .center
        lb.textColor = .systemBackground
        return lb
    }()
    
    let feelsLikeTempLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular(of: 14)
        lb.textAlignment = .center
        lb.textColor = .systemBackground
        return lb
    }()
    
    let pressureLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular(of: 14)
        lb.textAlignment = .center
        lb.textColor = .systemBackground
        return lb
    }()
    
    let humidityLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular(of: 14)
        lb.textAlignment = .center
        lb.textColor = .systemBackground
        return lb
    }()
    
    let wind: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular(of: 14)
        lb.textAlignment = .center
        lb.textColor = .systemBackground
        return lb
    }()
    
    let labelsStak: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
    
    // MARK: - Methods
    
    func showFullWeatherAlert(with data: List, on vc: UIViewController) {
        
        guard let targetView = vc.view else {
            return
        }
        
        myTargetView = targetView
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        alertView.frame = CGRect(origin: CGPoint(x: 40, y: -300), size: CGSize(width: targetView.frame.width - 60, height: 300))
        targetView.addSubview(alertView)
        
        dateLabel.text = data.dt_txt
        predictibleTempLabel.text = "Prediction temperature: \(data.main.temp.rounded(.toNearestOrAwayFromZero))°"
        feelsLikeTempLabel.text = "Feels like: \(Int(data.main.feels_like))°"
        pressureLabel.text = "Pressure: \(data.main.pressure) mm"
        humidityLabel.text = "Humidity: \(data.main.humidity) %"
        wind.text = "Wind speed: \(data.wind.speed) m/s. Wind derection: \(data.wind.deg)"
        [dateLabel, predictibleTempLabel, feelsLikeTempLabel, pressureLabel, humidityLabel, wind].forEach({labelsStak.addArrangedSubview($0)})
        
        alertView.addSubview(labelsStak)
        
        labelsStak.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(5)
        }
        
        let dismissButton: UIButton = {
            let btn = UIButton(type: .system)
            btn.setImage(.Alert.closeIcon, for: .normal)
            btn.addTarget(BaseAlertView.shared.self, action: #selector(dismissButtonTaped), for: .touchUpInside)
            return btn
        }()
        
        alertView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.height.width.equalTo(35)
            make.top.equalToSuperview().inset(-10)
            make.trailing.equalToSuperview().inset(-10)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = Constants.backgroundAlpha
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    
    @objc func dismissButtonTaped() {
        
        guard let targetView = myTargetView else {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alertView.frame = CGRect(origin: CGPoint(x: 40, y: targetView.frame.height), size: CGSize(width: targetView.frame.width - 60, height: 300))
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done {
                        [self.backgroundView, self.alertView].forEach({$0.removeFromSuperview()})
                    }
                })
            }
        })
    }
}
