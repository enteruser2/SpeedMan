//
//  CocosView.swift
//  SpeedMan
//
//  Created by macmini on 2025/3/17.
//

import UIKit
import MetalKit

// 自定义视图类，指定使用 CAMetalLayer
class CocosMetalView: UIView {
    // 关键步骤：重写 layerClass 属性
    override class var layerClass: AnyClass {
        return CAMetalLayer.self
    }

    // 确保 Metal 设备正确初始化
    var metalDevice: MTLDevice!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMetal()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMetal()
    }

    private func setupMetal() {
        // 初始化 Metal 设备
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Metal is not supported on this device")
        }
        metalDevice = device

        // 配置 CAMetalLayer
        guard let metalLayer = self.layer as? CAMetalLayer else {
            fatalError("Layer is not CAMetalLayer")
        }
        metalLayer.device = metalDevice
        metalLayer.pixelFormat = .bgra8Unorm // Cocos 常用的像素格式
    }
}
