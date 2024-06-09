//
//  Service.swift
//  Tarat Store
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation

protocol ServiceProtocol {
    // Async-Await
    func fetch<ModelType: Codable>(route: APIRouter) async throws -> ModelType?
//    func upload<ModelType: Codable>(route: APIRouter) async throws -> ModelType?
}
