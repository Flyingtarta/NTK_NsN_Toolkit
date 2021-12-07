import os
import shutil

cwd = os.getcwd()
dir = os.listdir()
png2paa =  'D:\SteamLibrary\steamapps\common\Arma 3 Tools\TexView2'
print(cwd)

if not "png" in os.listdir():
    os.mkdir("png")

os.chdir(png2paa)

for file in dir:
    if file.endswith('.paa'):
        origen = os.path.join(cwd,file)
        dest = origen[0:-3] + "png"
        os.system(f'Pal2PacE.exe "{str(origen)}" "{dest}"')


for file in os.listdir(cwd):
    if file.endswith(".png"):
        shutil.move( os.path.join(cwd,file) ,os.path.join(cwd,"png",file) )
