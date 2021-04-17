//
//  ParseLoadCommands.swift
//  Asura
//
//  Created by Jesly Varghese on 16/04/21.
//

import Foundation
enum LC_OFFSET: Int {
    case _32 = 28
    case _64 = 32
}

struct LoadCommand {
    let command: UInt32
    let commandSize: UInt32
    let segmentBytes: [UInt8]
}

extension LoadCommand: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        Command: \(command.hexString) Size: \(commandSize.hexString)(\(commandSize))
        """
    }
    
    
}

func make(loadCommandsFromBytes bytes: [UInt8],
          numberOfCommands ncmds: Int,
          commandSize cmdSize: Int,
          offset: LC_OFFSET,
          isReveresed: Bool = true) -> [LoadCommand] {
    // each field inside will be 4 units, 4*8 = 32 bytes of command & 32 bytes of command size
    var commandList: [LoadCommand] = []
    var byteOffset = 0
    repeat {
        let segOffset = offset.rawValue + byteOffset
        let commandStrctBytes = bytes.slice(segOffset, segOffset + 7)
        let cmd: UInt32 = commandStrctBytes.slice(0, 3).flatten(isReversed: isReveresed)
        let cmdSize: UInt32 = commandStrctBytes.slice(4, 7).flatten(isReversed: isReveresed)
        let cmdBytes = bytes.slice(segOffset + 7, segOffset + 7 + Int(cmdSize) - 1)
        commandList.append(LoadCommand(command: cmd, commandSize: cmdSize, segmentBytes: cmdBytes))
        byteOffset += Int(cmdSize)
    } while (byteOffset < cmdSize)
    return commandList
}
