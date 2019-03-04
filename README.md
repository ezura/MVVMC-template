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

### [Mint](https://github.com/yonaskolb/mint)

```shell
$ mint install ezura/MVVMC-template
```

## Usage

```
$ mvvmc-template generate {Name}
```

### Options

description | Option
--- | ---
Write copyright in header | `--copyright` or `-C`
Write project name in header | `--project_name` or `-P`

If you want to set copyright:

```
$ mvvmc-template generate --copyright "{copyright}" {Name}
// or
$ mvvmc-template generate -C "{copyright}" {Name}
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
* [ ] generate and install as xcode template (ref: https://useyourloaf.com/blog/creating-custom-xcode-project-templates/)

### improve feature
* [x] header template
* [ ] customize template
* [ ] sync protocol and implement
* [ ] improve error message

## Ref
* [PackageBuilder](https://github.com/pixyzehn/PackageBuilder)
