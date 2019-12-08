# Xcode GitLab runner

A Vagrantfile to build a fully functional macOS / Xcode GitLab runner

## TL;DR

### Build and run the runner
Once VirtualBox and Vagrant are installed, use the following command to build and run the box :

    XCODE_XIP_FILE="/path-to-Xcode.xip" \
    GITLAB_URL="https://gitlab.com/" \
    GITLAB_REGISTRATION_TOKEN="your-token" \
    GITLAB_RUNNER_NAME="macMachine" \
    GITLAB_RUNNER_TAGS="macos,xcode11" \
    vagrant up

Note that an Xcode .xip install archive is required to perform Xcode installation.

### Test and anlayse a project
Add and configure a sonar-project.properties as explained [here](https://github.com/Backelite/sonar-swift)

Then use the following **.gitlab-ci.yml** file to perform a code analysis (and publication to SonarQube):

    analyse:
      tags:
        - xcode11
      script:
        - pod install
        - start-simulator.sh "iPhone 11 Pro"
        - run-sonar-swift.sh -sonarurl=$SONAR_URL -sonarlogin=$SONAR_TOKEN
  
**start-simulator.sh** pre-launches the simulator for tests. Be careful to use the same simulator as the one defined in you **sonar-project.properties**.

**run-sonar-swift.sh** builds, tests, analyses and publishes results to a SonarQube server. **SONAR_URL** and **SONAR_TOKEN** are defined as GitLab CI/CD variables.

## What's in the box ?

Here is a list of tools included in the box :
- Xcode
- fastlane
- sonar-swift
- sonar-scanner
- xcpretty
- gcovr
- CocoaPods
- Carthage
- XCode
- slather
- OCLint
- SwiftLint
- applesimutils

## Prerequisites

### VirtualBox

A recent version of VirtualBox and extension pack is required to run the generated virtual machine.

VirtualBox can be downloaded from [here](https://www.virtualbox.org/).

Or installed using [Homebrew](https://brew.sh/): 

    brew cask install virtualbox
    brew cask install virtualbox-extension-pack

### Vagrant

Vagrant and its reload plugin are required to run the Vagrantfile.

It can be installed using [Homebrew](https://brew.sh/):

    brew cask install vagrant
    vagrant plugin install vagrant-reload

### Xcode .xip file

A Xcode .xip install archive is required to build the box.

It can be downloaded from [here](https://developer.apple.com/download/more/) (Apple ID required).

## Parameters

Parameters are set as environmeent variables when running "vagrant up" command:

    PARAM1="stringvalue" PARAM2=numbervalue ... vagrant up

Here is a list of available parameters

| Parameter                 | Default value        |
|---------------------------|:--------------------:|
| XCODE_XIP_FILE            | none (manadatory)    |
| GITLAB_URL                | https://gitlab.com/  |
| GITLAB_REGISTRATION_TOKEN | none (mandatory)     |
| GITLAB_RUNNER_NAME        | none (mandatory)     |
| GITLAB_RUNNER_TAGS        | none (mandatory)     |
| CPU_COUNT                 | 2                    |
| RAM_SIZE                  | 4096                 |

## Reminder : OS X Licensing
Apple's EULA states that you can install your copy on your actual Apple-hardware, plus up to two VMs running on your Apple-hardware. So using this box on another hardware is may be illegal and you should do it on your own risk.

By using it you agree with all macOS Sierra and XCode license agreements.

