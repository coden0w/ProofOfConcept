//
// Created by Inditex on 24/2/25
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            guard let attachedString = bestAttemptContent.userInfo["attached"] as? String,
                  let attachedURL = URL(string: attachedString) else {
                return
            }

            Task {
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let (tempURL, _) = try await session.download(for: URLRequest(url: attachedURL))
                
                let content = try! UNNotificationAttachment(identifier: attachedURL.absoluteString, url: tempURL, options: [:])
                bestAttemptContent.attachments = [content]
                bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
                contentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
