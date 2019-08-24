import Capacitor
import WKWebViewController

@objc(WKWebViewCapacitor)
public class WKWebViewCapacitor: CAPPlugin {
    @objc func open(_ call: CAPPluginCall) {
        guard let urlString = call.getString("htmlString") else {
            call.error("Must provide html string to load")
            return
        }
        
        if urlString.isEmpty {
            call.error("html string must not be empty")
            return
        }
        
        DispatchQueue.main.async {
            let webViewController = WKWebViewController.init()
            webViewController.source = .string(urlString, base: nil)
            webViewController.userAgent = "WKWebViewController/1.0.0"
            webViewController.leftNavigaionBarItemTypes = [.reload]
            webViewController.toolbarItemTypes = [.back, .forward, .activity]
            let navigation = UINavigationController.init(rootViewController: webViewController)
            self.bridge.viewController.present(navigation, animated: true, completion: {
                call.success()
            })
        }
    }
}
