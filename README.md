# MVVMC-template

generate MVVMC template.

## generated files
* Coordinator
* CoordinatorTests
* Model
* ViewController
* ViewModel
  - protocol
    - ~ViewModeling
    - inputs
    - outputs
    - CoordinatorOutputs

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
* [ ] install as xcode template (ref: https://qiita.com/shu223/items/5d8a245e5743f77df9eb)
* [ ] strict mode (kickstarter)
* [ ] no model

### improve feature
* [ ] header template
* [ ] customize template
* [ ] sync protocol and implement
* [ ] improve error message

## Ref
* [PackageBuilder](https://github.com/pixyzehn/PackageBuilder)
