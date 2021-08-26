import Flutter
import UIKit

public class SwiftCopyLargeFilePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.guoka/copy_large_file", binaryMessenger: registrar.messenger())
        let instance = SwiftCopyLargeFilePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        // flutter cmds dispatched on iOS device :
        switch(call.method) {
        case "copyLargeFile":
            guard let args = call.arguments else {
                return
            }
            if let myArgs = args as? [String: Any],
               let fileName = myArgs["fileName"] as? String {
                result(copyLargeFileIfNeeded(fileName: fileName))
            } else {
                result("iOS could not extract flutter arguments in method: (copyLargeFile)")
            }
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        default:
            result("iOS calling method not recognized")
        }
    }
}

// Copy file from bundle to documents folder and return its destination path
// (only copy if not existing already with same name)
private func copyLargeFileIfNeeded(fileName: String) -> String {
    
    let fileManager = FileManager.default
    let documentsUrl = fileManager.urls(for: .documentDirectory,
                                        in: .userDomainMask)
    guard documentsUrl.count != 0 else {
        return "Could not find documents URL"
    }
    
    let outputFileURL = documentsUrl.first!.appendingPathComponent(fileName)
    let filePath = outputFileURL.path
    if !(fileManager.fileExists(atPath: filePath)) {
        if !( (try? outputFileURL.checkResourceIsReachable()) ?? false) {
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent(fileName)
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: filePath)
                return "\(filePath)"
            } catch let error as NSError {
                return "Couldn't copy file to final location! Error:\(error.description)"
            }
        } else {
            return "\(filePath)"
        }
    } else {
        return "\(filePath)"
    }
}

