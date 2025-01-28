//
//  AnimatedMeshGradient.swift
//  Pokemon Wiki
//
//  Created by Víctor Estévez Gómez on 21/1/25.
//

import SwiftUI

struct AnimatedMeshGradient: View {
    @State var appear = false
    
    var body: some View {
        MeshGradient(width: 3, height: 3, points: [
            appear ? [0.0, 0.0] : [0.0, 0.0], appear ? [0.5, 0.0] : [0.5, 0.0], appear ? [1, 0.0] : [1, 0.0],
            appear ? [0.0, 0.5] : [0.0, 0.5], appear ? [0.5, 0.5] : [0.8, 0.2], appear ? [1, 0.0] : [1, 0.3],
            appear ? [0.0, 1] : [0.0, 1], appear ? [0.5, 1] : [0.0, 1], appear ? [1, 1] : [1, 1]
        ], colors: [
            appear ? .black : .purple, appear ? .black : .purple, appear ? .red : .black,
            appear ? .purple : .black, appear ? .black : .black, appear ? .mint : .orange,
            appear ? .red : .black, appear ? .black : .purple, appear ? .black : .red,
        ])
        .onAppear{
            withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                appear.toggle()
            }
        }
    }
}

#Preview {
    AnimatedMeshGradient()
        .ignoresSafeArea()
}
