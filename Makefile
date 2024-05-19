BIN=<binary_name>
MAINTAINER='Jason Statham <j.s@hollywood.comz>'
ARCH=all
RELEASE=1.0.0
BIN_DIR=${BIN}_${RELEASE}
BIN_INSTALL_DIR=${BIN_DIR}/usr/local/bin
DEBIAN_DIR=${BIN_DIR}/DEBIAN
DESCRIPTION=<description>
ARCHIVE=${RELEASE}.tar.gz

# Targets
.PHONY: all setup build package clean

all: setup build package

setup:
	@echo "Setting up directories..."
	mkdir -p ~/${BIN_INSTALL_DIR}
	mkdir -p ~/${DEBIAN_DIR}

build: setup
	@echo "Building the binary..."
	cd ~/${BIN_INSTALL_DIR} && \
	wget <URL>${ARCHIVE} && \
	tar -xvf ${ARCHIVE} && \
	rm -rf ${ARCHIVE} && \
	cd ${BIN}_${RELEASE}/ \
	make binary && \
	make install && \
	cp cmd/xxx ../../ && \
	rm -rf xxx-${RELEASE}

package: build
	@echo "Creating control file..."
	echo "Package: ${BIN}" >> ~/${DEBIAN_DIR}/control
	echo "Version: ${RELEASE}" >> ~/${DEBIAN_DIR}/control
	echo "Architecture: ${ARCH}" >> ~/${DEBIAN_DIR}/control
	echo "Maintainer: ${MAINTAINER}" >> ~/${DEBIAN_DIR}/control
	echo "Description: ${DESCRIPTION}" >> ~/${DEBIAN_DIR}/control
	@echo "Building the package..."
	dpkg-deb --build --root-owner-group ~/${BIN_DIR}

clean:
	@echo "Cleaning up..."
	rm -rf ~/${BIN_DIR}


### Docker 

build-image:

	docker build -t ubuntu:j .

exec-image:

	docker run -it -u root ubuntu:j bash

tag-image:

	docker tag ubuntu:j <your_private_repo>

push-image:

	docker push <your_private_repo>