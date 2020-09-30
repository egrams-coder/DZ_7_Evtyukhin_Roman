//
//  main.swift
//  DZ_7_Evtyukhin_Roman
//
//  Created by Роман on 26.09.2020.
//  Copyright © 2020 Nebo. All rights reserved.

// Домашнее задание:

// 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

// 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.


import Foundation


class Image {
    fileprivate var img = [
        "image001": "apple",
        "image002": "banana",
        "image003": "pear"
    ]
    
    func loadImage(atNumberImg numberImg: String) -> String? {
        
        return img[numberImg] //?? "Нет такой картинки"
    }
    
    func quantityImage() -> Int {
        
        guard img.count < 2 else { return 0 }
        let countImage = img.count
        return countImage
    }
}

let image = Image()
print(image.loadImage(atNumberImg: "image004") ?? "Нет такой картинки")
print(image.quantityImage())



enum ServiceError: Error {
    case wheelsQuantityError // недостаточно для установки колес
    case invalidBrand // нет такого брэнда в наличии
}

struct Details {
    var wheels: Int
    let brand: Brand
}

struct Brand {
    let name: String
}

class Service {
    var price = [ "Nokian": Details(wheels: 3, brand: Brand(name: "Nokian")),
                  "Dunlop": Details(wheels: 4, brand: Brand(name: "Dunlop")),
                  "Hankook": Details(wheels: 2, brand: Brand(name: "Hankook"))]
    
    func installation(named name: String) throws -> Brand {
        
        guard let details = price[name] else { throw ServiceError.invalidBrand }
        guard details.wheels > 3 else { throw ServiceError.wheelsQuantityError }
        var balance = details
        balance.wheels -= 1
        price[name] = balance
        return balance.brand
    }
}

let service = Service()

do {
    let sellInstallation1 = try service.installation(named: "Dunlop")
    let brand = sellInstallation1
    print("Установлено: \(brand.name)")
} catch let error {
    print("Произошла ошибка \(error.localizedDescription)")
}

do {
    let sellInstallation2 = try service.installation(named: "Mishlien")
    let brand = sellInstallation2
    print("Установлено: \(brand.name)")
} catch let error {
    print("Произошла ошибка \(error.localizedDescription)")
}

