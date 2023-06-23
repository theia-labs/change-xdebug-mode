
# change-xdebug-mode

Bash script to change xdebug mode

## Introduction

This script is used to configure [xdebug mode](https://xdebug.org/docs/install#mode). It can update your xdebug configuration in `php.ini` to enable the desired mode. By default, the script change `/usr/local/etc/php/conf.d/20-xdebug.ini` and restarts fpm with `kill -USR2 1` (recommanded for fpm docker container). Feel free to adjust it according to your needs.
## Installation

Download this tool using wget

```bash
wget https://raw.githubusercontent.com/theia-labs/change-xdebug-mode/main/change-xdebug-mode.sh
```
    
## Usage/Examples

Set debug mode
```bash
change-xdebug-mode -d
```

Set coverage mode
```bash
change-xdebug-mode -c
```

Disable xdebug
```bash
change-xdebug-mode -o
```

You can use multiple options. For example, you can set both debug and coverage modes
```bash
change-xdebug-mode -dc
```
