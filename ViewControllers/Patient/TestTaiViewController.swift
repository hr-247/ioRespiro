//
//  TestTaiViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 10/12/2020.
//

import UIKit


struct TestAnswer {
    var question : GetQuestionModal?
    var answer : ChoiceModal?
    
    init(que : GetQuestionModal?, ans : ChoiceModal? ) {
        question = que
        answer = ans
    }
}

struct CatTestAnswer {
    var question : GetCatQuestionModal?
    var answer : ChoiceModal?
    
    init(que : GetCatQuestionModal?, ans : ChoiceModal? ) {
        question = que
        answer = ans
    }
}


enum TestType {
    case cat
    case tai
}

class TestTaiViewController: UIViewController {
   
    var type : TestType = .cat
    var whchBtnClckd = Bool()
    var testId = Int()
    var assignedTestId = Int()
    var freqId = Int()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var forwardIcon: UIButton!
   
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var lblTopCons: NSLayoutConstraint!
//    @IBOutlet weak var headingLbl: UILabel!
//    @IBOutlet weak var testTaiTableView: UITableView!
    var questionsArray = [GetQuestionModal]()
    var catQuestionsArray = [GetCatQuestionModal]()
    var choiceArray = [ChoiceModal]()
    var testArray = [TestAnswer]()
    var catTestArray = [CatTestAnswer]()
    var cellSpacing = 0

    let dispatchGroup = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        if whchBtnClckd == false{
            commonNavigationBar(title: "Test Tai", controller: Constant.Controllers.testTai, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        }else{
            commonNavigationBar(title: "Test Cat", controller: Constant.Controllers.testTai, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        }
        
        collectionViewProperty()
    //    headingLblProperty()
     //   addBackButton()
        handleAPICalls()
       
    }
    
    
    func collectionViewProperty(){
        
       
        collectionView.register(UINib(nibName: "QueBottomCollectionCell", bundle: nil), forCellWithReuseIdentifier: "QueBottomCollectionCell")
        //set delegate
        
        
    }
    func setupGridView()
    {
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        //        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
       
        
        let count = (type == .cat) ? catQuestionsArray.count : questionsArray.count
        let totalCellWidth = 20.0 * CGFloat(count)
        cellSpacing = Int((self.view.frame.width - totalCellWidth) / CGFloat((count + 1)))
        
        cellSpacing = min(cellSpacing, 12)
        
        flow.minimumInteritemSpacing = CGFloat(cellSpacing)
        flow.minimumLineSpacing = CGFloat(cellSpacing)
        
        
    }
    
    
    func handleAPICalls()
    {
        dispatchGroup.enter()
        if type == .cat {
            getCatQuestionsFromServer()
        }else
        {
            getTaiQuestionsFromServer()
        }
        dispatchGroup.enter()
        getChoicesFromServer()
        dispatchGroup.notify(queue: .main) {
          
            self.setupGridView()
            if self.type == .tai {
                self.setupSlideScrollView()

            }else
            {
                self.setupCatSlideScrollView()
            }
            
           }
        
    }
    
//    func headingLblProperty()
//    {
//        lblTopCons.constant = 0.04*UIScreen.main.bounds.height;
//        headingLbl.text = type == .tai ? "Test Tai" : "Test Cat"
//        headingLbl.textColor = UIColor.headingColor
//        headingLbl.font = UIFont.appTitle2
//
//
//    }
    
   
    func pushToNext() {
        let vc = Constant.Controllers.testSampre.get() as! TestSampreViewController
        vc.testArray = self.testArray
        vc.catTestArray = self.catTestArray
        vc.type = type
        self.navigationController?.pushViewController(vc, animated: true)
        removeLastFromNavigationStack()
       }
    
    func createQuestionView() -> QuestionView {
        
        let question : QuestionView = Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)?.first as! QuestionView
        
        
        return question
    }
    
    func setupSlideScrollView() {
    
        pageControl.numberOfPages = questionsArray.count
        self.collectionView.reloadData()
        pageControl.currentPageIndicatorTintColor = UIColor.patientThemeColor
        pageControl.pageIndicatorTintColor = .darkGray
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(questionsArray.count), height: 1)
        
        for i in 0 ..< questionsArray.count {
            let quesView = self.createQuestionView()
            quesView.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: scrollView.frame.height)
            testArray.append(TestAnswer(que: questionsArray[i], ans: nil))
            //quesView.testArray = testArray
            quesView.quesModal = questionsArray[i]
            quesView.type = type
            quesView.ansModal = choiceArray
            quesView.delegate = self
            quesView.setDataInView()
            scrollView.addSubview(quesView)
        }
    }
    
    
    func setupCatSlideScrollView() {
    
        pageControl.numberOfPages = catQuestionsArray.count
        self.collectionView.reloadData()
        pageControl.currentPageIndicatorTintColor = UIColor.patientThemeColor
        pageControl.pageIndicatorTintColor = .darkGray
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(catQuestionsArray.count), height: 1)
        
        for i in 0 ..< catQuestionsArray.count {
            let quesView = self.createQuestionView()
            quesView.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: scrollView.frame.height)
            catTestArray.append(CatTestAnswer(que: catQuestionsArray[i], ans: nil))
            quesView.catQuesModal = catQuestionsArray[i]
            quesView.type = type
            quesView.ansModal = choiceArray
            quesView.delegate = self
            quesView.setDataInView()
            scrollView.addSubview(quesView)
        }
    }
    
    
    @IBAction func forwardIconTapped(_ sender: Any) {
       
        self.submissionWork()
        
    }
    
    func submissionWork()
    {
        var allSelected = true
        var submitArr = [[String : Any]]()
        for item in testArray
        {
            if item.answer == nil
            {
                allSelected = false
                break
            }else
            {
                let json = ["question_id":item.question!.id!, "choice_id" : item.answer!.id!]
                submitArr.append(json as [String : Any])
            }
           
            
            
        }
        if allSelected == false {
            AppUtils.showToast(message: Constant.Msg.allQuestionMandatory)
            return
        }
        
        self.saveTestToServer(submitArr)
    }
    
    
    func catSubmissionWork()
    {
        var allSelected = true
        var submitArr = [[String : Any]]()

        for item in catTestArray
        {
            if item.answer == nil
            {
                allSelected = false
                break
            }else
            {
                let json = ["question_id":item.question!.question?.id!, "choice_id" : item.answer!.id!]
                submitArr.append(json as [String : Any])
            }
    
            
        }
        if allSelected == false {
            AppUtils.showToast(message: Constant.Msg.allQuestionMandatory)
            return
        }
        
        self.saveTestToServer(submitArr)

        
       // self.pushToNext()

    }
    
    
}


