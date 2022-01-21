//
//  ApiClient.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/06/1443 AH.
//

import Foundation

//MARK:-Api Client
class ApiClient {
    
    enum SearchCriteria : String {
        case categories = "list.php?c=list"
        case area = "list.php?a=list"
    }
    
    
    //MARK:- Endponts Enums
    enum Endpoints {
        static let base = "https://www.themealdb.com/api/json/v1/1/"
        case categoriesList
        case areaList
        case filterbyArea(String)
        case filterbyCategory(String)
        case recipeLookUp(String)
        case thumbImage(String)
        case bannerImage(String)
        
        
        var stringValue: String {
            switch self {
            case .categoriesList: return Endpoints.base + SearchCriteria.categories.rawValue
            case .areaList: return Endpoints.base + SearchCriteria.area.rawValue
            case .filterbyArea(let area): return Endpoints.base + "filter.php?a=\(area)"
            case .filterbyCategory(let category): return Endpoints.base + "filter.php?c=\(category)"
            case .recipeLookUp(let recipeId): return Endpoints.base + "lookup.php?i=\(recipeId)"
            case .thumbImage(let url): return url + "/preview"
            case .bannerImage(let url): return url
                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    //MARK:- post Request
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType:ResponseType.Type, completion: @escaping(ResponseType?, Error?)-> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                
                
            }
        }
        task.resume()
    }
    
    
    //MARK:- Get Categories List
    class func requestCategoriesList(completionHandler: @escaping ([String], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.categoriesList.url, responseType: CategoriesList.self) { (response, error) in
            if let response = response {
                let catList = response.category.map({$0})
                var stringlist: [String] = []
                for category in catList {
                    print("\(category.name)")
                    stringlist.append(category.name)
                }
                completionHandler(stringlist, nil)
                
            }else {
                completionHandler([], error)
            }
        }
    }
    
    //MARK:- Get Location Area List
    class func requestAreaList(completionHandler: @escaping ([String], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.areaList.url, responseType: AreaList.self) { (response, error) in
            if let response = response {
                let catList = response.area.map({$0})
                var stringlist: [String] = []
                for category in catList {
                    print("\(category.name)")
                    stringlist.append(category.name)
                }
                completionHandler(stringlist, nil)
                
            }else {
                completionHandler([], error)
            }
        }
    }
    
    
    //MARK:- Get Short Recipe List

    class func requestRecipeList(url:URL, completionHandler: @escaping ([ShortRecipe], Error?) -> Void) {
        taskForGETRequest(url: url, responseType: RecipeListResponse.self) { (response, error) in
            if let response = response {
                completionHandler(response.list, nil)
            }else {
                completionHandler([], error)
            }
        }
    }
    
    
    //MARK:- Download Recipe ThumbImage

    class func downloadThumbImage(path: String, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.thumbImage(path).url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    //MARK:- Download full Recipe Banner
    /*
     download the full image Banner
     */
    class func downloadBannerImage(imageUrl: String, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.bannerImage(imageUrl).url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    
    //MARK:-Get Full Recipe
    class func requestFullRecipe(recipeId: String, completion: @escaping (RestRecipe?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.recipeLookUp(recipeId).url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
               let meals = json["meals"] as? [[String:Any]], // the response comes as an Array
               let strMeal = meals[0]["strMeal"] as? String, meals.count > 0 {
                let idMeal = (meals[0]["idMeal"] as? String) ??  ""
                let strCategory = meals[0]["strCategory"] as? String ??  ""
                let strArea = meals[0]["strArea"] as? String ??  ""
                let strInstructions = meals[0]["strInstructions"] as? String ??  ""
                let strMealThumb = meals[0]["strMealThumb"] as? String ??  ""
                let strTags = meals[0]["strTags"] as? String ??  ""
                let strYoutube = meals[0]["strYoutube"] as? String ?? ""
                let strSource = meals[0]["strSource"] as? String ??  ""
               

                var ingredients : [RecipeIngredients] = []
                for n in 1...20 {
                    let strIngredient = meals[0]["strIngredient\(n)"] as? String ?? ""
                    if strIngredient != "" {
                        let strMeasure = meals[0]["strMeasure\(n)"] as? String ?? ""
                        let recipeIngredients = RecipeIngredients(name: strIngredient, quantity: strMeasure)
                        ingredients.append(recipeIngredients)
                    }
                    
                }
                /*
                 formatted Recipe Data
                 and put it in a RestRecipe struct
                 */
                let recipe = RestRecipe(name: strMeal , id: idMeal, category: strCategory, area: strArea, instructions: strInstructions, tags: strTags, imageUrl: strMealThumb, youtubeLink: strYoutube, source: strSource, ingredients: ingredients)
                DispatchQueue.main.async {
                    completion(recipe, nil)
                }
            }
            
        }
        task.resume()
    }
}
