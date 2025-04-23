import SwiftUI
import Combine
import UIKit

protocol JestersPhotoManagerProcol {
    func saveProfileImage(_ image: UIImage?)
    func loadProfileImage() -> UIImage?
}

final class PhotoManager: ObservableObject {
    static let shared = PhotoManager()
    
    @Published var profileImage: UIImage? {
        didSet {
            saveProfileImage(profileImage)
        }
    }
    
    private let profileImageKey = "profileImage"
    
    private init() {
        self.profileImage = loadProfileImage()
    }
    
    func saveProfileImage(_ image: UIImage?) {
        guard let image = image else {
            UserDefaults.standard.removeObject(forKey: profileImageKey)
            return
        }
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: profileImageKey)
        }
    }
    
    func loadProfileImage() -> UIImage? {
        guard let imageData = UserDefaults.standard.data(forKey: profileImageKey) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
