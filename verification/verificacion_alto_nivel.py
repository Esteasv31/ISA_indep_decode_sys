import sys
from os import listdir
from os.path import isfile, join

# text color formats for print error / success / warning messages
red_text = '\033[1;31;40m'
green_text = '\033[1;32;40m'
yellow_text = '\033[1;33;40m'
end_line = '\033[0;0;0m'
red_bg = '\033[2;37;41m'
green_bg = '\033[2;37;42m'
yellow_bg = '\033[2;37;43m'

# result variable for each test
result = False
fail = False

# simulation folder path
simulation_path = sys.argv[1]

# validation folder path
validation_path = simulation_path + '/validate/'

# outputs folder path
outputs_path = simulation_path + '/outputs/'

# files names
files_name = [f.split('_')[0] for f in listdir(validation_path) if (isfile(join(validation_path, f)) and f.endswith('.txt'))]

# recorre cada uno de los archivos de validacion creados por los test
for i, name in enumerate(files_name):
    # Lee el archivo de validacion del componente
    validate_file = open(validation_path + name + "_validate.txt", encoding = 'utf-8')
    # Lee el archivo de salida del test del componente
    output_file = open(outputs_path + name + "_output.txt", encoding = 'utf-8')
    # number of lines in validate file
    validate_lines = validate_file.readlines()
    validate_lines = [f.replace('\n', '') for f in validate_lines]
    # number of lines in output file
    output_lines = output_file.readlines()
    output_lines = [f.replace('\n', '') for f in output_lines]

    # check if number of lines to validate is the same
    fail = len(validate_lines) != len(output_lines)
    if(fail):
        print(red_text + "ERROR:" + end_line + " Number of result given is wrong, run the test again to get the same number of outputs than validation lines " + end_line)
        break
    # recorre cada una de las soluciones en el archivo de validacion
    for index, line in enumerate(validate_lines):
        # check if expected result is different from the output given
        if(line != output_lines[index]):
            print(red_text + f"ERROR: wrong result." + end_line + " Value expected " + green_text + f"{line} " + end_line + "value given " + red_text + f"{output_lines[index]}  " + end_line)
            result = False
            break
        result = True
    # check module final result
    if(not fail):
        if(not result):
            print(f"{yellow_text + str(i+1) + end_line}. -> El componente {red_text + name + end_line} NO cumple la especificación  " + end_line)
        else:
            print(f"{yellow_text + str(i+1) + end_line}. -> El componente {green_text + name + end_line} cumple la especificación  " + end_line)
    # clean memory and variables for next module
    del output_lines
    del validate_lines
    del output_file
    del validate_file
