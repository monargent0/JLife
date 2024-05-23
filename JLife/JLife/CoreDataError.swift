//
//  CoreDataError.swift
//  JLife
//
//  Created by OoO on 5/1/24.
//

enum CoreDataError: Error {
  case failToLoadPersistentStores
  case failToSaveContext
  case failToFetchData
}