extension TestTaiViewController
{
    func getTaiQuestionsFromServer()
    {
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Questions, modalName: [GetQuestionModal].self) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil
            {
                self.questionsArray = modal!
            }
            self.dispatchGroup.leave()
            
                
            }
    }
        
    func getChoicesFromServer()
    {
        let url = type == .tai ? APIManager.APIs.get_Choice : APIManager.APIs.get_Choice_Cat
        Service.sharedInstance.getRequest(Url: url, modalName: [ChoiceModal].self) { (modal, error) in
            
            if modal != nil
            {
                self.choiceArray = modal!
                
            }
            
            self.dispatchGroup.leave()
                
            }
  
        }
    
    
    func saveTestToServer(_ array : [[String : Any]])
    {
        Utils.startLoadingWithTitle("")

        let post = [ "assignedtestschedulemappingid": self.testId,
                     "assigned_test_id": self.assignedTestId,
                     "freqId": self.freqId,
                     "answers" : array] as [String : Any]
        
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.submit_Test, modalName: SubmitTest.self, parameter: post) { (modal, error) in
            Utils.stopLoading()
            if let message = modal?.message
            {
                if message == Constant.Msg.unauthenticated {
                    AppUtils.showToast(message: message)
                    return
                }
                self.pushToNext()
                
                
            }
            
        }
        
    }
    
    func getCatQuestionsFromServer()
    {
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Questions_Cat, modalName: [GetCatQuestionModal].self) { (modal, error) in
            Utils.stopLoading()
            self.catQuestionsArray.removeAll()
            if modal != nil
            {
                
                for (index, var item) in modal!.enumerated()
                {
//                    item.question?.id = index + 1
                    item.question?.id = 12 + index
                    self.catQuestionsArray.append(item)
                    
                }
                
            }
            self.dispatchGroup.leave()
            
                
            }
    }
    
 
}

extension TestTaiViewController : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            self.collectionView.reloadData()
        }
        
     
//        self.forwardIcon.isHidden = true;
//        if pageControl.currentPage >= questionsArray.count - 1 {
//            self.forwardIcon.isHidden = false
//        }
    }
    
}

extension TestTaiViewController : QuestionViewDelegate
{
    func answerSelected(ans: ChoiceModal) {
        testArray[pageControl.currentPage] =  TestAnswer(que: questionsArray[pageControl.currentPage], ans: ans)
        
        if pageControl.currentPage >= questionsArray.count - 1 {
            self.submissionWork()
        }else
        {
            self.scrollView.scrollRectToVisible(CGRect(x: self.scrollView.contentOffset.x + view.frame.width, y: 0, width: view.frame.width, height: self.scrollView.frame.height), animated: true)
            
        }

    }
    
    func catAnswerSelected(ans: ChoiceModal) {
        catTestArray[pageControl.currentPage] =  CatTestAnswer(que: catQuestionsArray[pageControl.currentPage], ans: ans)
        
        if pageControl.currentPage >= catQuestionsArray.count - 1 {
            self.catSubmissionWork()
        }else
        {
            self.scrollView.scrollRectToVisible(CGRect(x: self.scrollView.contentOffset.x + view.frame.width, y: 0, width: view.frame.width, height: self.scrollView.frame.height), animated: true)
            
        }

    }
    
}



extension TestTaiViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return (type == .cat) ? catQuestionsArray.count : questionsArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QueBottomCollectionCell", for: indexPath) as! QueBottomCollectionCell
        cell.topLbl.backgroundColor = .quesColor
        cell.bottomLbl.textColor = .quesColor
        
        cell.bottomLbl.text = String(format: "%02d", indexPath.item + 1)
        
        if indexPath.item == pageControl.currentPage {
            cell.topLbl.backgroundColor = .patientThemeColor
            cell.bottomLbl.textColor = .patientThemeColor
        }
           
            
            return cell
            
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        self.scrollView.scrollRectToVisible(CGRect(x: CGFloat(indexPath.item) * view.frame.width, y: 0, width: view.frame.width, height: self.scrollView.frame.height), animated: false)
        self.pageControl.currentPage = indexPath.item
        self.collectionView.reloadData()
    }


}
extension TestTaiViewController : UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            
            return CGSize(width: 20, height: 40)
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalCellWidth = 20 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = cellSpacing * (collectionView.numberOfItems(inSection: 0) - 1)

        let leftInset = (self.view.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//
//
//    }

}
