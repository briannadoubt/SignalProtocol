//
//  SessionPreKeyBundle.swift
//  SignalProtocolSwift
//
//  Created by User on 25.10.17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/**
 Pre key bundles are used to establish new sessions.
 */
public struct SessionPreKeyBundle {

    /// The registration id of the remote party
    var registrationId: UInt32

    /// The id of the pre key that was used
    var preKeyId: UInt32

    /// The pre key, if a pre key was used
    var preKeyPublic: PublicKey?

    /// The id of the signed pre key
    var signedPreKeyId: UInt32

    /// The signed pre key that was used
    var signedPreKeyPublic: PublicKey

    /// The signature of the signed pre key
    var signedPreKeySignature: Data

    /// The identity key of the remote party
    var identityKey: PublicKey

    /**
     Create a pre key bundle from its components.
     - parameter registrationId: The registration id of the remote party
     - parameter deviceId: The device id of the remote party
     - parameter preKeyId: The id of the pre key that was used
     - parameter preKeyPublic: The pre key, if a pre key was used
     - parameter signedPreKeyId: The id of the signed pre key
     - parameter signedPreKeyPublic: The signed pre key that was used
     - parameter signedPreKeySignature: The signature of the signed pre key
     - parameter identityKey: The identity key of the remote party
    */
    public init(
        registrationId: UInt32,
        preKeyId: UInt32,
        preKeyPublic: PublicKey?,
        signedPreKeyId: UInt32,
        signedPreKeyPublic: PublicKey,
        signedPreKeySignature: Data,
        identityKey: PublicKey) {

        self.registrationId = registrationId
        self.preKeyId = preKeyId
        self.preKeyPublic = preKeyPublic
        self.signedPreKeyId = signedPreKeyId
        self.signedPreKeyPublic = signedPreKeyPublic
        self.signedPreKeySignature = signedPreKeySignature
        self.identityKey = identityKey
    }

    /**
     Create a pre key bundle from its components.
     - parameter registrationId: The registration id of the remote party
     - parameter deviceId: The device id of the remote party
     - parameter preKey: The pre key to use
     - parameter signedPreKey: The signed pre key
     - parameter identityKey: The identity key of the remote party
     */
    init(registrationId: UInt32,
                preKey: SessionPublicPreKey,
                signedPreKey: SessionPublicSignedPreKey,
                identityKey: PublicKey) {

        self.registrationId = registrationId
        self.preKeyId = preKey.id
        self.preKeyPublic = preKey.key
        self.signedPreKeyId = signedPreKey.id
        self.signedPreKeyPublic = signedPreKey.key
        self.signedPreKeySignature = signedPreKey.signature
        self.identityKey = identityKey

    }

    /**
     Create a pre key bundle from its components.
     - parameter registrationId: The registration id of the remote party
     - parameter deviceId: The device id of the remote party
     - parameter preKey: The pre key data to use
     - parameter signedPreKey: The signed pre key data
     - parameter identityKey: The identity key data of the remote party
     */
    public init(registrationId: UInt32,
                deviceId: UInt32,
                preKey: Data,
                signedPreKey: Data,
                identityKey: Data) throws {

        self.init(registrationId: registrationId,
                  preKey: try SessionPublicPreKey(from: preKey),
                  signedPreKey: try SessionPublicSignedPreKey(from: signedPreKey),
                  identityKey: try PublicKey(from: identityKey))
    }

}
