//
//  STOVC.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 28.07.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

class STOVC: UIViewController {
    
    
    var flowLayout = UICollectionViewFlowLayout()
      var collectionViewRect = CGRect()
    
      lazy var readCollectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: flowLayout)

      var readCollectionViewCell = UICollectionViewCell()
      var readArray = ["Замена масла бесплатно","Заправка кондиционера от 1000 руб.","Ремонт глушителей","Диагностика подвески"]
      var readImageArray = ["s1100", "s1200", "s1300", "s1400", "s1500", "s1600"]
    
    
    var servicebtn : UIButton = {
        var btn = UIButton()
        btn.setTitle("ОТПРАВИТЬ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .orange
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(pushTheButton), for: .touchDown)
        return btn
    }()
    
    var nameText : UITextField = {
        var txtfield = UITextField()
        txtfield.placeholder = "Имя"
        txtfield.font = UIFont.boldSystemFont(ofSize: 20)
        txtfield.backgroundColor = .white
        txtfield.textColor = .darkGray
        return txtfield
    }()
    
    var phoneText : UITextField = {
        var txtfield = UITextField()
        txtfield.placeholder = "Телефон"
        txtfield.font = UIFont.boldSystemFont(ofSize: 20)
        txtfield.backgroundColor = .white
        txtfield.textColor = .darkGray
        return txtfield
    }()
    
    var titlelbl : UILabel = {
        var lbl = UILabel()
        lbl.text = "Узнать стоимость работ или записаться на сервис"
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        return lbl
    }()
    
    var borderView : UIView = {
        var myview = UIView()
        myview.layer.borderWidth = 1
        myview.layer.borderColor = CGColor(srgbRed: 50, green: 50, blue: 50, alpha: 1)
        return myview
    }()
    
    var backView : UIView = {
        var myview = UIView()
    
     //   let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 230))
        
        backgroundImage.image = UIImage(named: "stophoto")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        myview.backgroundColor = .gray
        myview.insertSubview(backgroundImage, at: 0)
        
        let blackView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 230))
        blackView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        myview.insertSubview(blackView, aboveSubview: backgroundImage)
      //  myview.sendSubviewToBack(backgroundImage)

      //  myview.layer.borderWidth = 1
       // myview.layer.borderColor = CGColor(srgbRed: 50, green: 50, blue: 50, alpha: 1)
        return myview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backView)
        view.addSubview(titlelbl)
        
        view.addSubview(borderView)
        view.addSubview(nameText)
        view.addSubview(phoneText)
        view.addSubview(servicebtn)
        //register(STOCollectionViewCell.self, forCellReuseIdentifier: "readcell")
        readCollection()
        //акции сервиса - collectionView
        //фамилия
        //Номер телефона
        //Кнопка - переход - ура вас записали с вами свяжется консультант
        
        labelConstraints()
        // Do any additional setup after loading the view.
    }
    
    func  labelConstraints() {
        
        titlelbl.translatesAutoresizingMaskIntoConstraints = false
        
        titlelbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titlelbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        titlelbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titlelbl.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
       
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        borderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        borderView.topAnchor.constraint(equalTo: titlelbl.bottomAnchor, constant: 10).isActive = true
        borderView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0).isActive = true
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 230).isActive = true
    
        
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nameText.topAnchor.constraint(equalTo: readCollectionView.bottomAnchor, constant: 20).isActive = true
        nameText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        phoneText.translatesAutoresizingMaskIntoConstraints = false
        phoneText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        phoneText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        phoneText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 40).isActive = true
        phoneText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        servicebtn.translatesAutoresizingMaskIntoConstraints = false
        servicebtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        servicebtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        servicebtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        servicebtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        readCollectionView.translatesAutoresizingMaskIntoConstraints = false
        readCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        readCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        readCollectionView.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 20).isActive = true
        readCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
}
        
    func readCollection() {

        
     //   collectionViewRect = CGRect(x: 0, y: 10, width: view.frame.width, height: 120)
        flowLayout.itemSize = CGSize(width: 140, height: 140)
        readCollectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: flowLayout)
              
       
        flowLayout.minimumInteritemSpacing = CGFloat(10)
        flowLayout.scrollDirection = .horizontal
        
        readCollectionView.register(STOCollectionViewCell.self, forCellWithReuseIdentifier: "readcell")

       // readCollectionView.backgroundColor = self.backgroundColor
        readCollectionView.showsHorizontalScrollIndicator = false
        readCollectionView.backgroundColor = view.backgroundColor
        readCollectionView.dataSource = self
        readCollectionView.delegate = self
        view.addSubview(readCollectionView)
        

    }
    
    @objc func pushTheButton() {
        print("push The Button")
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
extension STOVC:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return readArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let readcell = readCollectionView.dequeueReusableCell(withReuseIdentifier: "readcell", for: indexPath) as! STOCollectionViewCell
               
               readcell.cellLbl.text = readArray[indexPath.row]
              // readcell.cellImg.image = UIImage(named: readImageArray[indexPath.row])
               return readcell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
