//
//  ListOfExercisesViewController.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import UIKit
import SwiftUI
import Combine

class ListOfExercisesViewController: BaseViewController {

    @IBOutlet weak private var exercisesTableView: UITableView!

    private let refreshControl = UIRefreshControl()

    private var storage: Set<AnyCancellable> = []
    private var exercises: [ExerciseCellInfo] = []

    var viewModel: ListOfExercisesViewModelProtocol!

    // MARK: - life cycle methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindExercises()
        bindLoadingView()
        bindError()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isLargeTitleEnabled = true
        viewModel.loadExercises()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isLargeTitleEnabled = false
    }

    // MARK: - setup ui methods -
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        title = "listOfExercises_title".localized
    }

    private func setupTableView() {
        exercisesTableView.registerCellType(ExerciseTableViewCell.self)
        exercisesTableView.separatorStyle = .none
        exercisesTableView.dataSource = self
        exercisesTableView.delegate = self
        exercisesTableView.refreshControl = refreshControl
        exercisesTableView.contentInset = .tableView
        refreshControl.addTarget(self, action: #selector(handleRefreshingExercises), for: .valueChanged)
    }

    @objc private func handleRefreshingExercises() {
        viewModel.reloadExercises()
    }
// MARK: - binding methods -
    private func bindExercises() {
        viewModel.exercisesPublisher
            .dropFirst()
            .sink { [weak self] exercises in
                guard let self else { return }
                self.exercises = exercises.map { ExerciseCellInfo(name: $0.name, image: $0.image)}
                self.refreshControl.endRefreshing()
                self.exercisesTableView.reloadData()
        }.store(in: &storage)
    }

    private func bindLoadingView() {
        let loadingView = UIHostingController(rootView: LoadingView(isLoading: .constant(true)))
        loadingView.modalPresentationStyle = .overCurrentContext
        loadingView.view.backgroundColor = .clear
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                guard let self  else { return }
                if isLoading {
                    self.present(loadingView, animated: false)
                } else {
                    loadingView.dismiss(animated: false)
                }
            }
            .store(in: &storage)
    }

    private func bindError() {
        viewModel.$showError
            .sink { [weak self] _ in
                guard let self else { return }
                guard let error = self.viewModel.appError else { return }
                self.showErrorMessage(title: error.title, error: error.message)
                self.refreshControl.endRefreshing()
            }
            .store(in: &storage)
    }
}

// MARK: - Conforming to UITableViewDataSource
extension ListOfExercisesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ExerciseTableViewCell = tableView.dequeueCell(indexPath: indexPath) else {
            fatalError()
        }
        let exercise = exercises[indexPath.row]
        cell.bind(with: exercise)
        return cell
    }
}

// MARK: - Conforming to UITableViewDelegate
extension ListOfExercisesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let exerciseId = viewModel.getExcerciseId(at: indexPath.row)
        dLog(exerciseId)
    }
}
