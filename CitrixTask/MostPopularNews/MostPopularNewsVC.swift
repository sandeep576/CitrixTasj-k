//
//  MostPopularNewsVC.swift
//  CitrixTask
//
//  Created by Sai Sandeep on 02/07/22.
//

import UIKit

class MostPopularNewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var datasource = [Results]()

    var viewModel: MostPopularNewsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MostPopularNewsViewModel(service: NetworkManager())
        loadData()
    }

    func loadData() {
        viewModel.getMostPopularNews { [weak self] result  in
            switch result {
            case .success(let results):
                self?.datasource = results
                self?.tableView.reloadData()
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }


}

extension MostPopularNewsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
        vc.urlString = datasource[indexPath.row].url
        self.present(vc, animated: true, completion: nil)
    }

}

extension MostPopularNewsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: MostPopularNewsCell.cellIdentifier, for: indexPath) as? MostPopularNewsCell else { return UITableViewCell() }
        cell.setupData(item: datasource[indexPath.row])
        return cell
    }
}

