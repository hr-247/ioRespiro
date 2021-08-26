//
//  QuestionView.swift
//  IoRespiro2019
//
//  Created by Ankit  Jain on 22/12/20.
//

import UIKit

protocol QuestionViewDelegate
{
    func answerSelected (ans : ChoiceModal)
    func catAnswerSelected(ans: ChoiceModal)
}

class QuestionView: UIView {

    @IBOutlet weak var tblView: UITableView!
    var quesModal : GetQuestionModal? = nil
    var catQuesModal : GetCatQuestionModal? = nil
    var type : TestType = .tai
    var ansModal : [ChoiceModal]?
    var selectedAns : ChoiceModal?
    var delegate : QuestionViewDelegate?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setDataInView()
    {
        
        tblView.estimatedRowHeight = 70;
        tblView.register(UINib(nibName: "TestTaiTableViewCell", bundle: nil), forCellReuseIdentifier: "TestTaiTableViewCell")
        tblView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCell")
        tblView.register(UINib(nibName: "TestCatQueCell", bundle: nil), forCellReuseIdentifier: "TestCatQueCell")

        self.tblView.dataSource = self
        self.tblView.delegate = self
        tblView.reloadData()
    }
    
    
    

}

extension QuestionView : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return type == .tai ? 2 : 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 {
            return 1
        }
        return ansModal?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if type == .cat {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TestCatQueCell", for: indexPath) as! TestCatQueCell
                cell.bottomLbl.text = catQuesModal?.question?.top!
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
            cell.lbl.textColor = UIColor.patientThemeColor
            cell.lbl.text = quesModal?.question ?? ""
            return cell

        }else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
            cell.lbl.textColor = UIColor.patientThemeColor
            cell.lbl.text = catQuesModal?.question?.bottom!
            cell.lbl.font = UIFont(name: AppFontName.bold, size: 16)!
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestTaiTableViewCell", for: indexPath) as! TestTaiTableViewCell
            
            cell.btnUI(color: UIColor.patientThemeColor, title: ansModal![indexPath.row].name ?? "")
            
            cell.ansLbl.backgroundColor = UIColor(red: 185/255, green: 05/255, blue: 103/255, alpha: 1 - (0.10 * CGFloat(indexPath.row)))
            
            if ansModal?[indexPath.row].id == selectedAns?.id {
                cell.ansLbl.font = UIFont(name: AppFontName.bold, size: 25)
            }
            
            
            return cell
        }
        
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedAns = ansModal?[indexPath.row]
            self.tblView.reloadData()
            if type == .tai
            {
                self.delegate?.answerSelected(ans: ansModal![indexPath.row])
            }else
            {
                self.delegate?.catAnswerSelected(ans: ansModal![indexPath.row])
            }
            
        }
    }
    
    
}
