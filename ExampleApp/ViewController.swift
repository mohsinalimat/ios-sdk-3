//
//  ViewController.swift
//  ExampleApp
//
//  Created by Basil M Kuriakose on 27/12/17.
//  Copyright © 2017 Cashfree. All rights reserved.
//

import UIKit
import iosCashfreeSdk

// Use the ResultDelegate ONLY if you want to use Individual payment views (Not required by Tab Bar View)
class ViewController: UIViewController, ResultDelegate {
    
    // MARK: Step 1 - Set Variables (MUST NOT BE EMPTY)
    // Note - Please add the 3 keys (without the qoutes) in your project's "info.plist" file and set correct value for them

    // If you are testing in development, please set value of "CF_ENV" as "TEST" (without qoutes) in your project's Info.plist file.
    // Else if you are building your app for Production (Appstore), please set the value of "CF_ENV" to "PROD" (without qoutes) in your project's Info.plist file.
    
    let environment = Bundle.main.infoDictionary?["CF_ENV"] as! String  // MUST NOT BE EMPTY
    
    let url = Bundle.main.infoDictionary?["CF_URL"] as! String // MUST NOT BE NIL
    let appId = Bundle.main.infoDictionary?["CF_API_KEY"] as! String // MUST NOT BE NIL
    let merchantName = Bundle.main.infoDictionary?["CF_MERCHANT_NAME"] as! String // MUST NOT BE NIL
    let notifyUrl = Bundle.main.infoDictionary?["CF_NOTIFYURL"] as! String // MUST NOT BE NIL
    
    let paytmOption = Bundle.main.infoDictionary?["CF_PAYTM"] as! String // MUST NOT BE NIL
    // End of Step 1
    
    
    // MARK: Step 2 - Pass your variables (Eg: orderId, orderAmount etc)
    
    let orderId = "Xorder_idx12345" + String(arc4random())
    let orderAmount = "102.00"
    let customerEmail = "yourname@example.com"
    let customerPhone = "9876543210"
    let orderNote = "This is a test note" // Pass "" if you don't have a value.
    let customerName = "Firstname Lastname"
    let orderCurrency = "INR"
    
    var paymentReady = "" // MUST BE A VAR with the value ""
    // End of Step 2
    
    // Customize colors
    
    // Use below values for color1Hex and color2Hex if you want to use our example
    // let color1Hex = 255fdb
    // let color2Hex = 00ff6b
    
    let color1Hex = "7d559f"
    let color2Hex = "de97ec"
    
    // End Customize colors
    
    // This is Struct for the result (See viewDidAppear)
    struct Result : Codable {
        let orderId: String
        let referenceId: String
        let orderAmount: String
        let txStatus: String
        let txMsg: String
        let txTime: String
        let paymentMode: String
        let signature: String
        
        enum CodingKeys : String, CodingKey {
            case orderId
            case referenceId
            case orderAmount
            case txStatus
            case txMsg
            case txTime
            case paymentMode
            case signature
        }
    }
    
    // End of Struct for the result
    
    // USE ANY OF THE BELOW IBAction Codes (We recommend using the payTabBarButton which shows all Payment methods in a Tab Bar Controller)
    
    // MARK: To present Only a Card Payment View
    @IBAction func cardButton(_ sender: Any) {
        
        let myBundle = Bundle(for: cardViewController.self)
        let mainView: UIStoryboard = UIStoryboard(name: "CF", bundle: myBundle)
        let cardVC = mainView.instantiateViewController(withIdentifier: "cardVC") as! cardViewController
        
        cardVC.resultDelegate = self
        
        cardVC.appId = appId
        cardVC.merchantName = merchantName
        cardVC.orderId = orderId
        cardVC.orderAmount = orderAmount
        cardVC.customerEmail = customerEmail
        cardVC.customerPhone = customerPhone
        cardVC.paymentToken_config = paymentReady
        
        self.present(cardVC, animated: true, completion: nil)
    }
    // End of Only Showing Card Payment
    
    // MARK: To present Only a Netbanking
    @IBAction func netbankingButton(_ sender: Any) {
    
        let myBundle = Bundle(for: cardViewController.self)
        let mainView: UIStoryboard = UIStoryboard(name: "CF", bundle: myBundle)
        
        let nbVC = mainView.instantiateViewController(withIdentifier: "nbVC") as! netBankingViewController
        
        nbVC.resultDelegate = self
        
        nbVC.appId = appId
        nbVC.merchantName = merchantName
        nbVC.orderId = orderId
        nbVC.orderAmount = orderAmount
        nbVC.customerEmail = customerEmail
        nbVC.customerPhone = customerPhone
        nbVC.nb_paymentToken_config = paymentReady
        
        self.present(nbVC, animated: true, completion: nil)
        
        
    }
    // End of Only Showing Netbanking
    
