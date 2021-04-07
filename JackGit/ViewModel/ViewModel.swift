//
//  ViewModel.swift
//  JackGit
//
//  Created by Ruchi Agrawal on 4/6/21.
//

import Foundation

class ViewModel {
    private var myModel = Model<Observable<JackProject>>()
    
    let UrlString :String = "https://api.github.com/users/JakeWharton/repos?page=%d&per_page=15"
    
    func downloadData(){
        //create URL
        if(myModel.count%15>0){
            return
        }
        let url = URL(string: String(format: UrlString, (myModel.count/15)+1))
         guard let requestUrl = url else {
             fatalError()
         }
         //Create URL Request
         var request = URLRequest(url: requestUrl)
         //specify HTTP Method to use
         request.httpMethod = "GET"
         //Send HTTP Request
        let task  = URLSession.shared.dataTask(with: request) {(data, response, error) in
                        
             // Check for Error
             if let error = error{
                 print("Error took place:\(error)")
                 return
             }
             //Read HTTP Response status code
             if let response = response as? HTTPURLResponse{
                 print("Response HTTP Status code : \(response.statusCode)")
               
             }
             //Convert HTTP Response Data to a simple string
            if let responseData = data,
                let dataString = String(data: responseData,encoding: .utf8){
                 print("Response data string : \n \(dataString)")
                self.decodeJsonData(data: responseData)
             }
        }
        task.resume()
        
    }
    func decodeJsonData(data:Data)  {
        do{
            let decoder = JSONDecoder()
            let output = try decoder.decode([JackProject].self, from: data as Data)
            print("Product print: \(output)")
            
            
            for jackProject in output{
                let jackProjectObservable = Observable(JackProject(id: jackProject.id, name: jackProject.name, description: jackProject.description, language: jackProject.language, open_issues: jackProject.open_issues, watchers: jackProject.watchers))
                self.myModel.insert(jackProjectObservable)
//                        jackProjectObservable.bind = { _ in
//                            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "updateUI")))
//                        }
            }
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "updateUI")))
        }catch let error as NSError{
            print("JSON Parsing Error is :\(error)")
        }
    }
    
//    func addEntry() {
////        let jackProjectObservable = Observable(JackProject(projectName: "test", description: "description dummy", language: "Java", bugCount: 1, watchCount: 2))
////        myModel.insert(jackProjectObservable)
//
//        jackProjectObservable.bind = { _ in
//            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "updateUI")))
//        }
//    }
    
    var count: Int {
        return myModel.count
    }
    
    func removeEntry(at index: Int) {
        myModel.remove(at: index)
    }
    
    subscript(index: Int) -> JackProject? {
        guard let jackProject = myModel[index] else {
            return nil
        }
        return jackProject.value
    }
}
