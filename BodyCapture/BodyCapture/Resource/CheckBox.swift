//
//  CheckBox.swift
//  BodyCapture
//
//  Created by junseok on 2/11/24.
//

import UIKit

/// 체크박스
class CheckBox: UIButton {

    /// 체크박스 이미지
    var checkBoxResouces = OnOffResources(
        onImage: UIImage(named: DefaultResource.checkedImage),
        offImage: UIImage(named: DefaultResource.notCheckedImage)
    ) {
        didSet {
            self.setChecked(isOn)
        }
    }

    enum DefaultResource {
        static let notCheckedImage = "btn_check_off"
        static let checkedImage = "btn_check_on"
    }

    /// 체크 상태 변경
    var isOn: Bool = false {
        didSet {
            guard isOn != oldValue else { return }
            self.setChecked(isOn)
        }
    }

    /// 이미지 직접 지정 + init
    init(resources: OnOffResources) {
        super.init(frame: .zero)
        self.checkBoxResouces = resources
        commonInit()
    }

    /// 일반적인 init + checkBoxResources 변경
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.setImage(checkBoxResouces.offImage, for: .normal)

        self.addTarget(self, action: #selector(check), for: .touchUpInside)
        self.isOn = false
    }

    @objc func check(_ sender: UIGestureRecognizer) {
        isOn.toggle()
    }

    /// 이미지 변경
    private func setChecked(_ isChecked: Bool) {
        if isChecked == true {
            self.setImage(checkBoxResouces.onImage, for: .normal)
        } else {
            self.setImage(checkBoxResouces.offImage, for: .normal)
        }
    }

    class OnOffResources {

        let onImage: UIImage?
        let offImage: UIImage?

        init(onImage: UIImage?, offImage: UIImage?) {
            self.onImage = onImage
            self.offImage = offImage
        }
    }
}
