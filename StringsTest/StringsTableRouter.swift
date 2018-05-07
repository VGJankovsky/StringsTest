//
//  StringsTableRouter.swift
//  StringsTest
//
//  Created by Vadym Yankovskiy on 5/6/18.
//  Copyright © 2018 Vadym Yankovskiy. All rights reserved.
//

import Foundation

protocol TableRouterDelegate: class {
    func routerUpdateData() -> ()
    func routerRemovedData(at row: Int) -> ()
    func routerRecognized(word: String) -> ()
}

class StringsTableRouter {
    private var models : [String]
    weak var delegate: TableRouterDelegate?
    var modelsCount: Int {
        return models.count
    }
    
    init(withModels models: [String]){
        self.models = models
        NotificationCenter.default.addObserver(self, selector: #selector(self.onRecognizedWord(notification:)), name: .recognizedWord, object: nil)
    }
    
    func model(for row: Int) -> StringPresenter?{
        guard row < models.count else { return nil }
        return StringPresenter(text: models[row])
    }
    
    func deleteModel(at row: Int){
        guard row < models.count else { return }
        models.remove(at: row)
        self.delegate?.routerRemovedData(at: row)
    }
    
    @objc private func onRecognizedWord(notification: Notification){
        guard let word = notification.userInfo?[RecognizedWordKey] else { return }
        if word is String{
            let wordAsString = word as! String
            var set = Set<Character>()
            let reduced = String(wordAsString.filter{ set.insert($0).inserted } )
            self.delegate?.routerRecognized(word: reduced)
        }
    }
}
