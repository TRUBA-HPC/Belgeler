import os
import sys

c_files = os.listdir(os.getcwd())
c_files = [f for f in c_files if f.endswith(".md")]
print("Current Dir:",os.getcwd())
print("Current Dir Relevant Content:",c_files)

rst_dir = os.path.dirname(os.getcwd())
rst_dir = os.path.join(rst_dir,"rst")
print("RST Dir:", rst_dir)


cont = input("Is this ok? Y/n:")

if not (cont == "Y" or cont == "y"):
    print("User terminated")
    sys.exit()

for md_filename in c_files:
    md_filepath = os.path.join(os.getcwd(),md_filename)
    rst_filename = md_filename.split(".")[0] + ".rst"
    rst_filepath = os.path.join(rst_dir,rst_filename)
    print("Converting {} to {}".format(md_filepath,rst_filepath))
    os.system("pandoc {} --from markdown --to rst -s -o {}".format(md_filepath,rst_filepath))

