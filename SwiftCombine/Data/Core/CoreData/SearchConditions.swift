import Foundation

enum SearchCondition {
    case predicates(_ format: [NSPredicate])
    case sort(_ descripter: NSSortDescriptor)
}
