extension OrderedSet : CustomStringConvertible, CustomDebugStringConvertible {
    
    /// A textual representation of `self`.
    public var description: String {
        return array.description
    }
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String {
        return array.debugDescription
    }
    
}
