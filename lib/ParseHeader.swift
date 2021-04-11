// Created for Asura Mach-O Parser in 2021 April 5
// Using Swift 5.3
// Running on macOS 11.2.1
enum Magic: UInt32 {
    case magic32 =  0xfeedface
    case cigam32 = 0xcefaedfe
    case magic64 = 0xfeedfacf
    case cigam64 = 0xcffaedfe
    case cafebabe = 0xcafebabe
    case cafed00d = 0xcafed00d
    
    var isReserved: Bool {
        switch self {
        case .cigam64,.cigam32:
            return true
        default:
            return false
        }
    }
}

protocol MachOHeader {
    var magic: Magic { get }
    var cpuType: Int32 { get }
    var cpuSubType: Int32 { get }
    var fileType: Int32 { get }
    var numberOfCommands: Int32 { get }
    var sizeOfLoadCommands: Int32 { get }
    var flags: Int32 { get }
}

struct Header32: MachOHeader {
    let magic: Magic
    let cpuType: Int32
    let cpuSubType: Int32
    let fileType: Int32
    let numberOfCommands: Int32
    var sizeOfLoadCommands: Int32
    let flags: Int32
}

struct Header64: MachOHeader {
    let magic: Magic
    let cpuType: Int32
    let cpuSubType: Int32
    let fileType: Int32
    let numberOfCommands: Int32
    var sizeOfLoadCommands: Int32
    let flags: Int32
    let reserved: Int32
}

extension MachOHeader {
    func prettyPrint() {
        print(
        """
        Magic                   : \(magic.rawValue.hexString)
        CPU Type                : \(cpuType.hexString)
        CPU Sub-Type            : \(cpuSubType.hexString)
        File Type               : \(fileType.hexString)
        Number Of Load Commands : \(numberOfCommands.hexString) = \(numberOfCommands)
        Size Of Load Commands   : \(sizeOfLoadCommands.hexString) = \(sizeOfLoadCommands)
        Flags                   : \(flags.hexString)
        """
        )
    }
}

func make(MachOHeaderFromBytes array: [UInt8]) -> MachOHeader {
    guard let magic: Magic = Magic(rawValue: array.slice(0, 3).flatten()) else {
        fatalError("Can't access the file type")
    }
    let isReversed = magic.isReserved
    switch magic {
    case .cigam32, .magic32:
        return Header32(magic: magic,
                        cpuType: array.slice(4, 7).flatten(isReversed: isReversed),
                        cpuSubType: array.slice(8, 11).flatten(isReversed: isReversed),
                        fileType: array.slice(12, 15).flatten(isReversed: isReversed),
                        numberOfCommands: array.slice(16, 19).flatten(isReversed: isReversed),
                        sizeOfLoadCommands: array.slice(20, 23).flatten(isReversed: isReversed),
                        flags: array.slice(24, 27).flatten(isReversed: isReversed))
    case .cigam64, .magic64:
        return Header64(magic: magic,
                        cpuType: array.slice(4, 7).flatten(isReversed: isReversed),
                        cpuSubType: array.slice(8, 11).flatten(isReversed: isReversed),
                        fileType: array.slice(12, 15).flatten(isReversed: isReversed),
                        numberOfCommands: array.slice(16, 19).flatten(isReversed: isReversed),
                        sizeOfLoadCommands: array.slice(20, 23).flatten(isReversed: isReversed),
                        flags: array.slice(24, 27).flatten(isReversed: isReversed),
                        reserved: array.slice(28, 31).flatten(isReversed: isReversed))
    case .cafebabe, .cafed00d:
        fatalError("Currently parsing of UNIX universal binaries/JAVA byte code are not supported")
    }
}
