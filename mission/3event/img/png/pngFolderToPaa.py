import os

cwd = os.getcwd()
dir = os.listdir()
png2paa =  'D:\SteamLibrary\steamapps\common\Arma 3 Tools\TexView2'

os.chdir(png2paa)
for file in dir:
    if file.endswith('.png') or file.endswith('.paa'):
        origen = os.path.join(cwd,file)
        dest = cwd
        os.system(f'Pal2PacE.exe "{str(origen)}"')
