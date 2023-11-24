//
//  NewsViewModel.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

protocol NewsViewModelDelegate {
    func newsFetched(_ news: [News])
    func showError(_ error: Error)
}

// protocol NewsViewModel {
//     var delegate: NewsViewModelDelegate? { get set }
//     func viewDidLoad()
// } ეს დელეგატი არაფერში არ გვჭიდებოდა

final class DefaultNewsViewModel {
        
    // MARK: - Properties
    private let newsAPI = "https://newsapi.org/v2/everything?q=tesla&from=2023-10-25&sortBy=publishedAt&apiKey=8671ece050cf477d972c390b8b85c539"
    
    private var newsList = [News]()
    
    var delegate: NewsViewModelDelegate?

    // MARK: - Public Methods
    func viewDidLoad() {
        fetchNews()
    }
    
    // MARK: - Private Methods
    private func fetchNews() {
        NetworkManager.shared.get(url: newsAPI) { [weak self] (result: Result<Article, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.newsFetched(response.articles) // არასწორ ცვლადს ვაძლევდით
                self?.newsList.append(contentsOf: response.articles)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
