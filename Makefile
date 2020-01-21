systemc_test:
	mkdir -p systemc_exe
	g++ -o systemc_exe/exe.exe sc/main.cpp
	systemc_exe/exe.exe
