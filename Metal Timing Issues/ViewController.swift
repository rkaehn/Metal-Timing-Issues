//
//  ViewController.swift
//  Metal Timing Issues
//
//  Created by Raffael Kaehn on 27.01.22.
//

import UIKit
import MetalKit

class ViewController: UIViewController {
    var mtkView: MTKView!
    
    var commandQueue: MTLCommandQueue!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mtkView = MTKView()
        view = mtkView
        
        mtkView.device = MTLCreateSystemDefaultDevice()!
        mtkView.delegate = self
        mtkView.preferredFramesPerSecond = 60
        
        commandQueue = mtkView.device!.makeCommandQueue()
    }
}

extension ViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    func draw(in view: MTKView) {
        guard let commandBuffer = commandQueue.makeCommandBuffer(),
              let drawable = view.currentDrawable else { return }

        commandBuffer.present(drawable, afterMinimumDuration: 1.0/60.0)
        
        commandBuffer.commit()
    }
}
