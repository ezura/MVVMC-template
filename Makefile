INSTALL_PATH = /usr/local/bin/mvvm-template

install:
	swift package update
	swift build -c release -Xswiftc -static-stdlib
	cp -f .build/release/mvvmc-template $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)
