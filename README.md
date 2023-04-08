# Sloads Demo • [![tests](https://github.com/0xevm/sloads_demo/actions/workflows/ci.yml/badge.svg?label=tests)](https://github.com/0xevm/sloads_demo/actions/workflows/ci.yml) ![license](https://img.shields.io/github/license/0xevm/sloads_demo?label=license) ![solidity](https://img.shields.io/badge/solidity-^0.8.19-green)

A demo for test smart contract's dynamic data's storage slot's, such as array, map, using [Foundry](https://getfoundry.sh/).

### Usage

**Install Forge**

see https://getfoundry.sh/

**Building & Testing**

```sh
$ forge build

$ forge test -vvv
```

**Get the storage slot**
```sh
$ forge inspect ./src/RecordMapping.sol:RecordMapping storage --pretty
```

**Debug to see the stack&memory&storage**

```sh
$ forge test --debug testRecordMapping
```

**Test with new Forge**
```sh
$ cd foundry/

$ cargo build --release -p foundry-cli --bin forge   



$ cd sloads_demo/

# !! update the PATH to your foundry build release path
$ export PATH="/Users/flyq/workspace/github/0xevm/foundry/target/release:$PATH"

$ forge clean

$ forge install 0xevm/forge-std-new

$ forge test -vvv

```

### New cheatcode

```solidity
    /// Let foundry-evm start recording Storage slot related data.
    function startMappingRecording() external;

    /// Get the length of a map in a smart contract.
    /// @param `target`, the address of smart contract.
    /// @param `slot`, the slot of a map or a array.
    function getMappingLength(address target, bytes32 slot) external returns (uint);
    /// Get the storage slot index of one item of a map
    function getMappingSlotAt(address target, bytes32 slot, uint256 idx) external returns (bytes32);
    /// 
    function getMappingKeyOf(address target, bytes32 slot) external returns (uint);
    /// Get the slot below which map in a contract
    function getMappingParentOf(address target, bytes32 slot) external returns (bytes32);
```

### Todo
update the interface name, as they also can used in array.

### Notable Mentions

- [femplate](https://github.com/refcell/femplate)
- [foundry](https://github.com/foundry-rs/foundry)
- [solmate](https://github.com/Rari-Capital/solmate)
- [forge-std](https://github.com/brockelmore/forge-std)
- [forge-template](https://github.com/foundry-rs/forge-template)
- [foundry-toolchain](https://github.com/foundry-rs/foundry-toolchain)
- [ETH Beijing](https://github.com/WTFAcademy/ETHBeijing)


### Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._

See [LICENSE](./LICENSE) for more details.
