
enum ManagerResponse<Entity, SemanticEvent> {
    case success(entity: Entity)
    case failure(code: Int, description: String)
    case semantic(event: SemanticEvent)
}
