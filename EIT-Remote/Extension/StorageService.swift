//
//  StorageService.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//


import Foundation
import FirebaseStorage

class StorageService {
    static let shared = StorageService()
    
    private init () {}
    
    private var storage = Storage.storage().reference()
    
    private var patientRef: StorageReference {
        storage.child("patients")
    }
    
    func upload(id: String, image: Data, completion: @escaping (Result<String, Error>) -> ()) {
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        patientRef.child(id).putData(image, metadata: metadata) { metadata, error in
            
            guard let metadata = metadata else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("Размер полученного изображения: \(metadata.size)"))
        }
    }
    
    func downloadImages(id: String, completion: @escaping (Result<Data, Error>) -> ()) {
        
        patientRef.child(id).getData(maxSize: 3 * 1024 * 1024) { data, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            completion(.success(data))
            
        }
        
    }
    
}
