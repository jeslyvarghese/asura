// Created for Swift Mach-O in 2021 April 5
// Using Swift 5.3
// Running on macOS 11.2.1

@inlineable private let CPU_ARCH_ABI64 = 0x01000000
enum CPUType: Int32 {
    any = -1
    x86 = 7
    i386 = 7
    x86_64 = 7 | CPU_ARCH_ABI64
}

enum CPUSubType: Int32 {
    any = -1
    multiple = -1
    littleEndian = 0
    bigEndian = 1
    x86All = 3
    x8664All = 3
    x86Arch1 = 4
    x86H = 8
    armAll = 0 
}

struct Header {
    let magic: Int32
    let cpuType: Int32
    let cpuSubType: Int32
    let fileType: Int32
    let numberOfCommands: Int32
    let flags: Int32
    let reserved: Int32?
}

func makeHeader(from data: Data) {
    
}
