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
$ forge inspect ./src/Greeter.sol:Greeter storage --pretty
```

**Debug to see the stack&memory&storage**

```sh
$ forge test --debug testSetGm
```

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
