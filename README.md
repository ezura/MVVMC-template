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
$ git clone git@github.com:ezura/MVVMC-template.git
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
* [ ] generate as xcode template (ref: https://useyourloaf.com/blog/creating-custom-xcode-project-templates/)

### improve feature
* [ ] header template
* [ ] customize template
* [ ] sync protocol and implement
* [ ] improve error message

## Ref
* [PackageBuilder](https://github.com/pixyzehn/PackageBuilder)
