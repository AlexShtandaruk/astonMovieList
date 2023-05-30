//
//  ObjectViewController.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit
import StoreKit
import MapKit

class ObjectViewController: UIViewController {
    
    //MARK: - UI
    
    private let objectTableView = UITableView(frame: .zero, style: .plain)
    private let backButton = CButton()
    
    //MARK: - SET UI
    
    private lazy var subView = [
        objectTableView,
        backButton
    ]
    
    //MARK: - PROPERTIES
    
    var presenter: ObjectPresenterProtocol!
    private var data: [Object]?
    private let header = ObjectTableViewHeader()
    
    //MARK: - CONSTRAINT
    
    private lazy var factor = view.bounds.width / 5
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - FETCH DATA
    
    func getData() {
        presenter.getData()
    }
    
    //MARK: - ACTION
    
    @objc func tappedBack() {
        presenter.tapBack()
    }
}

//MARK: - extension - ObjectViewProtocol

extension ObjectViewController: ObjectViewProtocol {
    
    func setData(data: [Object]?) {
        self.data = data
    }
}

// MARK: - extension - UITableViewDelegate

extension ObjectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        presenter.tapData(
            lon: (data?[indexPath.row].lon ?? Double()),
            lat: (data?[indexPath.row].lat ?? Double()))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return factor * 1.3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header.setUI()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return factor
    }
}

// MARK: - extension - UITableViewDataSource

extension ObjectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ObjectTableViewCell.identifier) as! ObjectTableViewCell
        let data = data?[indexPath.row]
        cell.setUI(
            title: data?.name,
            description: data?.description,
            imageLink: data?.image
        )
        return cell
    }
}

// MARK: - extension - ViewControllerProtocol

extension ObjectViewController: ViewControllerProtocol {
    
    func setUI()  {
        
        view.backgroundColor = CColor.custBlack
        
        objectTableView.translatesAutoresizingMaskIntoConstraints = false
        objectTableView.dataSource = self
        objectTableView.delegate = self
        objectTableView.register(ObjectTableViewCell.self, forCellReuseIdentifier: ObjectTableViewCell.identifier)
        objectTableView.backgroundColor = CColor.custBlack
        objectTableView.separatorColor = CColor.custLightGray
        objectTableView.separatorInset = .zero
        objectTableView.sectionIndexBackgroundColor = CColor.custLightGray
        objectTableView.tintColor = .black
        
        backButton.createTextButton(
            title: Constant.Object.backButton.localized(),
            fontType: FontType.morserattRegular.value,
            fontSize: factor/6,
            backgroundColor: CColor.custDarkGray,
            titleColorNormal: CColor.custBlack,
            titleColorHighlighted: CColor.custDarkGray,
            target: self,
            action: #selector(tappedBack)
        )
        backButton.layer.cornerRadius = factor/6
        
        setView(subView: subView)
        setConstraint()
    }
    
    func setView(subView: [UIView]) {
        for i in subView { view.addSubview(i) }
    }
    
    func setConstraint()  {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: factor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: factor/4),
            backButton.heightAnchor.constraint(equalToConstant: factor/2),
            backButton.widthAnchor.constraint(equalToConstant: factor*1.5),
            
            objectTableView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            objectTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            objectTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            objectTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
