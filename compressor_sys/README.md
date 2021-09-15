# Code compressor algorithm
This code compressor is based on the Sequitur algorithm, and what it works making replacements of pair of equal instructions by tokens. It is a very simple algorithm.


To run the code, go to 'compressor_sys' by terminal, then specify the appropiate assembler_file_path (this is the file where the assembled code is located, that is normally a .s file), debug* (print ifo of all the process) and code_summary* (print output data)  and run it. At the end three things are going to be printed
1. Compressed code
2. Conversion table (it contains the token's info)
3. Compression statistics

*OPTIONAL: by default are set to 'False'

## Run Example
> cd compressor_sys
>
> python3 .\decoder.py '.\Benchmarks\Compiled benchmarks\ARM\DSP benchmark\fir_filter.s' True True


pip3 install requests