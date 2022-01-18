import UIKit

// GET, POST, PUT, DELETE, etc.

func makePOSTRequest() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        return
    }
    
    print("Making api call...")
    
    var request = URLRequest(url: url)
    
    // method, body, headers
    request.httpMethod = "POST"
    request.timeoutInterval = 20
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: AnyHashable] = [
        "userId": 1,
        "title": "Hello From iOS Academy",
        "body": "The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog."
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.fragmentsAllowed)
    
    // Make the request
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            print("SUCCESS: \(response)")
        }
        catch {
            print(error)
        }
    }
    task.resume()
}

struct Response: Codable {
    let body: String
    let id: Int
    let title: String
    let userId: Int
}

makePOSTRequest()

