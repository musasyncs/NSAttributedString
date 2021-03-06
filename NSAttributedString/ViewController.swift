//
//  ViewController.swift
//  NSAttributedString
//
//  Created by Ewen on 2021/12/9.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var imagelabel: UILabel = {
        let label = makeLabel()
        label.attributedText = makeImageText()
        return label
    }()

    lazy var paragraphLabel: UILabel = {
        let label = makeLabel()
        label.attributedText = makeParagraphText()
        return label
    }()
    
    lazy var boldingLabel: UILabel = {
        let label = makeLabel()
        label.attributedText = makeBoldingText()
        return label
    }()
    
    lazy var offSetlabel: UILabel = {
        let label = makeLabel()
        label.attributedText = makeDollarText(8999.01)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "NSAttributedString Demo"
        
        let stackView = makeVerticalStackView()
        stackView.addArrangedSubview(imagelabel)
        stackView.addArrangedSubview(paragraphLabel)
        stackView.addArrangedSubview(boldingLabel)
        stackView.addArrangedSubview(makeSpotifyButton(withText: "PLAY ON SPOTIFY"))
        stackView.addArrangedSubview(offSetlabel)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
    }
}


// MARK: - Functions
extension ViewController {
    func makeImageText() -> NSAttributedString {
        let headerTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body).withTraits(traits: [.traitBold]), // extension
            .foregroundColor: UIColor.darkText
        ]
        let subHeaderTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.gray
        ]
        
        let rootString = NSMutableAttributedString(string: "Re:????????????????????????????????????", attributes: headerTextAttributes)
        rootString.append(NSAttributedString(string: "\nJul 8 17:36:12 2014 ??? Gossiping ", attributes: subHeaderTextAttributes))
        
        // attribute ??????
        rootString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: NSMutableParagraphStyle(),
            range: NSMakeRange(0, rootString.string.count)
        )
        rootString.addAttribute(
            NSAttributedString.Key.kern,
            value: NSNumber(value: 0.3),
            range: NSRange(location: 16, length: rootString.string.count-16)
        )
        
        // image
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_icon")?.resize(to: CGSize(width: 16, height: 16))
        rootString.append(NSAttributedString(attachment: attachment))
        
        let desiredWidth: CGFloat = 300
        let rect = rootString.boundingRect(with: CGSize(width: desiredWidth, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        attachment.bounds = CGRect(x: 0, y: -2, width: rect.height/2, height: rect.height/2)
        
        return rootString
    }
    
    func makeParagraphText() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent    = 8+18        // ?????????????????????
        paragraphStyle.headIndent             = 8           // ????????????????????????????????????
        paragraphStyle.tailIndent             = -8          // ???????????????????????????
        paragraphStyle.lineSpacing            = 0           // ???????????????????????????0
        paragraphStyle.alignment              = .justified  // ?????????????????????
        
        paragraphStyle.paragraphSpacingBefore = 4           // space between the paragraph???s top and the beginning of its text content.
        paragraphStyle.paragraphSpacing       = 16          // added at the end of the paragraph.
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: paragraphStyle
        ]
        
        let rootString = NSMutableAttributedString(string: "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????\n", attributes: attributes)
        let secondParagraph = NSAttributedString(string: "???????????????????????????\n", attributes: attributes)
        let thirdParagraph = NSAttributedString(string: "??????????????????????????????\n", attributes: attributes)
        let fourthParagraph = NSAttributedString(string: "??????????????? = =????????????????????????????????????????????????????????????\n", attributes: attributes)
        let fifthParagraph = NSAttributedString(string: "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????", attributes: attributes)
        rootString.append(secondParagraph)
        rootString.append(thirdParagraph)
        rootString.append(fourthParagraph)
        rootString.append(fifthParagraph)
        return rootString
    }
    
    func makeBoldingText() -> NSAttributedString {
        let plainTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
        ]
        let boldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body).withTraits(traits: [.traitBold]), // extension
            .foregroundColor: UIColor.spotifyGreen
        ]
        
        let text = NSMutableAttributedString(string: "?????????????????????????????????????????????", attributes: plainTextAttributes)
        text.append(NSAttributedString(string: "???????????????", attributes: boldTextAttributes))
        text.append(NSAttributedString(string: "???", attributes: plainTextAttributes))
        text.append(NSAttributedString(string: "????????????", attributes: boldTextAttributes))
        text.append(NSAttributedString(string: "?????????", attributes: plainTextAttributes))
        return text
    }
    
    func makeSpotifyButton(withText title: String) -> UIButton {
        let button = UIButton()
        let buttonHeight: CGFloat = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .spotifyGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonHeight / 2
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: buttonHeight, bottom: 10, right: buttonHeight) // iOS15 ??????
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white,
            .kern: 2
        ])
        button.setAttributedTitle(attributedText, for: .normal)
        
        return button
    }
    
    func makeDollarText(_ amount: Decimal) -> NSAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8
        ]
        let monthAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout)
        ]
        let termAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8
        ]

        let text = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let priceText = amountAttributed(amount)
        let monthText = NSAttributedString(string: "/mo", attributes: monthAttributes)
        let termText = NSAttributedString(string: "1", attributes: termAttributes)
        
        text.append(priceText)
        text.append(monthText)
        text.append(termText)
        return text
    }
}



extension ViewController {
    func amountAttributed(_ amount: Decimal) -> NSAttributedString {
        let parts = formattedDollarsAndCents(amount) // tuple
        let dollarPart = parts.0
        let centPart = parts.1
        return makeFormattedBalance(dollars: dollarPart, cents: centPart)
    }
    
    func formattedDollarsAndCents(_ amount: Decimal) -> (String, String) {
        let parts = modf(amount.doubleValue)    // Extension to transform Decimal to Double
                                                // parts ?????? (8999.0, 0.010000000000218279)
        let dollarsWithDecimal = dollarsFormatted(parts.0) // $8,999.00
        let dollarParts = dollarsWithDecimal.components(separatedBy: NumberFormatter().decimalSeparator!) // ["$8,999", "00"]
        
        var dollars = dollarParts.first! // $8,999
        dollars.removeFirst() // 8,999
        
        var cents = String(format: "%.2f", parts.1) // 0.01
        cents.removeFirst() // .01
        
        return (dollars, cents)
    }
    
    func dollarsFormatted(_ dollars: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        if let result = formatter.string(from: dollars as NSNumber) { return result }
        return ""
    }
    
    func makeFormattedBalance(dollars: String, cents: String) -> NSAttributedString {
        let dollarAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .title1)
        ]
        let centAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8
        ]
        
        let dollarString = NSMutableAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        dollarString.append(centString)
        return dollarString
    }
}
