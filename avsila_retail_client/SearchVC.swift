//
//  SearchVC.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 22.02.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit


// поиск брендов по номеру
// https://avtosila-vrn.ru.public.api.abcp.ru/search/brands/?userlogin=ied@avtosila-v.ru&userpsw=01b9c6e65cff3f0c4b39bc1cb9595111&number=01089
// поиск по артикулу и бренду
// https://avtosila-vrn.ru.public.api.abcp.ru/search/articles/?userlogin=ied@avtosila-v.ru&userpsw=01b9c6e65cff3f0c4b39bc1cb9595111&number=01089&brand=febi

//В начале поиск по арктикулу брендов, если есть несколько строк, то выводим и по нему надо кликнуть потом показать список предложений
//если только одно предложение, т.е. артикул, то сразу второй зарпрос на результаты поиска.

// выводим то результаты поиска и бренды (как группировать по цене или по бренду?)

class SearchVC: UIViewController {
    var loadVC = UIView()
    var actIndic = UIActivityIndicatorView()
    var loadingLabel = UILabel()
    var bidWinLabel = UILabel()
    var bidLoseLabel = UILabel()
    var bidWinInput = UITextField()
    var bidLoseInput = UITextField()
    var searchTextField = UITextField()
    var tableSearchResult = UITableView()
    var searchLine = UISearchBar()
    var newCell = UITableViewCell()
    var cellid = "newCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        preloadVC()
        tableSearch()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "offerRefresh"), object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
                self.hidePreloadVCindicator()
                self.tableSearchResult.reloadData()
            }
        }
    }

    func tableSearch() {
        searchLine.sizeToFit()
        searchLine.placeholder = "Введите артикул"
        searchLine.showsCancelButton = true
        searchLine.becomeFirstResponder()
        searchLine.backgroundColor = .systemTeal
        searchLine.delegate = self //важно!!

        
        tableSearchResult.frame = CGRect(x: 1, y: 150, width: view.frame.width-2, height: view.frame.height-150)
        view.addSubview(tableSearchResult)
        tableSearchResult.layer.cornerRadius = 10
        tableSearchResult.dataSource = self
        tableSearchResult.delegate = self
        tableSearchResult.rowHeight = 80
        //tableSearchResult.addSubview(searchLine)
        view.addSubview(searchLine)
        //tableSearchResult.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        tableSearchResult.register(searchTableViewCell.self, forCellReuseIdentifier: cellid)
        
        //MARK:add constraints to table
        searchLine.layer.masksToBounds = true
        searchLine.translatesAutoresizingMaskIntoConstraints = false
        searchLine.topAnchor.constraint(equalTo: view.topAnchor, constant: 91).isActive = true
        searchLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2).isActive = true
        searchLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -2).isActive = true
        searchLine.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        //MARK:add constraints to table
        tableSearchResult.layer.masksToBounds = true
        tableSearchResult.translatesAutoresizingMaskIntoConstraints = false
        tableSearchResult.topAnchor.constraint(equalTo: searchLine.bottomAnchor, constant: 2).isActive = true
        tableSearchResult.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableSearchResult.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableSearchResult.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
              
    //    tableSearchResult.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
     
        
    }
    
    @objc func searchaction() {
    
      //  let searchTextFieldClean = cleanArticle(article: searchTextField.text!)
        let searchTextFieldClean = cleanArticle(article: searchLine.text!)
             
        print(searchTextFieldClean)
     //   Model.shared.articles.removeAll()
        Model.shared.getBrandsViaArticle(code: searchTextFieldClean) 
        
        //запрос к серверу за брендами и группами товаров
    }
    
    //MARK: Очищаем артикул
    func cleanArticle(article:String) -> String {
        var cleanArt = String(article)
            cleanArt = cleanArt.replacingOccurrences(of: "-", with: "")
             cleanArt = cleanArt.replacingOccurrences(of: "/", with: "")
             cleanArt = cleanArt.replacingOccurrences(of: "*", with: "")
             cleanArt = cleanArt.replacingOccurrences(of: ".", with: "")
             cleanArt = cleanArt.replacingOccurrences(of: ",", with: "")
             cleanArt = cleanArt.replacingOccurrences(of: "(", with: "")
             cleanArt = cleanArt.replacingOccurrences(of: ")", with: "")
             cleanArt = cleanArt.lowercased()
        return cleanArt
    }
    
   
    
    
    func preloadVC() {
        
        loadVC.backgroundColor = .black
        loadVC.layer.cornerRadius = 10
        loadVC.alpha = 0.5

        startActivityIndicator()
        loadVC.layer.masksToBounds = true
        loadVC.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loadVC)
        
        //MARK:add constraints to loadVC
        loadVC.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/2-20).isActive = true
        loadVC.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadVC.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loadVC.heightAnchor.constraint(equalToConstant: 40).isActive = true
       
        startActivityIndicator()
        
        if  (loadingLabel.isHidden == true) || (loadVC.isHidden == true) {
            loadingLabel.isHidden = false
            loadVC.isHidden = false
        }
    }

    func startActivityIndicator() {
       //MARK: add  active indicator on loadVC
        actIndic.color = .white
        actIndic.startAnimating()
        actIndic.layer.masksToBounds = true
        actIndic.translatesAutoresizingMaskIntoConstraints = false
        loadVC.addSubview(actIndic)
        
        //MARK: adsd label on loadVC
        loadingLabel.textColor = .white
        loadingLabel.text = "Loading..."
        loadingLabel.layer.masksToBounds = true
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadVC.addSubview(loadingLabel)
        
        loadVCConstraintInside()
        
    }
    
    func hidePreloadVCindicator() {
        actIndic.stopAnimating()
        loadingLabel.isHidden = true
        loadVC.isHidden = true
    }
    
    func loadVCConstraintInside() {
        //MARK: add constraints to elements inside loadVC
        actIndic.centerYAnchor.constraint(equalTo: loadVC.centerYAnchor, constant: 0).isActive = true
        actIndic.leftAnchor.constraint(equalTo: loadVC.leftAnchor, constant: 3).isActive = true
        actIndic.widthAnchor.constraint(equalToConstant: 30).isActive = true
        actIndic.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        loadingLabel.centerYAnchor.constraint(equalTo: loadVC.centerYAnchor, constant: 0)
        loadingLabel.leftAnchor.constraint(equalTo: actIndic.rightAnchor, constant: 10).isActive = true
        loadingLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
 
    
}


