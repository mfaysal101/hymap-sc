This is an optimized version of the Hybrid Infomap (HyPC-Map) code. 

Section 1::Optimization Include:
==========================

	1. Fully parallelized (MPI + OpenMP) version of the community optimization kernel

	2. CreatingSupernode kernel parallelized

	3. Timing codes are changed with <chrono> library instead of high overhead MPI_Wtime() function.

	4. Function parameters are cleaned up with global extern variables across multiple files.

	5. Which function takes how much time and called how many times in a particular run are reported.

	6. Further optimization may be possible


Section 2::How to generate .csr (compressed sparse row) format that HyPC-Map supports from SNAP edgelist format:
===========================

	1. Compile the edgelist2metis_converted.cpp file using a c++ compiler, e.g., issue following command for g++ compiler "g++ edgelist2metis_converter.cpp -o csr_convert" 
	
	2. Get rid of the comments/description (if any) on top of the edgelist file downloaded from SNAP
	
	3. Convert the edgelist file to .csr file using the following command "./csr_convert your_edgelist_file.txt your_csr_filename.csr"
	
	4. Compile the file "metis_csr_parser.cpp" by the command "g++ metis_csr_parser.cpp -o metiser"
	
	5. To run HyPC-Map using 32 MPI process, the initial partition file needs to be generated by the Metis partitioner
	
	6. Load Metis partitioner by issuing the following command "module load metis"
	
	7. Run the following command to generate the metis partitioner file "./metiser your_csr_filename.csr 32 32.txt". This command will use the application to generate partition file for 32 MPI processes and store that in a text file name of your choice (in this case "32.txt")
	

Section 3::How to compile in cori KNL:
===========================

	1. Navigate to the directory where the code is saved

	2. Issue the command "module load metis"

	3. Issue the command "module swap craype-haswell craype-mic-knl"

	4. Issue the command "make"


How to compile in LONI QB2:
===========================

	1. Navigate to the directory where the code is saved

	2. Issue the command "module load metis"

	3. Issue the command "make"
	

Section 4::How to run HyPC-Map:
============================

	[Usage] >./ompInfomap <seed> <network data> <# threads> <# attempts> <threshold> <vThresh> <maxIter> <outDir> <prior/normal> <metis_partition_file>

The required arguments are following:

	1) seed: this is for random seed value for generating random sequential order of vertices during the iterative optimization process.

	2) network data: The .csr file generated using the auxiliary program

	3) # thread: the number of threads 

	4) # attempts: the number of attempts (leave this flag to 1)

	5) threshold: the stop condition threshold  (recommended 1e-3 or 1e-4)

	6) vThresh: the threshold value for each vertex movement (recommended 0.0)

	7) maxIter: the number of maximum iteration for each super-step. (recommended 10)

	8) outDir: the directory where the output files will be located.

	9) prior/normal flag: apply the prioritized search for efficient runs (prior) or not (normal).  (recommended prior)

       10) metis_partition_file: this is the initial network partitioner file generated by metis for the given network. If you are using 32 mpi processes to run the program, then you have already generated the corresponding partition file "32.txt" following steps 4-7 in Section 2.


To run the program using 32 MPI processes, seed value 1, using youtube network com-youtubbe.csr, 10 OpenMP threads, # attempts = 1, threshold value 1e-3, vThresh value 0.0, maximum number of iteration (maxIter) in super step 10, output directory (outDir) name outputs, priority flag set with prior, and metis partition file for youtube network using 32 partitions, issue the following command

	"mpirun -n 32 ./ompInfomap 1 directory_2_network/com-youtube.csr 10 1 1e-3 0.0 10 outputs/ prior directory_2_initial_partition_file/32.txt"
	

