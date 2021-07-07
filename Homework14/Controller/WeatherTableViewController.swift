//
//  WeatherTableViewController.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import UIKit
import Kingfisher
import CoreData

class WeatherTableViewController: UITableViewController {
    
    private let cellID = "WeatherCell"
    private var requestModel: RequestModel?
    private var loadedFlag = false
    private var weatherData: [ListModel] = []
    private var timer = Timer()
    private var weatherCD = [WeatherCD]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadFromCD()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "Weather"
        let nib = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 100
    }
    
    private func setupSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func loadWeather(city: String) {
        DataLoader.shared.load(city: city) { [weak self] (model) in
            if model != nil {
                self?.weatherData.removeAll()
                self?.weatherCD.removeAll()
                self?.requestModel = model
                self?.weatherData.append(contentsOf: model!.list)
                for (index, row) in self!.weatherData.enumerated() {
                    let dateTime = (row.dt_txt)?.components(separatedBy: " ")
                    let newData = WeatherCD(context: self!.context)
                    newData.date = dateTime?[0]
                    newData.time = dateTime?[1]
                    newData.temperature = String(Int(row.main?.temp ?? 0)) + "°С"
                    newData.icon = row.weather?[0].icon ?? ""
                    newData.index = Int64(index)
                    self?.weatherCD.append(newData)
                }
                self?.saveToCD()
                self?.loadedFlag = true
                self?.title = model?.city.name
                self?.tableView.reloadData()
            } else {
                self?.weatherData.removeAll()
            }
        }
    }
    
    func saveToCD() {
        do {
            try context.save()
        } catch  {
            print("Error saving - \(error)")
        }
        tableView.reloadData()
    }
    
    func loadFromCD() {
        let request: NSFetchRequest<WeatherCD> = WeatherCD.fetchRequest()
        do {
            weatherCD = try context.fetch(request)
        } catch {
            print("Error fetching - \(error)")
        }
        tableView.reloadData()
    }
    
    func deleteAllFromCD(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try self.context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                self.context.delete(objectData)
            }
            try self.context.save()
        } catch {
            print("Error delete from CoreData")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loadedFlag {
            return weatherData.count
        } else {
            return weatherCD.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherTableViewCell
        cell.backgroundColor = .lightGray
        weatherCD.sort{
            $0.index < $1.index
        }
        cell.weatherIconImageView?.kf.indicatorType = .activity
        cell.weatherIconImageView?.kf.indicatorType = .activity
        if let icon  = weatherCD[indexPath.row].icon {
        let resource = ImageResource(downloadURL: URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")!, cacheKey: "http://openweathermap.org/img/wn/\(icon)@2x.png")
            cell.weatherIconImageView?.kf.setImage(with: resource)
            
        }
        cell.dateLabel.text = weatherCD[indexPath.row].date
        cell.timeLabel.text = weatherCD[indexPath.row].time
        cell.temperatureLabel.text = weatherCD[indexPath.row].temperature
        
        return cell
    }

}

extension WeatherTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let city = searchController.searchBar.text!
        timer.invalidate()
        if city.count > 1 {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                self.deleteAllFromCD(entity: "WeatherCD")
                self.saveToCD()
                DispatchQueue.main.async {
                    self.loadWeather(city: city)
                    self.title = self.requestModel?.city.name
                }
            })
        }
    }
    
}
