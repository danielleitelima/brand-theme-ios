import Foundation
import UIKit

/// Loads an image from a remote URL
/// - Parameters:
///   - url: The URL of the image to load
///   - placeholder: The placeholder image to use if loading fails
///   - completionHandler: A closure that is called with the loaded image or placeholder
/// - Returns: The URLSessionDataTask that can be started or cancelled
public func getRemoteImage(url: URL, placeholder: UIImage, completionHandler: @escaping (UIImage) -> Void) -> URLSessionDataTask {
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error loading image: \(error.localizedDescription)")
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            return
        }
        
        guard let data = data, let image = UIImage(data: data) else {
            print("Invalid image data received")
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            return
        }
        
        DispatchQueue.main.async {
            completionHandler(image)
        }
    }
    
    return task
} 