//
//  HomeViewModel.swift
//  testAppSwift
//
//  Created by Salman Afzal on 08/08/2024.
//

import Foundation
import UIKit

protocol HomeViewModellDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func didGetSongsData()
    func didFailWithError(_ error: Error)
}


class HomeViewModel {
        
   weak var delegate: HomeViewModellDelegate?
   
    var songs: [Song] = []
    var filteredSongs: [Song] = []
        
    
    func fetchMusicData(artist: String){
        let artestName = artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        delegate?.showLoader()
        APIManager.shared.fetchData(endpoint: .songsByArtistName(name: artestName), responseType: MusicResponse.self) { [self] result in
            delegate?.hideLoader()
                    switch result {
                    case .success(let songs):
                            self.songs = songs.results
                            filteredSongs = songs.results
                            delegate?.didGetSongsData()
                    case .failure(let error):
                            delegate?.didFailWithError(error)                 
                    }
                }
    }
    
    }
