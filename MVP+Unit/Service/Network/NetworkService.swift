import UIKit

protocol NetworkServiceProtocol {
    
    func getDataFromUrl<T: Codable>(url: URL, completion: @escaping BackendOperationHandler<T>)
    
    func getPlaceData(completion: @escaping BackendOperationHandler<Place>)
    
    func getMovieData(competion: @escaping BackendOperationHandler<Movie>)
    
}

final class NetworkService: NetworkServiceProtocol {
    
    private var casheImage = NSCache<NSString, UIImage>()
    
    func getDataFromUrl<T: Codable>(url: URL, completion: @escaping BackendOperationHandler<T>) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError(description: error.localizedDescription)))
                }
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError(description: "Error response")))
                }
                return
            }
            
            DispatchQueue.main.async {
                
                switch StatusCode.returnResult(for: response.statusCode) {
                    
                case .information:
                    print("Status code :- \(response.statusCode)")
                    completion(.failure(.information(description: "clientError", statusCode: response.statusCode)))
                    
                case .success:
                    guard let data = data else {
                        completion(.failure(.unresolved(description: "catch failure", statusCode: response.statusCode)))
                        return
                    }
                    print("Status code :- \(response.statusCode)")
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(model))
                    }
                    catch {
                        completion(.failure(.decodeError(description: "Error with data")))
                    }
                case .resursive:
                    print("Status code :- \(response.statusCode)")
                    completion(.failure(.redirection(description: "resursive", statusCode: response.statusCode)))
                    
                case .authError:
                    print("Status code :- \(response.statusCode)")
                    completion(.failure(.authError(description: "authError", statusCode: response.statusCode)))
                    
                case .clientError:
                    print("Status code :- \(response.statusCode)")
                    completion(.failure(.clientError(description: "clientError", statusCode: response.statusCode)))
                    
                case .serverError:
                    print("Status code :- \(response.statusCode)")
                    completion(.failure(.serverError(description: "serverError", statusCode: response.statusCode)))
                }
            }
        }.resume()
    }
    
    func fetchImageData(from url: URL, completion: @escaping (UIImage) -> Void) {
        
        if let cashedImage = casheImage.object(forKey: url.absoluteString as NSString) {
            completion(cashedImage)
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let mimeType = response.mimeType,
                mimeType.hasPrefix("image"),
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            self.casheImage.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}


extension NetworkService {
    
    func getPlaceData(completion: @escaping BackendOperationHandler<Place>) {
        getDataFromUrl(url: EndPoint.getPlaceUrl(), completion: completion)
    }
    
    func getMovieData(competion: @escaping BackendOperationHandler<Movie>) {
        getDataFromUrl(url: EndPoint.getMovieUrl(film: "tt3896198"), completion: competion)
    }
}
