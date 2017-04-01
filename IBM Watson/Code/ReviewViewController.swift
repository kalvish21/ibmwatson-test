//
//  ReviewViewController.swift
//  IBM Watson
//
//  Created by Kalyan Vishnubhatla on 3/31/17.
//  Copyright © 2017 Kalyan Vishnubhatla. All rights reserved.
//

import UIKit
import YelpAPI
import ConversationV1
import NaturalLanguageUnderstandingV1

class ReviewViewController: UIViewController {

    var review : YLPReview!
    
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Review Detail"
        self.reviewTextView.text = self.review.excerpt
        
        let username = "e17eb501-3267-47ec-a7a4-a3d88fb1a5b1"
        let password = "gnSrjh0od5vu"
        let naturalLanguageUnderstanding = NaturalLanguageUnderstanding(username: username, password: password, version: "2017-02-27")
        print (naturalLanguageUnderstanding.serviceURL)
        let text = self.review.excerpt
        let features = Features(concepts: ConceptsOptions(limit: 5), emotion: EmotionOptions(document: true, targets: nil), sentiment: SentimentOptions(document: true, targets: nil))
        let parameters = Parameters(features: features, text: text, returnAnalyzedText: true)
        let failure = { (error: Error) in
            print(error)
        }
        naturalLanguageUnderstanding.analyzeContent(withParameters: parameters, failure: failure) {
            results in 
            print (results)
            
            print(results.emotion?.document?.emotion?.anger)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
