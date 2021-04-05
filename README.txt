This is an optimized version of the Infomap code.

Optimization Include:
==========================

	1. Fully parallelized (MPI + OpenMP) version of the community optimization kernel

	2. CreatingSupernode kernel parallelized

	3. Timing codes are changed with <chrono> library instead of high overhead MPI_Wtime() function.

	4. Function parameters are cleaned up with global extern variables across multiple files.

	5. Which function takes how much time and called how many times in a particular run is reported.

	6. Further optimization may be possible


How to compile in cori KNL:
===========================

	1. navigate to the directory where the code is saved

	2. issue the command "module load metis"

	3. issue the command "module swap craype-haswell craype-mic-knl"

	4. issue the command "make"


How to compile in LONI QB2:
===========================

	1. navigate to the directory where the code is saved

	2. issue the command "module load metis"

	4. issue the command "make"
