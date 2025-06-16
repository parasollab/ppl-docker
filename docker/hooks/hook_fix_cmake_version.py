import os

# fix the CMake version for Bullet from version 2.4.3 to 3.5. 
def pre_generate(conanfile):
    cmakelists_path = os.path.join(conanfile.source_folder, "CMakeLists.txt")

    if not os.path.exists(cmakelists_path):
        return 

    # read in the file
    with open(cmakelists_path, "r", encoding="utf-8") as f:
        content = f.read()

    if "VERSION 2.4.3" in content:
        new_content = content.replace("VERSION 2.4.3", "VERSION 3.5")
    else:
        new_content = content

    with open(cmakelists_path, "w", encoding="utf-8") as f:
        f.write(new_content)