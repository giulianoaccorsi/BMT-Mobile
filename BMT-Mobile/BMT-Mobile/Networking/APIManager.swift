//
//  APIManager.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import Foundation
import Alamofire

class ApiManager {
    private var genericError = NSError(domain: "Erro :(", code: 400, userInfo: [NSLocalizedDescriptionKey : "Tivemos um problema ao obter as informações"])
    
    func isRegisterSucess(user: User, completion: @escaping (_ result: Bool, _ error: NSError?) -> Void) {
        let url = API.baseURL + API.users
        let parameters: Parameters = ["full_name":user.fullName,"email":user.email,"password":user.password]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if response.response?.statusCode == 201 {
                guard let data = response.data else {
                    completion(false, self.genericError)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserAPI.self, from: data)
                    if result.emailConfirmed == true {
                        completion(true, nil)
                        return
                    }
                }catch {
                    completion(false, self.genericError)
                    return
                }
            }else {
                completion(false, self.genericError)
                print(response.description)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (_ result: String?, NSError?) -> Void) {
        let url = API.baseURL + API.tokenUser
        let header: HTTPHeaders = [
            .authorization(username: email, password: password)
        ]
        AF.request(url, method: .post, headers: header)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {
                        completion(nil, self.genericError)
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(Token.self, from: data)
                        completion(result.token, nil)
                        return
                        
                    }catch {
                        completion(nil, self.genericError)
                        return
                    }
                }else {
                    completion(nil, self.genericError)
                    print(response.description)
                }
            }
    }
    
    func getAllImmobiles(token: String, completion: @escaping (_ result: [Immobile]?, NSError?) -> Void) {
        let url = API.baseURL + API.imoveis
        let bearer = "Bearer \(token)"
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        
        AF.request(urlRequest).responseJSON { response in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    completion(nil, self.genericError)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ImmobileAPI.self, from: data)
                    completion(result.items, nil)
                    return
                    
                }catch {
                    completion(nil, self.genericError)
                    return
                }
            }else {
                completion(nil, self.genericError)
                print(response.description)
            }
        }
    }
    
//    func uploadImgur(image: UIImage, completion: @escaping (_ result: String?, NSError?) -> Void) {
//
//        getBase64Image(image: image) { base64img in
//            let boundary = "Boundary-\(UUID().uuidString)"
//            let url = "https://api.imgur.com/3/image"
//            let clientID = "Client-ID 0e6f73b80074890"
//            var urlRequest = URLRequest(url: URL(string: url)!)
//            urlRequest.httpMethod = "POST"
//            urlRequest.setValue(clientID, forHTTPHeaderField: "Authorization")
//            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//            urlRequest.httpMethod = "POST"
//
//            var body = ""
//            body += "--\(boundary)\r\n"
//            body += "Content-Disposition:form-data; name=\"image\""
//            body += "\r\n\r\n\(base64img ?? "")\r\n"
//            body += "--\(boundary)--\r\n"
//            let postData = body.data(using: .utf8)
//            urlRequest.httpBody = postData
//
//            AF.request(urlRequest).responseJSON { response in
//                if response.response?.statusCode == 200 {
//                    guard let data = response.data else {
//                        completion(nil, self.genericError)
//                        return
//                    }
//
//                    do {
//                        let result = try JSONDecoder().decode(ImgurAPI.self, from: data)
//                        completion(result.data.link, nil)
//                        return
//
//                    }catch {
//                        completion(nil, self.genericError)
//                        return
//                    }
//                }else {
//                    completion(nil, self.genericError)
//                    print(response.description)
//                }
//            }
//        }
//    }
//
//    func getBase64Image(image: UIImage, complete: @escaping (String?) -> ()) {
//        DispatchQueue.main.async {
//            let imageData = image.pngData()
//            let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
//            complete(base64Image)
//        }
//    }
    
}
