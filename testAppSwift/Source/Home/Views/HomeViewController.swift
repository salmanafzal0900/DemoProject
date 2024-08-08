//
//  HomeViewController.swift
//  testAppSwift
//
//  Created by Salman Afzal on 08/08/2024.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var audioPlayerView: AudioPlayerView!
    
    // MARK: - Properties
    
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    
    lazy private var viewModel: HomeViewModel = {
        let vm  = HomeViewModel()
        vm.delegate = self
        return vm
    }()
    
    var isSearching = false
    var currentlyPlayingIndex: IndexPath?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        setupNavigationBar()
        viewModel.fetchMusicData(artist: "top hits")
    }
    
    
    func UISetup(){
     
        tableView.register(UINib(nibName: NoDataCell.nibName, bundle: nil), forCellReuseIdentifier: NoDataCell.identifier)
        tableView.register(UINib(nibName: SongCell.nibName, bundle: nil), forCellReuseIdentifier: SongCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        audioPlayerView.isHidden = true
        audioPlayerView.color = AppThemeColor.primaryColor

        
    }
    
    private func setupNavigationBar() {
        searchBar.backgroundImage = UIImage() 
        // Set up the title label
        titleLabel.text = "Musify"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white

        // Set up the logo image
        logoImageView.image = UIImage(named: "logo.app")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        // Create a horizontal stack view to hold the logo and title
        let stackView = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8 // Adjust spacing as needed
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Set the title view of the navigation item
        self.navigationItem.titleView = stackView

        // Set constraints for the logo image
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 40), // Adjust width as needed
            logoImageView.heightAnchor.constraint(equalToConstant: 40) // Adjust height as needed
        ])
    }
      
     
    

    
    func stopPlayback() {
        // Stop and hide audio player if searching
        audioPlayerView.player?.pause()
        audioPlayerView.isHidden = true
        currentlyPlayingIndex = nil
       }

    
    
 

    
}



// MARK: -  UITableViewDataSource Methods
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredSongs.isEmpty ? 1 : viewModel.filteredSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.filteredSongs.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.identifier, for: indexPath) as! NoDataCell
            cell.lblTitle.text = "No data available. Try searching with a different artist name."
                     return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier, for: indexPath) as! SongCell
        let song = viewModel.filteredSongs[indexPath.row]
        cell.updateCell(title: song.trackName,
                        detail: song.artistName,
                        isPlaying: !(currentlyPlayingIndex == indexPath))
        return cell
    }
    
    // UITableViewDelegate Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = viewModel.filteredSongs[indexPath.row]
        //audioPlayerView.playPreview(urlString: song.previewUrl, songName: song.trackName)
        
        audioPlayerView.audioURL = song.previewUrl
        audioPlayerView.trackName = song.trackName
        audioPlayerView.player?.play()
        audioPlayerView.isHidden = false
        
        currentlyPlayingIndex = indexPath
        tableView.reloadData()
    }
    
    // Optionally, you can adjust the height of the rows
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    
    
}
// UISearchBarDelegate Methods


extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let artist = searchBar.text, !artist.isEmpty {
            viewModel.fetchMusicData(artist: artist)
        }
        stopPlayback()
    }
}


// MARK: HomeViewModell Delegate
extension HomeViewController: HomeViewModellDelegate {
    func didGetSongsData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    
    func showLoader() {
        ActivityIndicatorManager.shared.showLoader(in: self.view )
    }
    
    func hideLoader() {
        ActivityIndicatorManager.shared.hideLoader()
    }
    
    func didFailWithError(_ error: any Error) {
        DispatchQueue.main.async {
            AlertManager.shared.showAlert(on: self, title: "Error", message: "\(error)")
        }
    }
}
