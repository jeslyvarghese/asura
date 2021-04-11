// Created for Asura Mach-O Parser in 2021 April 5
// Using Swift 5.3
// Running on macOS 11.2.1
import Foundation

let testFilePath = "/Volumes/Addon/Library/DerivedData/Asura-bxbtfcsstvezvmhgqlvqkgggvknj/Build/Products/Debug/Asura"

let data = try! Data(contentsOf: URL(fileURLWithPath: testFilePath))
let byteArray = data.bytes
let header = make(MachOHeaderFromBytes: byteArray)
header.prettyPrint()
