
class FileManagement:
    def file_print(self, file):
        print("---------------------------")
        print("Printing input file")
        print("---------------------------")

        for line in file:
            print(line, end="")
    
    def remove_whitespaces(self, list):
        new_list = []
        for line in list:
            new_list.append(
                line.strip().replace(" ", "").replace("\t", " "))
        
        return new_list

    def input_file_get(self, assembler_file_path):
        return open(assembler_file_path, "r")

    def input_file_close(self, file):
        file.close()
    
    def file_list_get(self, file):
        return [a for a in file]

    def char_count(self, input):
        char_count = 0
        if isinstance(input, list):
            char_count = sum(len(str(i)) for i in input)
        elif isinstance(input, dict):
            for i in input:
                sublist = input[i]
                char_count += sum(len(str(j)) for j in sublist)
        else:
            print("Invalid input type")
            return -1

        return char_count

    def createNewFile(self, filePath, data, isDictionary=False):
        file = open(filePath, "w")
        if(isDictionary):
            data = self.parseDictionaryToList(data)
            file.writelines(data)
            file.close()
        else:
            file.writelines(self.parseListToString(data))
            file.close()

    def parseListToString(self, list):
        result = []
        tokenDir = {}
        tokenIndex = 0
        for item in list:
            if(isinstance(item, int) and (item in tokenDir)):
               result.append(str(tokenDir[item]) + '\n')
            elif(isinstance(item, int)):
                tokenDir[item] = tokenIndex
                tokenIndex += 2
                result.append(str(tokenDir[item]) + '\n')
            else:
                result.append(str(item) + '\n')
        return result

    def parseDictionaryToList(self, dic):
        result = []
        for value in dic.values():
            for item in value:
                result.append(item + '\n')
        return result
