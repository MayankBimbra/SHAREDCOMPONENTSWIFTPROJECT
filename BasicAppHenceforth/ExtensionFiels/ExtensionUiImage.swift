
import UIKit

// MARK: - UIImage Extension
   extension UIImage{
       func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
           UIGraphicsBeginImageContextWithOptions(
               CGSize(width: self.size.width + insets.left + insets.right,
                      height: self.size.height + insets.top + insets.bottom), false, self.scale)
           let _ = UIGraphicsGetCurrentContext()
           let origin = CGPoint(x: insets.left, y: insets.top)
           self.draw(at: origin)
           let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return imageWithInsets
       }
    
    func resizeTopAlignedToFill(newWidth: CGFloat) -> UIImage? {
      let newHeight = size.height
      let newSize = CGSize(width: newWidth, height: newHeight)
      UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.nativeScale)
      draw(in: CGRect(origin: .zero, size: newSize))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage
    }
    
   }
