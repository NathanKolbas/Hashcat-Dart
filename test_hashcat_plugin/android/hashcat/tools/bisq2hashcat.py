#!/usr/bin/env python

# This software is Copyright (c) 2017, Dhiru Kholia <dhiru.kholia at gmail.com>
# and it is hereby released under GPL v2 license.
#
# Major parts are borrowed from the "btcrecover" program which is,
# Copyright (C) 2014-2016 Christopher Gurnee and under GPL v2.
#
# See https://github.com/gurnec/btcrecover for details.
#
# References,
#
# https://github.com/gurnec/btcrecover/blob/master/btcrecover/btcrpass.py
#

# Updated script in order to work with Bisq wallet v1.9.5 (2022) 
# Author: 
#   https://github.com/Banaanhangwagen
# License: MIT

import os
import sys
import base64
import binascii

# The protobuf parsing code is borrowed from btcrecover, and was
# initially automatically generated by Google's protoc utility.
# The precompiled file is shipped in protobuf/wallet_pb2.py with John.
from protobuf.wallet_pb2 import *


def process_file(filename):
    bname = os.path.basename(filename)
    try:
        f = open(filename, "rb")
        data = f.read()
    except IOError:
        e = sys.exc_info()[1]
        sys.stderr.write("%s\n" % str(e))
        return

    if "wallet" in bname or b"org.bitcoin.production" in data:
 #       sys.stderr.write("[WARNING] Cracking .wallet files is a very slow process, try cracking the associated .key file instead!\n")
        version = 3  # MultiBit Classic .wallet file
        # def is_wallet_file(wallet_file) from btcrecover
        wallet_file = open(filename, "rb")
        wallet_file.seek(0)
        is_valid_bitcoinj_wallet = False
        if wallet_file.read(1) == b"\x0a":  # protobuf field number 1 of type length-delimited
            network_identifier_len = ord(wallet_file.read(1))
            if 1 <= network_identifier_len < 128:
                wallet_file.seek(2 + network_identifier_len)
                c = wallet_file.read(1)
                if c and c in b"\x12\x1a":   # field number 2 or 3 of type length-delimited
                    is_valid_bitcoinj_wallet = True
        if is_valid_bitcoinj_wallet:
            pb_wallet = Wallet()
            pb_wallet.ParseFromString(data)
            if pb_wallet.encryption_type == Wallet.UNENCRYPTED:
                raise ValueError("bitcoinj wallet is not encrypted")
            if pb_wallet.encryption_type != Wallet.ENCRYPTED_SCRYPT_AES:
                raise NotImplementedError("Unsupported bitcoinj encryption type " + str(pb_wallet.encryption_type))
            if not pb_wallet.HasField("encryption_parameters"):
                raise ValueError("bitcoinj wallet is missing its scrypt encryption parameters")
            for key in pb_wallet.key:
                if key.type in (Key.ENCRYPTED_SCRYPT_AES, Key.DETERMINISTIC_KEY) and key.HasField("encrypted_data"):
                    encrypted_len = len(key.encrypted_data.encrypted_private_key)
                    if encrypted_len == 48:
                        # only need the final 2 encrypted blocks (half of it padding) plus the scrypt parameters
                        part_encrypted_key = key.encrypted_data.encrypted_private_key[-32:]
                        salt = pb_wallet.encryption_parameters.salt
                        n = pb_wallet.encryption_parameters.n
                        r = pb_wallet.encryption_parameters.r
                        p = pb_wallet.encryption_parameters.p
                        encrypted_data = binascii.hexlify(part_encrypted_key).decode("ascii")
                        salt = binascii.hexlify(salt).decode("ascii")
                        sys.stdout.write("%s:$bisq$%d*%s*%s*%s*%s*%s\n" % (bname, version, n, r, p, salt, encrypted_data))
                        return
            return

    pdata = b"".join(data.split())
    if len(pdata) < 64:
        sys.stderr.write("%s: Short length for a bisq wallet file!\n" % bname)
        return

    try:
        pdata = base64.b64decode(pdata[:64])

        if pdata.startswith(b"Salted__"):
            version = 1  # MultiBit Classic
        else:
            version = 2  # MultiBit HD possibly? We need more tests!
    except:
        version = 2  # MultiBit HD possibly?

    if version == 1:
        encrypted_data = pdata[16:48]  # two AES blocks
        salt = pdata[8:16]
        encrypted_data = binascii.hexlify(encrypted_data).decode("ascii")
        salt = binascii.hexlify(salt).decode("ascii")
        sys.stdout.write("%s:$bisq$%d*%s*%s\n" % (bname, version, salt, encrypted_data))
        return
    else:
        version = 2
        # sanity check but not a very good one
        if "wallet" not in bname and "aes" not in bname:
            sys.stderr.write("%s: Make sure that this is a Bisq wallet!\n" % bname)
        # two possibilities
        iv = data[:16]  # v0.5.0+
        block_iv = data[16:32]  # v0.5.0+
        block_noiv = data[:16]  # encrypted using hardcoded iv, < v0.5.0
        iv = binascii.hexlify(iv).decode("ascii")
        block_iv = binascii.hexlify(block_iv).decode("ascii")
        block_noiv = binascii.hexlify(block_noiv).decode("ascii")
        sys.stdout.write("%s:$bisq$%d*%s*%s*%s\n" % (bname, version, iv, block_iv, block_noiv))
        return

    f.close()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.stderr.write("Usage: %s [Bisq wallet file (.wallet)]\n" % sys.argv[0])
 #       sys.stderr.write("\nMultiBit Classic -> for a wallet named 'xyz', we need the xyz-data/key-backup/xyz*.key OR xyz-data/wallet-backup/xyz*.wallet file\n")
        sys.exit(1)

    for j in range(1, len(sys.argv)):
        process_file(sys.argv[j])
