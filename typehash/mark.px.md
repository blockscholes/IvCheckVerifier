## Solidity structs
```solidity
struct Values {
    string sid;
    int256[] v;
    int256[] moneyness;
}

struct Data {
    Values[] values;
    int256 timestamp;
}


```

## Type Hashes
```solidity
bytes32 constant TYPE_HASH_DOMAIN = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
bytes32 constant VALUES_TYPEHASH = keccak256("Values(string sid,int256[] v,int256[] moneyness)");
bytes32 constant DATA_TYPEHASH = keccak256("Data(Values[] values,int256 timestamp)Values(string sid,int256[] v,int256[] moneyness)");
```