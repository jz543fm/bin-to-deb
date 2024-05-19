# Bin to .deb template

Basic templates to package executable/binary to the .deb package on the host node or with the usage of Gitlab CI

## File Structure

For Complete File Structure check the dir `xxx_1.0.0`, for shorted version u can use simple structure:

```bash
# tree ${BIN}_${RELEASE}
├── ~/xxx_1.0.0
│   ├── DEBIAN
│   │    └── control
└── usr
    └── local
        └── bin
            └── xxx #executable with right permission, do not forget to check it!
```

### 1st example - Makefile

If you wamt to build it on localhost, update Makefile and check how to install your executable/binary by the documentation and fix lines in Makile from `24-29`, where you need to add correct path from where it should be downloaded executable/binary, then add steps to install it from source and do not forget to have all dependencies installed on host when you are using Makefile

```make
make
```

### 2nd example - Gitlab CI

Update your `.gitlab-ci.yaml` and update lines `27-29` with steps how to install your executable/binary from source, then fix `Dockerfile` with dependencies that you need to build your executable/binary and try to build it from pipeline, .deb package can be downloaded then as a artifact


## How to create a system service for .deb package

You need to add `/lib/systemd/system/x.service` that will contain systemd config for your xxx.service
then you need also `postinst` script that should contain just `systemctl daemon-reload, systemctl start xxx.service`, if you want to enable to start service after boot, add also after daemon-reload, `systemctl enable xxx.service`

```bash
# tree ${BIN}_${RELEASE}
├── ~/xxx_1.0.0
│   ├── DEBIAN
│   │   └── control
│   │   └── postinst
│   ├── lib
│   │   └── systemd
│   │       └── system
│   │           └── xxx.service
└── usr
    └── local
        └── bin
            └── xxx #executable with right permission, do not forget to check it!
```

## Install and remove package

```bash
#install
dpkg -i <package>.deb
#uninstall
dpkg -r <package>
```