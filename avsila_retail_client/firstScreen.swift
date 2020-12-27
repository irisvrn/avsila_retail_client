//
//  firstScreen.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 15.02.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//
//Users/eugene/Yandex.Disk.localized/xCode/avsila_retail_client/avsila_retail_client/personalTVC.swift
import UIKit
let garageLabel = UILabel()
let garageVinLabel = UILabel()
let garageImageView = UIImageView()
let garageImage = UIImage(named: "vestasmall")
let garageView = UIView()
let garageView2 = UIView()
var stackView = UIStackView()
var myScrollView = UIScrollView()
var offerScrollView = UIScrollView()

var testimageview = UIImageView()

var testButton = UIButton()

//var collectionViewRect = CGRect(x: 5, y: 10, width: 300, height: 200)
var flowLayout = UICollectionViewFlowLayout()
var collectionViewRect = CGRect()
var readCollectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: flowLayout)

var readCollectionViewCell = UICollectionViewCell()
var readArray = ["Испытания антигелей для дизтоплива","Испытания тестера для тормозной жидкости AIRLINE","Как отличить масло подделку от оригинала?"]
var readImageArray = ["read1", "read2", "read3"]
                

class firstScreen: UITableViewController {

    @IBAction func toSTOpage(_ sender: Any) {
        goToSTOPage()
    }
    
    @IBOutlet weak var garageTableViewCell: UITableViewCell!
    @IBOutlet weak var discountCardImageView: UIImageView!
    @IBOutlet weak var offerTableViewCell: UITableViewCell!
    @IBOutlet weak var readTableViewCell: UITableViewCell!
    @IBOutlet weak var labelDiscountCarTop: UILabel!
    
    
    //MARK: adding cart controller
    @IBAction func addCartButton(_ sender: Any) {
       let registerViewController = self.storyboard?.instantiateViewController(identifier: "AddCartViewController") as! AddCartViewController
         navigationController?.pushViewController(registerViewController, animated: true)
//
        
        //  self.present(registerViewController, animated: true, completion: nil)
          
        /*
        let vc = AddCartViewController()
               vc.title = "Добавление дисконтной карты"
               let navVC = UINavigationController(rootViewController: vc)
               navVC.modalPresentationStyle = .fullScreen
               present(navVC, animated: true)*/
    }
    
    
    @IBAction func goToPersonalPageButton(_ sender: Any) {
        //MARK: открыть другой контроллер
        if Model.shared.loginValue == true {
            let registerViewController = self.storyboard?.instantiateViewController(identifier: "personalTVC") as! personalTVC
            self.present(registerViewController, animated: true, completion: nil)
        } else {
            let registerViewController = self.storyboard?.instantiateViewController(identifier: "fLoginVC") as! fLoginVC
            self.present(registerViewController, animated: true, completion: nil)
        }
        
        print("ok")
    }
    
    func goToSTOPage() {
        //MARK: открыть другой контроллер
        if Model.shared.loginValue == true {
            let registerViewController = self.storyboard?.instantiateViewController(identifier: "stovc") as! STOVC
            self.present(registerViewController, animated: true, completion: nil)
            
            
           // let stoPage = self.storyboard?.instantiateViewController(identifier: "stovc") as! STOVC
           // let appDelegate = UIApplication.shared.delegate
          //  appDelegate?.window??.rootViewController = stoPage
            
            
        } else {
            let registerViewController = self.storyboard?.instantiateViewController(identifier: "fLoginVC") as! fLoginVC
            self.present(registerViewController, animated: true, completion: nil)
        }
        
        
        
        print("ok")
    }
    
    
    func readCollection() {

        collectionViewRect = CGRect(x: 0, y: 50, width: readTableViewCell.frame.width, height: 200)
        flowLayout.itemSize = CGSize(width: 160, height: 150)
        flowLayout.minimumInteritemSpacing = CGFloat(10)
        flowLayout.scrollDirection = .horizontal
        
        readCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "readcell")

        readCollectionView.backgroundColor = readTableViewCell.backgroundColor
        readCollectionView.showsHorizontalScrollIndicator = false
        