    // MARK: To present Only a Wallet
    @IBAction func walletButton(_ sender: Any) {
        
        let myBundle = Bundle(for: cardViewController.self)
        let mainView: UIStoryboard = UIStoryboard(name: "CF", bundle: myBundle)
        
        let walletVC = mainView.instantiateViewController(withIdentifier: "walletVC") as! walletViewController
        
        walletVC.resultDelegate = self
        
        walletVC.appId = appId
        walletVC.merchantName = merchantName
        walletVC.orderId = orderId
        walletVC.orderAmount = orderAmount
        walletVC.customerEmail = customerEmail
        walletVC.customerPhone = customerPhone
        walletVC.wallet_paymentToken_config = paymentReady
        
        self.present(walletVC, animated: true, completion: nil)
    }
    // End of Only Showing Wallet
    
    // MARK: To present Only a UPI
    @IBAction func upiButton(_ sender: Any) {
        let myBundle = Bundle(for: cardViewController.self)
        let mainView: UIStoryboard = UIStoryboard(name: "CF", bundle: myBundle)
        
        let upiVC = mainView.instantiateViewController(withIdentifier: "upiVC") as! upiViewController
        
        upiVC.resultDelegate = self
        
        upiVC.appId = appId
        upiVC.merchantName = merchantName
        upiVC.orderId = orderId
        upiVC.orderAmount = orderAmount
        upiVC.customerEmail = customerEmail
        upiVC.customerPhone = customerPhone
        upiVC.upi_paymentToken_config = paymentReady
        
        self.present(upiVC, animated: true, completion: nil)
    }
    // End of Only Showing UPI
    
    // MARK: To present all Payment Options in a Tab Bar Controller
    @IBAction func payTabBarButton(_ sender: Any) {
        
        let myBundle = Bundle(for: PGTabBarViewController.self)
        let mainView: UIStoryboard = UIStoryboard(name: "CF", bundle: myBundle)
        
        let paymentVC = mainView.instantiateViewController(withIdentifier: "PGTabBar") as! PGTabBarViewController
        
        let payTab = PGTabBarViewController()

        // CREATE AN ORDER
        payTab.createOrder(orderId: orderId, orderAmount: orderAmount, customerEmail: customerEmail, customerPhone: customerPhone, paymentReady: paymentReady, orderNote: orderNote, customerName: customerName, orderCurrency: orderCurrency, notifyUrl: notifyUrl)
        
        self.present(paymentVC, animated: false, completion: nil)
    }
    // End of Showing all Payment Options in a Tab Bar Controller
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Step 3
        let payTab = PGTabBarViewController()
        
        payTab.setConfig(env: environment, appId: appId, url: url, merchantName: merchantName, paytmOption: paytmOption, color1Hex: color1Hex, color2Hex: color2Hex)
        
        // End of Step 3
        
        // MARK: Step 4 Call the initPayment method on "viewDidLoad()"
        let cf = cardViewController()
        
        _ = cf.initPayment(url: url, appId: appId, orderId: orderId, orderAmount: orderAmount, customerEmail: customerEmail, customerPhone: customerPhone, orderCurrency: orderCurrency, completion: { output in
            self.paymentReady = (output)
        })
        // End of Step 4
    }
    
    
    // MARK: Step 5 - Below function is used for Tab Bar Controller contains the result after payment is completed by the user.
    
    override func viewDidAppear(_ animated: Bool) {
        let paymentVC = PGTabBarViewController()
        
        var transactionResult = paymentVC.getResult()
        var inputJSON = "\(transactionResult)"
        
        let inputData = inputJSON.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        if inputJSON != "" {
            do {
                let result = try decoder.decode(Result.self, from: inputData)
                print(result.orderId)
                print(result)
            } catch {
                // handle exception
                print("Error Occured")
            }
        } else {
            print("transactionResult is empty")
        }
    }
    // End of function that contains the result after payment is completed by the user.
    

    
    // NOTE - Only If you are using Individual View (eg: Only Card Payment View), Use this function which contains the result after payment is completed by the user in a individual payment method view (Eg: Only Card Payment View).
    // This is a protocol stub for "ResultDelegate"
    
    func onPaymentCompletion(msg: String) {
        print("Payment completion details are - \(msg)")
    }
    // End of Step 5

}

