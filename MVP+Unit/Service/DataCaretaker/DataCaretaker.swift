import Foundation

class DataCaretaker {
    
    // MARK: - Properties
    
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    // MARK: - Static data caretaker method's
    
    static func saveCategories(_ categories: [Category]) {
        do {
            let encodedCategories = try self.encoder.encode(categories)
            UserDefaults.standard.set(encodedCategories, forKey: ConstantKey.categoriesKey)
        } catch {
            debugPrint(String(describing: error))
        }
    }
    
    static func loadCategories() -> [Category]? {
        guard let data = UserDefaults.standard.data(forKey: ConstantKey.categoriesKey) else { return nil }
        
        do {
            let categories = try self.decoder.decode([Category].self, from: data)
            return categories
        } catch {
            debugPrint(String(describing: error))
            return nil
        }
    }
}

// cтоит ли это делать расширением или все в одно место к остальным костантам

extension DataCaretaker {
    enum ConstantKey {
        static let categoriesKey = "Categories"
    }
}
