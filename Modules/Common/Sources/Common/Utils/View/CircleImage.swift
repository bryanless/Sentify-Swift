//
//  CircleImage.swift
//  
//
//  Created by Bryan on 31/12/22.
//

import SwiftUI

public struct CircleImage: View {
  let image: Image

  public init(image: Image) {
    self.image = image
  }

  public var body: some View {
    image
      .resizable()
      .aspectRatio(1, contentMode: .fit)
      .clipShape(Circle())
  }
}

struct CircleImage_Previews: PreviewProvider {
  static var previews: some View {
    CircleImage(image: Image("ProfilePicture"))
  }
}
