## Solidity structs
```solidity
struct Values {
    string sid;
    int256[] moneyness;
    int256[] v;
}

struct Data {
    Values[] values;
    int256 timestamp;
}
```

## Type Hashes
```solidity
bytes32 constant TYPE_HASH_DOMAIN = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
bytes32 constant TYPE_HASH_VALUES = keccak256("Values(string sid,int256[] moneyness,int256[] v)");
bytes32 constant TYPE_HASH_DATA = keccak256("Data(Values[] values,int256 timestamp)Values(string sid,int256[] moneyness,int256[] v)");
```