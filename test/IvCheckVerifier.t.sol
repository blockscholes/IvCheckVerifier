// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/IvCheckVerifier.sol";
import {console} from "forge-std/console.sol";

contract IvCheckVerifierTest is Test {
    IvCheckVerifier verifier;
    IvCheckVerifier.Values[] public values;
    uint256[] public strikes;
    uint256[] public v;

    function setUp() public {
        verifier = new IvCheckVerifier();
    }

    function testVerifyData() public {
        uint88[26] memory wsApiStikes = [
            7400000000000000000000000,
            7600000000000000000000000,
            7800000000000000000000000,
            7900000000000000000000000,
            8000000000000000000000000,
            8100000000000000000000000,
            8150000000000000000000000,
            8200000000000000000000000,
            8250000000000000000000000,
            8300000000000000000000000,
            8350000000000000000000000,
            8400000000000000000000000,
            8450000000000000000000000,
            8500000000000000000000000,
            8550000000000000000000000,
            8600000000000000000000000,
            8650000000000000000000000,
            8700000000000000000000000,
            8800000000000000000000000,
            8900000000000000000000000,
            9000000000000000000000000,
            9200000000000000000000000,
            9400000000000000000000000,
            9500000000000000000000000,
            9600000000000000000000000,
            9800000000000000000000000
        ];
        uint72[26] memory wsApiV = [
            84875217764034600000,
            75564380536922150000,
            65575580806688520000,
            60416556457741340000,
            55459776433694590000,
            51581569519956580000,
            50592581728967020000,
            50521677269098720000,
            51348794666036260000,
            52853434444457240000,
            54774979305542490000,
            56916224598334790000,
            59154075619952250000,
            61417697678501750000,
            63667749673453420000,
            65882936586399340000,
            68052199142290050000,
            70170303969709680000,
            74247340243366170000,
            78117053913580460000,
            81793481851686570000,
            88632335855836840000,
            94886075959489490000,
            97825275841782470000,
            100653316919806480000,
            106010450335301320000
        ];

        for (uint256 i = 0; i < wsApiStikes.length; i++) {
            strikes.push(wsApiStikes[i]);
            v.push(wsApiV[i]);
        }
        values.push(
            IvCheckVerifier.Values({sid: "0x1", strike: strikes, v: v})
        );

        IvCheckVerifier.Data memory data = IvCheckVerifier.Data({
            values: values,
            timestamp: int256(1742305883000)
        });

        IvCheckVerifier.SplitSig memory sig = IvCheckVerifier.SplitSig({
            r: 0x8f85c6744bef982d94cb02e71308a749bbf90fdb25a34e457c12999590f9e3bd,
            s: 0x263c187eb085e7975e6a1c9ed0126460f18bcc3036d22e1b7ccd78ca83e461e4,
            v: 27
        });

        address signer = address(0x47ebFBAda4d85Dac6b9018C0CE75774556A8243f);
        bool isValid = verifier.verifyData(data, sig, signer);

        assertTrue(isValid, "Signature should be invalid");
    }
}
