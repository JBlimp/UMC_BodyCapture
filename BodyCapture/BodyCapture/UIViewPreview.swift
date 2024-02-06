//
//  UIViewPreview.swift
//  BodyCapture
//
//  Created by junseok on 2/6/24.
//

#if DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif


/*
 how to use
 
 #if DEBUG
 import SwiftUI

 struct VCPreView: PreviewProvider {
     static var previews: some View {
         뷰컨 이름().toPreview()
     }
 }
 #endif
 
 뷰컨 이름 수정
 이 코드를 미리보기 원하는 뷰컨 가장 아래에 붙여넣기
 */
