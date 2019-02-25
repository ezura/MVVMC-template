# generator MVVMC template

## Installation
### Makefile

```shell
$ git clone git@github.com:ezura/MVVMC-template.gitInstallation
$ cd MVVMC-template
$ make
```

## Usage

```
$ mvvmc-template generate {Name}
```

## tasks
### generate files
* [x] ViewModel
  - [x] protocol
    - ~ViewModeling
    - inputs
    - outputs
    - CoordinatorOutputs
* [x] Coordinator
* [x] CoordinatorTests
* [x] Model
* [x] ViewController

### mode
* [ ] strict mode (kickstarter)
* [ ] no model

### improve feature
* [ ] header template
* [ ] customize template
* [ ] sync protocol and implement
* [ ] improve error message

## Ref
* [PackageBuilder](https://github.com/pixyzehn/PackageBuilder)
