//
//  GetGithubItemsUseCase.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/01.
//

import Foundation

class GetGithubItemsUseCase: UseCaseProtocol {
    
    struct ResponseResult: Codable {
        let items: [GithubItemEntitiy]
    }
    
    var baseURL: String {
        return "https://api.github.com"
    }

    var path: String {
        return "/search/repositories"
    }
    
    var buildUrl: String {
        return URL(string: baseURL)!.appendingPathComponent(path).absoluteString
    }
    
    let parameter: GithubItemsParameter

    init(language: String = "swift", page: Int = 1, per_page: Int = 20) {

        self.parameter = GithubItemsParameter(
            language: language,
            page: page,
            per_page: per_page
        )
    }
    
    func requestUrl(url: String, parameter: GithubItemsParameter) -> URL? {
        let params = parameter.toDictionary()
        
        let result = params.enumerated().map { index, param -> String in
            let queryString = index == 0 ? "?" : "&"
            return queryString + "\(param.key)=\(param.value)"
        }.joined()
        
        return URL(string: url + result)
    }
}

extension GetGithubItemsUseCase {
    func execute(_ parameter: GithubItemsParameter, completion: ((Result<[GithubItemEntitiy], Error>) -> ())?) {
        
        guard let url = self.requestUrl(url: buildUrl, parameter: parameter) else { return }
        
        print(url.absoluteString)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            
            guard let data = data, let decoded = try? JSONDecoder().decode(ResponseResult.self, from: data) else {
                let error = NSError(
                    domain: "parse-error",
                    code: 1,
                    userInfo: nil
                )
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion?(.success(decoded.items))
            }
        }
        
        task.resume()
    }
}
