//
//  HomeViewController.swift
//  cabeGram
//
//  Created by Harrie Santoso on 26/09/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    var cabes: [Cabe] = []
    var homeHandler: HomeHandler = HomeHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cabes = homeHandler.panenCabe()
        tableView.register(HomeCell.self,
                           forCellReuseIdentifier: HomeCell.cellID)
        view.backgroundColor = .lightGray
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cabes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeCell? = tableView.dequeueReusableCell(withIdentifier: HomeCell.cellID) as? HomeCell
        
        if let cell = cell {
            cell.cabe = cabes[indexPath.row]
            cell.snitch()
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navigationController = navigationController {
            let cabeDetailVC = CabeDetailViewController()
            cabeDetailVC.cabe = cabes[indexPath.row]
            
            navigationController.pushViewController(cabeDetailVC,
                                                    animated: true)
        }
    }
}

class HomeHandler {
    
    func panenCabe() -> [Cabe] {
        return [
            Cabe(name: "Cabe Ijo",
                 imageURLS: [
                    URL(string: "https://statik.tempo.co/data/2018/04/18/id_699111/699111_720.jpg")!,
                    URL(string: "https://img-global.cpcdn.com/003_recipes/23fed89545441516/751x532cq70/sambal-teri-cabe-ijo-foto-resep-utama.jpg")!,
                    URL(string: "https://ecs7.tokopedia.net/img/cache/700/product-1/2018/10/31/2532049/2532049_34758ff7-4fac-416f-b2b1-42ff4f364418_1368_1368.jpg")!
                ]),
            Cabe(name: "Cabe Merah",
                 imageURLS: [
                    URL(string: "https://ecs7.tokopedia.net/img/cache/700/product-1/2019/2/11/9627105/9627105_08c857a8-c683-4bd5-97b2-f41f37c6b93e_320_320.png")!,
                    URL(string: "https://ecs7.tokopedia.net/img/cache/700/product-1/2019/2/11/9627105/9627105_365aca53-fc2a-4a8d-88aa-fa72fdae2cc3_520_574.jpg")!,
                    URL(string: "https://alamtani.com/wp-content/uploads/jenis-jenis-cabe.jpg")!
                ]),
            Cabe(name: "Cabe Carolina",
                 imageURLS: [
                    URL(string: "https://cdn.shopify.com/s/files/1/0220/1512/products/IMG-2206.png?v=1553756972")!,
                    URL(string: "https://www.chileseeds.co.uk/wp-content/uploads/2018/12/jays-x-pink-tiger-x-reaperchilliseeds.jpg")!,
                    URL(string: "https://www.ilikeithot.eu/wp-content/uploads/2018/08/Carolina_reaper-VolimLjuto.jpg")!
                ])
        ]
    }
}

class HomeCell: UITableViewCell {
    static var cellID: String = "HomeCell"
    
    var cabe: Cabe? {
        didSet {
            guard let cabe = cabe else {
                return
            }
            
            nameText = cabe.name
            imageURL = cabe.imageURLS.first
            
        }
    }
    
    var cellHeight: CGFloat = 120
    
    private var nameText: String = ""
    private var imageURL: URL? = nil
    
    private var cabeImageView: UIImageView = UIImageView()
    private var cabeName: UILabel = UILabel()
    
    func snitch() {
        snitchImageView()
        snitchName()
    }
    
    private func snitchImageView() {
        
        let sideMargin: CGFloat = 12
        let cellWidth: CGFloat = frame.width - (2*sideMargin)
        
        cabeImageView.downloaded(from: imageURL!)
        cabeImageView.frame = CGRect(x: sideMargin,
                                     y: sideMargin,
                                     width: cellWidth,
                                     height: cellHeight - (2*sideMargin) - 30)
        
        addSubview(cabeImageView)
    }
    
    private func snitchName() {
        
        let sideMargin: CGFloat = 12
        
        cabeName.center = CGPoint(x: sideMargin,
                                  y: cabeImageView.frame.height + sideMargin)
        cabeName.text = nameText
        cabeName.sizeToFit()
        
        addSubview(cabeName)
    }
}

struct Cabe {
    var name: String
    var imageURLS: [URL]
}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
