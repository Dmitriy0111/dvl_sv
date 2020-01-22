
systemc_test:
	mkdir -p systemc_exe
	g++ -o systemc_exe/exe.exe -I. -I$(SYSTEMC_INC) -L. -L$(SYSTEMC_LIB) -Wl,-rpath=$(SYSTEMC_INC) -Wl,-lsystemc -lm sc/main.cpp 
	systemc_exe/exe.exe
