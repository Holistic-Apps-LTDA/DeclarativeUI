extension OrderedSet : CustomStringConvertible, CustomDebugStringConvertible {
    
    /// A textual representation of `self`.
    var description: String {
        return array.description
    }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String {
        return array.debugDescription
    }
    
}
