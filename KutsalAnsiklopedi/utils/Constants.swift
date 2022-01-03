//
//  Constants.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import Firebase

let DB_REF = Database.database().reference()
let USERS_REF = DB_REF.child("users")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let TITLE_REF = DB_REF.child("titles")
let COMMENT_REF = DB_REF.child("comments")
