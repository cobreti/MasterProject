import os.path
import shutil

baseSourcePath = os.path.abspath("/Volumes/data/dev/NyxDev/")
baseDestPath = os.path.abspath("/Volumes/data/dev/MasterProject/sources/EmbeddedRes/CodeSite/Nyx")

srcPaths = \
    [
        os.path.join(baseSourcePath, "Nyx/include"),
        os.path.join(baseSourcePath, "Nyx/NyxBase"),
        os.path.join(baseSourcePath, "Nyx/NyxNet"),
        os.path.join(baseSourcePath, "Nyx/NyxWebSvr"),
        os.path.join(baseSourcePath, "NyxTraceViewer/QtTraceClient"),
        os.path.join(baseSourcePath, "NyxTraceViewer/TraceClientCore")
    ]


for path in srcPaths:
    for folder, folderNames, filenames in os.walk(path):
        # print(folder)
        # print(filenames)
        # print();

        if not('openssl' in folder or 'UI' in folder or 'Cocoa' in folder):
            files = []

            for file in filenames:
                comp = os.path.splitext(file)

                if comp[1] == '.h' or comp[1] == '.hpp':
                    files.append(file)
                    # print(comp[0] + " -- " + comp[1])

            if len(files) > 0:
                print("-- " + folder)
                relPath = os.path.relpath(folder, baseSourcePath)
                dstPath = os.path.join(baseDestPath, relPath)
                os.makedirs(dstPath)
                print("==> " + relPath)
                for file in files:
                    src = os.path.join(folder, file)
                    dstPath = os.path.join(baseDestPath, relPath, file)
                    print(src + " --> " + dstPath)
                    shutil.copyfile(src, dstPath)
                print()




