import SwiftUI
import AVFoundation

final class GRAccountViewModel: ObservableObject {
    
    @Published var showingImagePicker = false
    @Published var showingCameraPicker = false
    @Published var showActionSheet = false
    
    @AppStorage("name") var name: String = ""
    
    func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            showingCameraPicker = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.showingCameraPicker = true
                    } else {
                        self.showingCameraPicker = false
                    }
                }
            }
        case .denied, .restricted:
            showingCameraPicker = false
        @unknown default:
            showingCameraPicker = false
        }
    }
}
