// Created for Asura Mach-O Parser in 2021 April 10
// Using Swift 5.3
// Running on macOS 11.2.1
import Foundation

extension FixedWidthInteger {
    var hexString: String {
        let value = String(self, radix: 16, uppercase: true)
        let padLength = self.bitWidth / 4
        return   "0x" + (value.count < padLength ? String(repeating: "0", count: padLength - value.count) + value : value)
    }
    
    @inlinable func explode<S>() -> [S] where S: FixedWidthInteger {
        return (0...self.bitWidth/S.bitWidth-1).map { S((self ^  (1 << ($0 * S.bitWidth) )) >> ($0 * S.bitWidth) ) }
    }
}
