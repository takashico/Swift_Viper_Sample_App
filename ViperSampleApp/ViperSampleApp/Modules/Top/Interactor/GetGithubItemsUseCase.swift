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
    
    func execute(_ parameter: Void, completion: ((Result<[GithubItemEntitiy], Error>) -> ())?) {
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=swift&page=20") else { return }
        
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
