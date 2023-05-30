import Foundation

struct EndPoint {
    
    static func getPlaceUrl() -> URL {
        let url = URL(string: "https://rsttur.ru/api/base-app/map")!
        return url
    }
    
    static func getMovieUrl(film: String) -> URL {
        let url = URL(string: "http://www.omdbapi.com/?i=\(film)&apikey=b3465f6f")!
        return url
    }
}

//tt3896198
//tt0120737
//tt0265086
//tt0093058
//tt0111161
//tt0068646
//tt0108052
//tt0120737
//tt0109830
//tt1375666
//tt0133093
//tt0120815
//tt0110357
