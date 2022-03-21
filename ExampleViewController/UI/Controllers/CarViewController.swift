//
//  ViewController.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import UIKit

class CarViewController: UIViewController {

    // MARK: Properties
    var viewModel: CarViewModel?
    var coordinator: CarViewCoordinator?

    // MARK: IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!


    @IBOutlet weak var messageLabel: AlkemyLabel!
    // MARK: Outlets

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.service.list(completion: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cars):
                let carros = cars
                print(cars)
            }
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }


    }

    // MARK: Button Actions
    @IBAction func onTapGoToDetail(_ sender: Any) {
        guard let viewModel = viewModel else {
            return
        }
        coordinator?.goToDetail(car: viewModel.carExample)
    }

    @IBAction func onTapAdd(_ sender: Any) {
        // viewModel.add

        let name = nameTextField.text ?? ""
        let descr = descriptionLabel.text ?? ""

        let titulo = "Success"
        let mensaje = "El Car se registró"
        let alert = UIAlertController(title: titulo, message:
                                        mensaje, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(
            title: "No",
            style: .cancel,
            handler: { _ in
                print("\"No\" oprimido")
            } ))
        alert.addAction(UIAlertAction(
            title: "Si!",
            style: .default,
            handler: { _ in
                print("\"Si\" oprimido")
            }))
        alert.addAction(UIAlertAction(
            title: "Si2!",
            style: .default,
            handler: { _ in
                print("\"Si\" oprimido")
            }))

        self.present(alert, animated: true)

        viewModel?.addNewCar(name: name, descr: descr)

    }



}

