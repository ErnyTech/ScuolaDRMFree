/* 
Copyright (C) Erny

    This file is part of ScuolaDRMFree.
    All rights reserved. No warranty, explicit or implicit, provided.
*/

module key;

import util : ScuolaDB;
import std.digest.md : digestLength, MD5;

ulong[] computePdfKey(string book, ScuolaDB scuoladb) {
    import std.bitmanip : nativeToBigEndian, bigEndianToNative;
    import std.digest.md : md5Of;
    import std.digest : toHexString;
    import util : parseScuolaDb;
    import std.stdio : writeln;

    auto usernameHash = md5Of(scuoladb.username);
    auto deviceIds = getDeviceId();
    auto activationKey = getActivationKey(book, scuoladb);
    ulong[] keys;
    
    writeln("Book: ", book);
    writeln("Username: ", scuoladb.username);
    writeln("Username Hash: ", usernameHash.toHexString);
    writeln("Activation key: ", activationKey.toHexString);
    
    foreach (nkey, deviceId; deviceIds) {
        ubyte[digestLength!MD5] key1;
        ubyte[8] keyBytes;
        
        foreach (i, ref elem; key1) {
            elem = deviceId[i] ^ usernameHash[i];
        }
        
        foreach(i, ref elem; keyBytes) {
            elem = activationKey[i + 8] ^ key1[i + 8];
        }
        
        auto key = bigEndianToNative!ulong(keyBytes);
        keys ~= key;
        
        writeln("[", nkey, "] Device Id: ", deviceId.toHexString);
        writeln("[", nkey, "] Key: ", key);
    }
    
    writeln();
    return keys;
}

ubyte[digestLength!MD5][] getDeviceId() {
    import std.digest.md : md5Of;
    
    ubyte[digestLength!MD5][] deviceIds;
    
    version(Posix) {
        import util : getMacAddress;
        auto macs = getMacAddress();
        
        foreach (mac; macs) {
          deviceIds ~= md5Of(mac);
        }
        
        return deviceIds;
    } else {
        static assert(0, "This operating system is not supported");
    }
}

ubyte[] getActivationKey(string book, ScuolaDB scuoladb) {
    import std.algorithm.iteration : map;
    import std.range : chunks;
    import std.conv : to;
    import std.array : array;

    auto activationKey = scuoladb.activactionKeys[book];
    auto activationKeyHash = activationKey.chunks(2)
                        .map!(digits => digits.to!ubyte(16))
                        .array;
    
    assert(activationKeyHash.length == digestLength!MD5, "The book activation key is not valid");
    return activationKeyHash;
}
