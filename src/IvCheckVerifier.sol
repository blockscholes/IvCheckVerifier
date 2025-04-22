// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
contract IvCheckVerifier is EIP712 {
    using ECDSA for bytes32;

    struct Values {
        string sid;
        uint256[] strike;
        uint256[] v;
    }

    struct Data {
        Values[] values;
        int256 timestamp;
    }

    struct SplitSig {
        bytes32 r;
        bytes32 s;
        uint8 v;
    }

    bytes32 private constant _VALUES_TYPEHASH =
        keccak256("Values(string sid,uint256[] strike,uint256[] v)");
    
    bytes32 private constant _DATA_TYPEHASH =
        keccak256("Data(Values[] values,int256 timestamp)Values(string sid,uint256[] strike,uint256[] v)");

    constructor() EIP712("BS_TEST", "1") {}

    /// @notice Hashes the `Values` struct
    function _hashValues(Values memory v) internal pure returns (bytes32) {
        return keccak256(
            abi.encode(
                _VALUES_TYPEHASH,
                keccak256(bytes(v.sid)),         // Hash sid
                keccak256(abi.encodePacked(v.strike)),  // Hash strike array
                keccak256(abi.encodePacked(v.v))       // Hash v array
            )
        );
    }

    /// @notice Hashes the `Data` struct
    function _hashData(Data memory data) internal pure returns (bytes32) {
        uint256 numValues = data.values.length;
        bytes32[] memory hashes = new bytes32[](numValues);

        for (uint256 i = 0; i < numValues; i++) {
            hashes[i] = _hashValues(data.values[i]);
        }

        return keccak256(
            abi.encode(
                _DATA_TYPEHASH,
                keccak256(abi.encodePacked(hashes)), // Array of Values hashes
                data.timestamp
            )
        );
    }

    /// @notice Verifies an EIP-712 signature for `Data`
    function verifyData(
        Data memory data,
        SplitSig memory sig,
        address signer
    ) public view returns (bool) {
        bytes32 structHash = _hashData(data);
        bytes32 digest = _hashTypedDataV4(structHash);
        address recoveredSigner = digest.recover(sig.v, sig.r, sig.s);
        return recoveredSigner == signer;
    }
}