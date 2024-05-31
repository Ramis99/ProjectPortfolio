//
//  ImageLoader.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 10/04/24.
//

import UIKit

class ImageLoader {
    
    static func loadImage(from url: URL, into imageView: UIImageView) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al descargar la imagen: \(error)")
                return
            }
            
            guard let imageData = data else {
                print("No se pudieron obtener los datos de la imagen")
                return
            }
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                print("No se pudo crear la imagen desde los datos")
            }
        }
        task.resume()
    }
}
