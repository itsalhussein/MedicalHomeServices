import Foundation

protocol ServiceProtocol {
    // Async-Await
    func fetch<ModelType: Codable>(route: APIRouter) async throws -> ModelType?
//    func upload<ModelType: Codable>(route: APIRouter) async throws -> ModelType?
}
