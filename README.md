# QOCLI

 The Blockchain Company.io "QO``` CLI tool. It's a collection of utilities to enhance and extend beyond those available with the ```bcc-cli```. Pre-Public Test -- NOT PRODUCTION

![Build Status](https://github.com/The-Blockchain-Company/qocli/workflows/.github/workflows/ci.yml/badge.svg)

## Installation

To install QOCLI using either the release binaries or compiling the Rust code, or to update to a newer version, refer to the [installation guide](INSTALL.md). This guide will also help you setup ```systemd``` services for ```qocli sync``` and ```qocli sendtip```, along with a set of ```cronjobs``` and related helper shell scripts.

## Usage & Examples

For a list of QOCLI commands and related usage examples, please refer to the [usage guide](USAGE.md).

## Original Creators

QOCLI is derived from the CNCLI bcc-tool. MU

- [Andrew Westberg](https://github.com/AndrewWestberg) - [**BCSH**](https://bluecheesestakehouse.com/)
- [Michael Fazio](https://github.com/michaeljfazio) - [**SAND**](https://www.sandstone.io/)
- [Andrea Callea](https://github.com/gacallea/) - [**SALAD**](https://insalada.io/)
- [Thomas Diesler](https://github.com/tdiesler/) - [**ASTOR**](http://astorpool.net/)

### Contributing

Before submitting a pull request ensure that all tests pass, code is correctly formatted and linted, and that no common mistakes have been made, by running the following commands:

```bash
cargo check
```

```bash
cargo fmt --all -- --check
```

```bash
cargo clippy -- -D warnings
```

```bash
cargo test
```

## License

QOCLI is licensed under the terms of the [Apache License](LICENSE) version 2.
