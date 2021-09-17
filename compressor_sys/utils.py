def getSourceCode(file_path):
    file = open(file_path, "r")
    result = ''.join(file.readlines())
    file.close()
    return result