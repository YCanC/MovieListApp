//
//  ViewController.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 18.02.2021.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private let service: Service = ServiceImplementation()
    private var selectedMovieIndex: Int?
    private var pageNumber = 1
    private var cellWidthRatio: CGFloat = 1.1
    
    private var currentlyDisplayingMovieList = [Movie]()
    private var fetchedMovieList = [Movie]() {
        didSet {
            currentlyDisplayingMovieList = fetchedMovieList
            if let moviesCollectionVC = self.moviesCollectionView {
                DispatchQueue.main.async {
                    moviesCollectionVC.reloadData()
                }
            }
        }
    }
    
    private var moviesCollectionView: UICollectionView?
    private let moviesColllectionViewLayout = UICollectionViewFlowLayout()
    private var searchMovieBar = UISearchBar()
    private var isGridLayout = false
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        enableKeyboardDismissing()
        setNavBar()
        setSearchBar()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
        fetchFavouriteMovies()
    }
    
    //MARK: FETCHING PROCESSES
    private func fetchMovies() {
        
        service.getMovies(page: pageNumber) { (result) in
            switch result {
            case .success(let movies):
                
                guard let movieList = movies.results else {
                    print("Error")
                    return
                }
                
                //If the poster taken is already in the list, it is not added.
                //Because this function working on viewWillAppear
                if !self.fetchedMovieList.contains(array: movieList) {
                    self.fetchedMovieList += movieList
                }
                
                if let moviesCollectionVC = self.moviesCollectionView {
                    DispatchQueue.main.async {
                        moviesCollectionVC.reloadData()
                    }
                }
                
            case.failure:
                print("Error")
            }
        }
        
    }
    
    //Fetching favorite movies from local storage
    private func fetchFavouriteMovies() {
        if let savedMovies = GlobalVariables.favouriteMovies.fetchFavourites() {
            GlobalVariables.favouriteMovies = savedMovies
        }
    }
    
}
//MARK: NAVBAR
extension MoviesViewController {
    
    private func setNavBar() {
        self.navigationItem.title = "Content"
        let changeLayoutButton = UIBarButtonItem(image: UIImage.gridType, style: .done, target: self, action: #selector(changeLayout))
        self.navigationItem.rightBarButtonItem  = changeLayoutButton
    }
    
    //Changing collection view to grid view or list view
    @objc func changeLayout() {
        
        //cellWidthRatio is used for change the cell width
        //when cellWidthRatio value is 2.1, collection view returning to listview
        if isGridLayout == false {
            cellWidthRatio = 2.1
            self.navigationItem.rightBarButtonItem?.image = UIImage.listType
            if let moviesCollectionVC = self.moviesCollectionView {
                DispatchQueue.main.async {
                    moviesCollectionVC.reloadData()
                }
            }
            isGridLayout = true
        } else {
            cellWidthRatio = 1.1
            self.navigationItem.rightBarButtonItem?.image = UIImage.gridType
            if let moviesCollectionVC = self.moviesCollectionView {
                DispatchQueue.main.async {
                    moviesCollectionVC.reloadData()
                }
            }
            isGridLayout = false
        }
        
    }
    
}


//MARK: SEARCHBAR
extension MoviesViewController: UISearchBarDelegate {
    
    private func setSearchBar() {
        searchMovieBar.delegate = self
        searchMovieBar.placeholder = "Search Movie"
        view.addSubview(searchMovieBar)
        searchMovieBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchMovieBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchMovieBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchMovieBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //when user tapped on searchBar
        currentlyDisplayingMovieList.removeAll()
        
        if searchText == "" {
            currentlyDisplayingMovieList = fetchedMovieList
        }
        
        //currentlyDisplayingMovieList updated when the user starts typing in the search bar
        for movie in fetchedMovieList {
            guard let movieTitle = movie.title else { return }
            let titleRange = movieTitle.lowercased().range(of: searchBar.text!.lowercased())
            
            if titleRange != nil {
                currentlyDisplayingMovieList.append(movie)
                DispatchQueue.main.async {
                    self.moviesCollectionView?.reloadData()
                }
            }
        }
        DispatchQueue.main.async {
            self.moviesCollectionView?.reloadData()
        }
    }
    
    
}

//MARK: COLLECTIONVIEW
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        moviesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: moviesColllectionViewLayout)
        moviesCollectionView!.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        moviesCollectionView!.register(MoviesCollectionLoadMoreView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MoviesCollectionLoadMoreView.identifier)
        
        moviesCollectionView!.delegate = self
        moviesCollectionView!.dataSource = self
        moviesCollectionView!.backgroundColor = .white
        
        
        view.addSubview(moviesCollectionView!)
        moviesCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviesCollectionView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            moviesCollectionView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            moviesCollectionView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            moviesCollectionView!.topAnchor.constraint(equalTo: searchMovieBar.bottomAnchor)
        ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentlyDisplayingMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell :MoviesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.movie = self.currentlyDisplayingMovieList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //cellWidthRatio is decisive in the collectionView appearance
        return CGSize(width: view.frame.size.width/cellWidthRatio, height: 400)
    }
    
    //this for footeritem, footer item is "load more" button
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width/2, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selectedMovieIndex for prepareForSegue
        selectedMovieIndex = indexPath.row
        self.performSegue(withIdentifier: Constants.toMovieDetailSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toMovieDetailSegue {
            let destinationVc = segue.destination as! MovieDetailViewController
            destinationVc.currentMovie = self.currentlyDisplayingMovieList[selectedMovieIndex!]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MoviesCollectionLoadMoreView.identifier, for: indexPath as IndexPath) as! MoviesCollectionLoadMoreView
        view.loadMoreButton.addTarget(self, action: #selector(loadMorePressed), for: .touchUpInside)
        return view
    }
    
    @objc func loadMorePressed() {
        //pageNumber value is parameter for service.getMovies
        pageNumber += 1
        fetchMovies()
    }
    
}

