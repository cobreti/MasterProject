import os.path
import xml.etree.ElementTree as ET

def buildFilesList():

    nyxPath = os.path.abspath("/Users/dannyt/dev/MasterProject/sources/EmbeddedRes/CodeSite/Nyx")
    files = {}

    for folder, folderNames, filenames in os.walk(nyxPath):

        for file in filenames:
            fullPath = os.path.join(folder, file)
            relPath = os.path.relpath(fullPath, nyxPath)
            files[relPath] = 0

    return files


def buildMappedFilesList():

    xmlPath = os.path.abspath("/Users/dannyt/dev/MasterProject/sources/EmbeddedRes/diagrams/Nyx/diagrams.xml")
    tree = ET.parse(xmlPath)
    root = tree.getroot()
    mappedFiles = {}

    for elm in root.iter():
        attribs = elm.attrib
        if "displayName" in attribs and attribs["displayName"] == "Url":
            print(attribs["value"])
            mappedFiles[attribs["value"]] = 0

    return mappedFiles


srcFiles = buildFilesList()

for file in srcFiles:
    print(file + " : ", end="")
    print(srcFiles[file])

print()
print()

mappedFiles = buildMappedFilesList()

for file in mappedFiles:
    print(file)
    if file in srcFiles:
        srcFiles[file] = srcFiles[file] + 1

print()
print()

totalItems = 0
refItems = 0

for file in srcFiles:
    print(file + " : ", end="")
    print(srcFiles[file])
    totalItems = totalItems + 1

    if srcFiles[file] > 0:
        refItems = refItems + 1

print()
print()
print("Files not mapped")
print("================")

for file in srcFiles:
    if srcFiles[file] == 0:
        print(file + " : ", end="")
        print(srcFiles[file])


print()
print()
print("coverage statistics:")
print("======================")
print("total files : " + str(totalItems))
print("references files : " + str(refItems))
print("coverage % : " + str( refItems / totalItems * 100.0))





# print(srcFiles)


