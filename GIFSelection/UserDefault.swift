//
//  UserDefault.swift
//  GIFSelection
//
//  Created by Erum Naz on 24/09/23.
//

import Foundation


let USER_DEFAULTS = UserDefaults.standard
let SAVE_GIFS = "savegifs"


func setImageGif(ImageValue:[String]?) {
    USER_DEFAULTS .set(ImageValue, forKey: SAVE_GIFS)
}

func getImageGif() -> [String]? {
    return USER_DEFAULTS.array(forKey: SAVE_GIFS) as? [String]
}


