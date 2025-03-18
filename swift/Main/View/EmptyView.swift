//
//  EmptyView.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/8.
//

import Foundation
import SnapKit

class EmptyView: UIView {
    
    let imgView = UIImageView(image: UIImage(named: "empty_pop_image"))
    let label: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.init(hexString: "#254B62")
        l.font = .init(style: .ARIALBold, size: 16.uiX)
        l.textAlignment = .center
        return l
    }()

    var imgTop: ConstraintMakerEditable!
    var labelTop: ConstraintMakerEditable!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(imgView)
        addSubview(label)
        
        
        imgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(0.uiX)
            make.width.equalTo(imgView.snpSize.width)
            make.height.equalTo(imgView.snpSize.height)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(40.uiX)
            make.leading.equalToSuperview().offset(60.uiX)
            make.trailing.equalToSuperview().offset(-60.uiX)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
          // 如果不希望所有点都穿透，可以在此基础上加入更多逻辑
          // 例如检查点是否在视图的某个不透明区域内
          if self.isUserInteractionEnabled {
              return nil
          }
          return super.hitTest(point, with: event)
      }
}
