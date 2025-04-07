## Solidity structs
```solidity
struct Values {
    string sid;
    uint256 v;
}

struct Data {
    Values[] values;
    int256 timestamp;
}
```

## Type Hashes
```solidity
bytes32 constant TYPE_HASH_DOMAIN = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
bytes32 constant VALUES_TYPEHASH = bytes32 constant VALUES_TYPEHASH = keccak256("Values(string sid,uint256 v)");
bytes32 constant DATA_TYPEHASH = keccak256("Data(Values[] values,int256 timestamp)Values(string sid,uint256 v)");
```