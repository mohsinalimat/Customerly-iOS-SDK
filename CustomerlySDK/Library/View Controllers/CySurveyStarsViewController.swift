//
//  CySurveyStarsViewController.swift
//  Customerly
//
//  Created by Paolo Musolino on 03/01/17.
//  Copyright © 2017 Customerly. All rights reserved.
//

import UIKit

class CySurveyStarsViewController: CyViewController {

    @IBOutlet weak var starButton1: CyButton!
    @IBOutlet weak var starButton2: CyButton!
    @IBOutlet weak var starButton3: CyButton!
    @IBOutlet weak var starButton4: CyButton!
    @IBOutlet weak var starButton5: CyButton!
    var returnClosure: SurveyParamsReturn?
    var survey: CySurveyResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectStars(stars: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selectedChoice(datas: CySurveyParamsRequestModel? = nil, params:SurveyParamsReturn? = nil){
        self.returnClosure = params
    }
    
    func selectStars(stars: Int){
        for starButton in [starButton1, starButton2, starButton3, starButton4, starButton5]{
            starButton?.alpha = 0.5
            if let tag = starButton?.tag{
                if tag <= stars{
                    starButton?.alpha = 1.0
                }
            }
        }
    }
    
    // MARK: Actions
    @IBAction func selectStars(_ sender: UIButton) {
        selectStars(stars: sender.tag)
        
        let surveyParams = CySurveyParamsRequestModel(JSON: [:])
        surveyParams?.survey_id = survey?.survey_id
        surveyParams?.answer = "\(sender.tag)"
        if let dataStored = CyStorage.getCyDataModel(){
            surveyParams?.settings?.user_id = dataStored.user?.user_id
            surveyParams?.settings?.email = dataStored.user?.email
            surveyParams?.settings?.name = dataStored.user?.name
            surveyParams?.cookies?.customerly_lead_token = dataStored.cookies?.customerly_lead_token
            surveyParams?.cookies?.customerly_temp_token = dataStored.cookies?.customerly_temp_token
            surveyParams?.cookies?.customerly_user_token = dataStored.cookies?.customerly_user_token
        }
        self.returnClosure?(surveyParams)
    }

}
