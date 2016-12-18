import Foundation
import UIKit
import Endpoints

extension Repository: Item {
    var text: String {
        return name
    }
}

extension RepositoriesResponse: ItemsResponse {
    var items: [Item] {
        return repositories
    }
}

class GithubRepoSearch: PagableSearch {
    typealias CallType = GithubClient.SearchRepositories

    func prepareCallForFirstPage(withQuery query: String) -> CallType {
        return GithubClient.SearchRepositories(endpoint: .query(query, sort: .stars))
    }
    
    func prepareCallForNextPage(forResponse response: CallType.ResponseType.OutputType, fromLastCall lastCall: CallType) -> CallType? {
        guard let nextPage = response.nextPage else {
            return nil
        }
        
        return GithubClient.SearchRepositories(endpoint: .url(nextPage))
    }
}