        readCollectionView.dataSource = self
        readCollectionView.delegate = self
        readTableViewCell.addSubview(readCollectionView)
        
   
        testimageview.frame = CGRect(x: 130, y: 300, width: 120, height: 80)
        testimageview.backgroundColor = .green
        readTableViewCell.addSubview(testimageview)
        
        
    }
    
    
    @objc func testbuttonaction() {
        var ttimage = UIImage()
            testimageview.frame = CGRect(x: 130, y: 300, width: 80, height: 80)
            testimageview.backgroundColor = .green
        print(Model.shared.resultImage.count)
        ttimage = UIImage(named: "vesta")!//Model.shared.resultImage
        Model.shared.resultImage.append(ttimage)
        print(Model.shared.resultImage.count)
       
        
        
        testimageview.image = Model.shared.resultImage[28]
          //  print(Model.shared.resultImage)
            readTableViewCell.addSubview(testimageview)
    }
    
    func garageSlider() {
              //хорошо подходит для банеров. надо научиться перещелкивать
        
               let grantaImage = UIImage(named: "granta")
               let vestaImage = UIImage(named: "vesta")
               let largusImage = UIImage(named: "largus")
               let oneMoreGranta = UIImage(named: "granta")
        
              let scrollViewRect = self.view.bounds
        
               myScrollView = UIScrollView(frame: scrollViewRect)
             
               myScrollView.isPagingEnabled = false
          //     myScrollView.contentSize = CGSize(width: scrollViewRect.size.width * 4/1.5, height: scrollViewRect.size.height)
               myScrollView.contentSize = CGSize(width: scrollViewRect.size.width * 4/1.5, height: garageTableViewCell.frame.height)
               myScrollView.showsHorizontalScrollIndicator = false
              
        
          //      var imageViewRect = CGRect(x:0 , y: 0, width: view.frame.width/2.5, height: view.frame.height)
                var imageViewRect = CGRect(x:10 , y: 0, width: garageTableViewCell.frame.width/1.5, height: garageTableViewCell.frame.height)
                       print(imageViewRect)
        
                       let grantaImageView = newImageViewWithImage(paramImage: grantaImage!, paramFrame: imageViewRect)
                       myScrollView.addSubview(grantaImageView)
                       
                       imageViewRect.origin.x += imageViewRect.size.width + 20
                       let vestaImageView = newImageViewWithImage(paramImage: vestaImage!, paramFrame: imageViewRect)
                       myScrollView.addSubview(vestaImageView)
                       
                       imageViewRect.origin.x += imageViewRect.size.width + 20
                       let lagrusImageView = newImageViewWithImage(paramImage: largusImage!, paramFrame: imageViewRect)
                       myScrollView.addSubview(lagrusImageView)
                       
                       imageViewRect.origin.x += imageViewRect.size.width + 20
                       let oneMoreGrantaImageView = newImageViewWithImage(paramImage: oneMoreGranta!, paramFrame: imageViewRect)
                       myScrollView.addSubview(oneMoreGrantaImageView)
        
                    self.garageTableViewCell.addSubview(myScrollView)
        
    }
    
    func offerSlider() {
           
                  let image1 = UIImage(named: "nabor")
                  let image2 = UIImage(named: "oil")
                  let image3 = UIImage(named: "celib")
                  let imageView1 = UIImageView()
                    let imageView2 = UIImageView()
                    let imageView3 = UIImageView()
            //
                    let view1 = UIView()
                    let view2 = UIView()
                    let view3 = UIView()
                    let view1Label = UILabel()
                    let view2Label = UILabel()
                    let view3Label = UILabel()
                        
        
//                    view1.backgroundColor = .blue
//                    view2.backgroundColor = .green
//                    view3.backgroundColor = .yellow
//
                    view1Label.text = "Подарок при покупке набора"
                    view1Label.frame = CGRect(x: 10, y: 120, width: 230, height: 40)
                    view1Label.textColor = .darkGray
                    imageView1.image = image1
                    imageView1.frame = CGRect(x: 10, y: 10, width: 220, height: 110)
                    imageView1.contentMode = .scaleAspectFit
        
        
                    view2Label.text = "Подарок при покупке масла"
                    view2Label.frame = CGRect(x: 10, y: 120, width: 230, height: 40)
        
                    imageView2.image = image2
                    imageView2.frame = CGRect(x: 10, y: 10, width: 220, height: 110)
                    imageView2.contentMode = .scaleAspectFit
             
                    view2Label.textColor = .darkGray
                    view3Label.text = "Скидка 23% к 23 февраля"
                    view3Label.frame = CGRect(x: 10, y: 120, width: 230, height: 40)
                    view3Label.textColor = .darkGray
                    imageView3.image = image3
                                     imageView3.frame = CGRect(x: 10, y: 10, width: 220, height: 110)
                                     imageView3.contentMode = .scaleAspectFit
                         
        
        
                 let scrollViewRect = self.view.bounds
           
                  offerScrollView = UIScrollView(frame: scrollViewRect)
                
                  offerScrollView.isPagingEnabled = false
                  offerScrollView.contentSize = CGSize(width: scrollViewRect.size.width * 3/1.5, height: 170)
                  offerScrollView.showsHorizontalScrollIndicator = false
                 
                var ViewRect = CGRect(x:10 , y: 50, width: offerTableViewCell.frame.width/1.5, height: 160)
                        
                        view1.frame = ViewRect
                        view1.addSubview(view1Label)
                        view1.addSubview(imageView1)
                        offerScrollView.addSubview(view1)
                          
                          ViewRect.origin.x += ViewRect.size.width
                          view2.frame = ViewRect
                          view2.addSubview(view2Label)
        view2.addSubview(imageView2)
                          offerScrollView.addSubview(view2)
                          
                          ViewRect.origin.x += ViewRect.size.width
                          view3.frame = ViewRect
                          view3.addSubview(view3Label)
        view3.addSubview(imageView3)
                          offerScrollView.addSubview(view3)
                          
                       self.offerTableViewCell.addSubview(offerScrollView)
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: загружаем JSON
        
        if Model.shared.loginValue == false {
            labelDiscountCarTop.text = "Дисконтная карта (logged Out)"
        } else {
            labelDiscountCarTop.text = "Дисконтная карта (logged In)"
        }
        Model.shared.loadJSONFileAlbums()
        
        discountCardImageView.layer.cornerRadius = 15
        garageSlider()
        offerSlider()
    
        readCollection()
 
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "albumRefresh"), object: nil, queue: nil) { (notification) in
            
            
            //MARK: обновляем таблицу в основном потоке
            DispatchQueue.main.async {
                readCollectionView.reloadData()
            }
            
            Model.shared.downloadImage()
            print("dataRefresh")
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "imageRefresh"), object: nil, queue: nil) { (notification) in
            
            
            //MARK: обновляем таблицу в основном потоке
            DispatchQueue.main.async {
                readCollectionView.reloadData()
            }
        }

        
        
        
    }

    
    func  newImageViewWithImage(paramImage: UIImage, paramFrame: CGRect)-> UIImageView {
           let result = UIImageView(frame: paramFrame)
           result.contentMode = .scaleAspectFit
           result.image = paramImage
           return result
       }
    


    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension firstScreen:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ readCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.shared.resultAlbums.count
    }
    
    func collectionView(_ readCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let readcell = readCollectionView.dequeueReusableCell(withReuseIdentifier: "readcell", for: indexPath) as! CollectionViewCell
        
        var albumRow : (Model.albums)
        
        albumRow = Model.shared.resultAlbums[indexPath.row]
        readcell.cellLbl.text = albumRow.collectionName

        if Model.shared.loginValue == true
        {
          //  readcell.cellImg.image = Model.shared.resultImage[indexPath.row]
        }
    
        if Model.shared.resultImage.count>0 {
            readcell.cellImg.image = Model.shared.resultImage[indexPath.row]
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "imageRefresh"), object: nil, queue: nil) { (notification) in
            //MARK: обновляем таблицу в основном потоке
            DispatchQueue.main.async {
                 readCollectionView.reloadData()
            }
        }
        return readcell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("user pressed \(indexPath.row) \(Model.shared.resultAlbums[indexPath.row].collectionName)")
        testimageview.image = Model.shared.resultImage[indexPath.row]
        // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageRefresh"), object: self)
    }
}