//MARK: table
extension SearchVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Model.shared.multibrand == false {
            return Model.shared.articles.count
        } else {
            return Model.shared.brandFullList.count
        }
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! searchTableViewCell
        
        if Model.shared.multibrand == false {
                   cell.lbl1.text = Model.shared.articles[indexPath.row].brand
                   cell.lbl2.text = Model.shared.articles[indexPath.row].number
                   cell.lbl3.text = ("\(indexPath.row)) \(Model.shared.articles[indexPath.row].description)")
                   cell.lbl4.text = String(Model.shared.articles[indexPath.row].price)
                   cell.lbl5.text = String(Model.shared.articles[indexPath.row].availability) + " шт."
               } else {
                    cell.lbl1.text = Model.shared.brandFullList[indexPath.row].brand
                    cell.lbl2.text = ""
                    cell.lbl3.text = Model.shared.brandFullList[indexPath.row].description
                    cell.lbl4.text = ""
                    cell.lbl5.text = ""
               }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndex = indexPath.row
        if Model.shared.multibrand == false {
              print(currentIndex)
            Model.shared.multibrand = true
        } else {
            Model.shared.multibrand = false
            let articleNumber=cleanArticle(article: Model.shared.brandFullList[currentIndex].number)
            print(Model.shared.brandFullList[currentIndex].brand)
                    print(articleNumber)
            Model.shared.getOffer(brand: Model.shared.brandFullList[currentIndex].brand, code: articleNumber)
            preloadVC()
           
        }
    }
    
}

//MARK: searching in catalog list
extension SearchVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       //print(searchText)
    }
    
    //MARK:скрывать клавиатуру когда нажал на ней Search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print(searchLine.text)
        searchaction()
        preloadVC()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        hidePreloadVCindicator()
        print("clicked cancel")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
