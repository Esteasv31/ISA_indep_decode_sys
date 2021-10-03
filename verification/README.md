# Code compilation, compression & conversion

The code in this project presents a python script to check the functionality of the different hardware components implemented and used on this project.

The results of the projects to be verify should be hold on a unique folder holding the subsfolders:

* inputs
* outout
* validate

The input folder holds the input files to be charged on the different modules to be tested

The output folder olds the results of running the testbenches of the different modules.

Then the validate folder holds the files wit the expected resultsto get from the run of the testbench cases.

`The name of the input, output and validate files for each module shoulbe called the same as follow.`

`<fileName>_input.txt`

`<fileName>_output.txt`

`<fileName>_validate.txt`

`Not use '_' to separeta the name file, it is a special character to list and identify the modules to be check.`

## Simple way to run it

To run the main script just run the next commands and put the path of the simulation folder to be verify.

> cd verification
>
> python3 .\verification_alto_nivel.py < SimulationFolderPath >