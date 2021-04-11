// Created for Asura Mach-O Parser in 2021 April 10
// Using Swift 5.3
// Running on macOS 11.2.1
import Foundation
extension Array where Element: FixedWidthInteger {
    func slice(_ from: Int, _ to: Int) -> Array {
        return [Element](self[from...to])
    }
    
    @usableFromInline func flatten<S>(isReversed: Bool = false) -> S where S: FixedWidthInteger {
        guard !isReversed else {
            return self.reversed().reduce(S(0)) { ($0 << (MemoryLayout<Element>.size * 8)) | S($1) }
        }
        return self.reduce(S(0)) { ($0 << (MemoryLayout<Element>.size * 8)) | S($1) }
    }
}
