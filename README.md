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

**Deployment & Verification**

Inside the [`utils/`](./utils/) directory are a few preconfigured scripts that can be used to deploy and verify contracts.

Scripts take inputs from the cli, using silent mode to hide any sensitive information.

_NOTE: These scripts are required to be _executable_ meaning they must be made executable by running `chmod +x ./utils/*`._

_NOTE: these scripts will prompt you for the contract name and deployed addresses (when verifying). Also, they use the `-i` flag on `forge` to ask for your private key for deployment. This uses silent mode which keeps your private key from being printed to the console (and visible in logs)._


### I'm new, how do I get started?

We created a guide to get you started with: [GETTING_STARTED.md](./GETTING_STARTED.md).


### Blueprint

```txt
lib
├─ forge-std — https://github.com/foundry-rs/forge-std
├─ solmate — https://github.com/transmissions11/solmate
scripts
├─ Deploy.s.sol — Example Contract Deployment Script
src
├─ Greeter — Example Contract
test
└─ Greeter.t — Example Contract Tests
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
