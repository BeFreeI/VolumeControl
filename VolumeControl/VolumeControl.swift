//
//  VolumeControl.swift
//  VolumeControl
//
//  Created by  Pavel Nepogodin on 20.10.23.
//

import SwiftUI

struct VolumeControl: View {
    @State private var scale: CGFloat = 1
    @Binding var progress: CGFloat
    @State private var anchor: UnitPoint = .top
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(.ultraThinMaterial)
                Rectangle()
                    .fill(.white)
                    .frame(height: geometry.size.height * progress)
                    .animation(.linear, value: progress)
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .scaleEffect(
                x: scale - (scale - 1) * 2,
                y: scale,
                anchor: anchor
            )
            .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                let progress =  1 - CGFloat(value.location.y / (geometry.size.height))
                self.progress = min( max(0, progress), 1)
                
                if progress > 1 {
                    withAnimation(.easeInOut) {
                        self.scale = pow((progress * geometry.size.height) / geometry.size.height, 1/8)
                        anchor = .bottom
                    }
                } else if progress < 0 {
                    withAnimation(.easeInOut) {
                        self.scale = pow(((abs(progress) + 1) * geometry.size.height) / geometry.size.height, 1/8)
                        anchor = .top
                    }
                }
            }).onEnded({ _ in
                withAnimation(.interpolatingSpring(stiffness: 150, damping: 10)) {
                    self.scale = 1
                }
            })
            )
        }
    }
}
