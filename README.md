[![CI](../../actions/workflows/ci.yml/badge.svg)](../../actions/workflows/ci.yml)

# pv-utility

Utility scripts to monitor progress of Linux commands using PV

## Install

1.  install pv on your system

    Debian / Ubuntu users

    ```sh
    apt update && apt install pv
    ```

    RHEL / CentOS / SL / Fedora Linux users

    ```sh
    yum install pv
    ```

2.  clone or download repository

3.  add script folder to path

    edit **~/.bashrc** and add

    ```sh
    export PATH="path-pv-utility/src:$PATH"
    ```

## License

[MIT License](LICENSE)
