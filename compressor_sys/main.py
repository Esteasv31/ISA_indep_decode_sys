import argparse
from utils import *
from arm_compiler import *
from decoder import *
# from ARMtoHEXconverter import *

# GLOABL VARAIBLES
temp = None

# Init CLI arguments definition - Catch execution args
parser = argparse.ArgumentParser(description='Python CLI Tool to Compile/Compress/Convert Code')
# Arg for code File Path
parser.add_argument('-codeFile', '--codeFile', type=str, required=True, help='Relative Path of the code to be processed')
# Args for compilation process
parser.add_argument('-compileCode', '--compileCode', type=bool, choices=[True, False], default=True, required=False, help='Flag to compile the code given on the codeFile opt')
parser.add_argument('-compiler', '--compiler', type=str, choices=['arm1100', 'carm1100'], default='carm1100', required=False, help='Compiler to be used - other can be found on https://godbolt.org/')
parser.add_argument('-codeLang', '--codeLang', type=str, choices=['c++', 'c'], default='c', required=False, help='Languaje of the input codeFile')
# Args for compression process
parser.add_argument('-compressCode', '--compressCode', type=bool, choices=[True, False], default=True, required=False, help='Flag to compress the code given on the codeFile opt')
parser.add_argument('-showOutput', '--showOutput', type=bool, choices=[True, False], default=False, required=False, help='Flag to enable prints for show Output compressed files on console')

# Args for conversion process 
parser.add_argument('-convertCode', '--convertCode', type=bool, choices=[True, False], default=True, required=False, help='Flag to convert the code given on the codeFile opt to HEX')
#parser.add_argument('-codeLang', '--codeLang', type=str, choices=['c++', 'c'], default='c', required=True, help='Lnaguaje of the input codeFile')

# Debug options
parser.add_argument('-debug', '--debug', type=bool, choices=[True, False], default=False, required=False, help='Flag to enable prints for debug porpouses')

# Final args object
args = parser.parse_args()

# Init prcoess 
def compileCode():
    global temp
    source_code = getSourceCode(args.codeFile)
    temp = compile(source_code, args.compiler, args.codeLang, args.codeFile, args.debug)

def compressCode():
    global temp
    file_path = args.codeFile
    if(args.compileCode):
        file_path = temp
    run_compressor(file_path, args.debug, args.showOutput)
    print('compression')

def convertCode():
    print('conversion')


# execute process based on args
# Compile code
if(args.compileCode):
    compileCode()

# Compress code
if(args.compressCode):
    compressCode()

# Convert code to HEX
if(args.convertCode):
    convertCode()


# Run command > python3 .\main.py 