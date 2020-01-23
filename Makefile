SYSTEMC_LIB = D:\DM\work\systemc-2.3.3\systemc-2.3.3\msvc10\SystemC\Release\SystemC-2.3.3
SYSTEMC_INC = D:\DM\work\systemc-2.3.3\systemc-2.3.3\src

systemc_test:
	mkdir -p systemc_exe
	g++ -o systemc_exe/exe.exe -I. -I$(SYSTEMC_INC) -L. -L$(SYSTEMC_LIB) -Wl,-rpath=$(SYSTEMC_INC) -Wl,-lsystemc -lm sc/main.cpp 
	systemc_exe/exe.exe
