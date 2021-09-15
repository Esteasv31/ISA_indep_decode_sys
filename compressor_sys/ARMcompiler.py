import requests

api_url = "https://godbolt.org/api/compiler/arm1100/compile"

body = {
  "options": {
    "userArguments": "",
    "compilerOptions": {
      "produceGccDump": {}, 
      "produceCfg": False, 
      "produceDevice": False 
    },
    "filters": {
      "binary": False,
      "execute": False,
      "intel": True,
      "demangle": True,
      "labels": True,
      "libraryCode": True,
      "directives": True,
      "commentOnly": True,
      "trim": False
    },
    "tools": [],
    "libraries": []
  },
  "files": [],
  "allowStoreCodeDebug": True
}

body["source"] = "#include <stdio.h>\n#include <string.h>\n\n\n#define NumberOf(a) (sizeof (a) / sizeof *(a))\n\n\n/*  Convolve Signal with Filter.\n\n    Signal must contain OutputLength + FilterLength - 1 elements.  Conversely,\n    if there are N elements in Signal, OutputLength may be at most\n    N+1-FilterLength.\n*/\nstatic void convolve(\n    float *Signal,\n    float *Filter, size_t FilterLength,\n    float *Output, size_t OutputLength)\n{\n    for (size_t i = 0; i < OutputLength; ++i)\n    {\n        double sum = 0;\n        for (size_t j = 1; j < FilterLength; j+=4){\n            sum += Signal[i+j]   * Filter[FilterLength - 1 - j];\n            sum += Signal[i+j+1] * Filter[FilterLength - 1 - j+1];\n            sum += Signal[i+j+2] * Filter[FilterLength - 1 - j+2];\n            sum += Signal[i+j+3] * Filter[FilterLength - 1 - j+3];\n        }\n        Output[i] = sum;\n\n        sum=0;\n        for (size_t j = 1; j < FilterLength; j+=4){\n            sum += Signal[i+1+j]   * Filter[FilterLength - 1 - j];\n            sum += Signal[i+1+j+1] * Filter[FilterLength - 1 - j+1];\n            sum += Signal[i+1+j+2] * Filter[FilterLength - 1 - j+2];\n            sum += Signal[i+1+j+3] * Filter[FilterLength - 1 - j+3];\n        }\n        Output[i+1] = sum;\n\n        sum=0;\n        for (size_t j = 1; j < FilterLength; j+=4){\n            sum += Signal[i+2+j]   * Filter[FilterLength - 1 - j];\n            sum += Signal[i+2+j+1] * Filter[FilterLength - 1 - j+1];\n            sum += Signal[i+2+j+2] * Filter[FilterLength - 1 - j+2];\n            sum += Signal[i+2+j+3] * Filter[FilterLength - 1 - j+3];\n        }\n        Output[i+2] = sum;\n\n        sum=0;\n        for (size_t j = 1; j < FilterLength; j+=4){\n            sum += Signal[i+3+j]   * Filter[FilterLength - 1 - j];\n            sum += Signal[i+3+j+1] * Filter[FilterLength - 1 - j+1];\n            sum += Signal[i+3+j+2] * Filter[FilterLength - 1 - j+2];\n            sum += Signal[i+3+j+3] * Filter[FilterLength - 1 - j+3];\n        }\n        Output[i+3] = sum;\n    }\n}\n\n/*\nint main(void)\n{\n    //  Define a length for buffers that is long enough for this demonstration.\n    #define LongEnough  128\n\n\n    //  Define some sample filters.\n    float Filter0[] = { 1, 2, -1 };\n    float Filter1[] = { 1, 5, 7, 5, 1 };\n\n    size_t Filter0Length = NumberOf(Filter0);\n    size_t Filter1Length = NumberOf(Filter1);\n\n\n    //  Define a unit impulse positioned so it captures all of the filters.\n    size_t UnitImpulsePosition = Filter0Length - 1 + Filter1Length - 1;\n    float UnitImpulse[LongEnough];\n    memset(UnitImpulse, 0, sizeof UnitImpulse);\n    UnitImpulse[UnitImpulsePosition] = 1;\n\n\n    //  Calculate a filter that is Filter0 and Filter1 combined.\n    float CombinedFilter[LongEnough];\n\n    //  Set N to number of inputs that must be used.\n    size_t N = UnitImpulsePosition + 1 + Filter0Length - 1 + Filter1Length - 1;\n\n    //  Subtract to find number of outputs of first convolution, then convolve.\n    N -= Filter0Length - 1;\n    convolve(UnitImpulse,    Filter0, Filter0Length, CombinedFilter, N);\n\n    //  Subtract to find number of outputs of second convolution, then convolve.\n    N -= Filter1Length - 1;\n    convolve(CombinedFilter, Filter1, Filter1Length, CombinedFilter, N);\n\n    //  Remember size of resulting filter.\n    size_t CombinedFilterLength = N;\n\n    //  Display filter.\n    for (size_t i = 0; i < CombinedFilterLength; ++i)\n        printf(\"CombinedFilter[%zu] = %g.\\n\", i, CombinedFilter[i]);\n\n\n    //  Define two identical signals.\n    float Buffer0[LongEnough];\n    float Buffer1[LongEnough];\n    for (size_t i = 0; i < LongEnough; ++i)\n    {\n        Buffer0[i] = i;\n        Buffer1[i] = i;\n    }\n\n\n    //  Convolve Buffer0 by using the two filters separately.\n\n    //  Start with buffer length.\n    N = LongEnough;\n\n    //  Subtract to find number of outputs of first convolution, then convolve.\n    N -= Filter0Length - 1;\n    convolve(Buffer0, Filter0, Filter0Length, Buffer0, N);\n\n    //  Subtract to find number of outputs of second convolution, then convolve.\n    N -= Filter1Length - 1;\n    convolve(Buffer0, Filter1, Filter1Length, Buffer0, N);\n\n    //  Remember the length of the result.\n    size_t ResultLength = N;\n\n\n    //  Convolve Buffer1 with the combined filter.\n    convolve(Buffer1, CombinedFilter, CombinedFilterLength, Buffer1, ResultLength);\n\n\n    //  Show the contents of Buffer0 and Buffer1, and their differences.\n    for (size_t i = 0; i < ResultLength; ++i)\n    {\n        printf(\"Buffer0[%zu] = %g.  Buffer1[%zu] = %g.  Difference = %g.\\n\",\n            i, Buffer0[i], i, Buffer1[i], Buffer0[i] - Buffer1[i]);\n    }\n\n    return 0;\n}\n*/\n"
body["compiler"] = "arm1100"
body["lang"] = "c++"
filePath = "./CompressedFiles/test.s"

response = requests.post(api_url, json=body)
print(response.text)
print(response.status_code)

file = open(filePath, "w")
file.writelines(response.text)
file.close()