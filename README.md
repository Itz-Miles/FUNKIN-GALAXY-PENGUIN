

<!--This is the markdown readme. View the pretty format on the webpage-->
![logo](./art/logos/logo/logoHD.png)
___
# Source for Funkin' VS Galaxy Penguin

If you want to play, visit the [webpage](https://itz-miles.github.io/funkinMinecraft/play).

If you want to download, visit [releases](https://github.com/Itz-Miles/FNF-VS-GALAXY-PENGUIN/releases/latest).

# Building From Source

## Haxe
You must have [the most up-to-date version of Haxe](https://haxe.org/download/) (4.2.4+) in order to compile.

## Visual Studio / Visual Studio Code

Install [Visual Studio Code](https://code.visualstudio.com/download).

For language support, debugging, linting, and documentation, install the [Vs Haxe Extension Pack](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-extension-pack).

For Lime / OpenFL project support, install the [Lime Extension](https://marketplace.visualstudio.com/items?itemName=openfl.lime-vscode-extension).

`windows` For compiling the game on windows, install [Visual Studio 19](https://visualstudio.microsoft.com/vs/older-downloads/#visual-studio-2019-and-other-products) and ONLY these components:
```
MSVC v142 - VS 2019 C++ x64/x86 build tools
Windows SDK (10.0.17763.0)
```

## Command Prompt/Terminal

 Any of these methods send you to a terminal, which are used to install libraries and compile the game.
 
`windows`
```
Vs Code: View > Terminal 

Start Menu: Click on the Start button, type "PowerShell" or "Command Prompt" in the search bar, and select the respective application from the search results.

File Explorer: Navigate to the desired location and enter "powershell" or "cmd" in the address bar to open with the current location set as the working directory.

Run Dialog: Press the Windows key + R to open the Run dialog, type "powershell" or "cmd", and press Enter.
```

`mac`
```
Vs Code: View > Terminal

Spotlight Search: Press Command + Space to open Spotlight Search, type "Terminal," and press Enter.

Finder: Open the Finder, go to the "Applications" folder, open the "Utilities" folder, and double-click on the "Terminal" application.

Launchpad: Open the Launchpad (icon looks like a rocket in the Dock), type "Terminal" in the search bar, and click on the Terminal app.
```

`linux`
```
Ain't no way I'm compiling the game on every single linux distro. Try stuff out and see!
```

## Haxe Module Manager
To install HMM for installing and managing libraries needed for Funkin' Minecraft, run the following command:
`haxelib install hmm`

To install the libraries listed in hmm.json, run the following command:
`haxelib run hmm install`

## Compilation
Run the correlating commands in the terminal that match your build target to compile.

`windows`
```
lime test windows
lime test windows -debug
lime build windows
```

`linux`
```
lime test linux
lime test linux debug
lime build linux
```

`html5`
``` 
lime test html5
lime test html5 -debug
lime build html5
```

`mac`
```
lime test mac
lime test mac -debug
lime build mac
```

# Credits:

©It'z_Miles 2023 Some rights reserved.

Funkin' VS Galaxy Penguin is not an official Super Mario product. Not approved by or assosiated with Nintendo of America.

## VS GALAXY PENGUIN
* It'z_Miles - Developer/Parallax3D <img src="./assets/shared/images/icons/miles.png" width="16">
* github - [contributors](https://github.com/FNF-VS_GALAXY-PENGUIN/graphs/contributors) <img src= "./assets/shared/images/icons/github.png" width="16">


## Funkin' Crew
* ninjamuffin99 - Programmer of Friday Night Funkin' <img src="./assets/shared/images/icons/ninjamuffin99.png" width="16">
* PhantomArcade -	Animator of Friday Night Funkin' <img src="./assets/shared/images/icons/phantomarcade.png" width="16">
* evilsk8r - Artist of Friday Night Funkin' <img src="./assets/shared/images/icons/evilsk8r.png" width="16">
* kawaisprite - Composer of Friday Night Funkin' <img src="./assets/shared/images/icons/kawaisprite.png" width="16">
* github - [contributors](https://github.com/FunkinCrew/Funkin/graphs/contributors) <img src= "./assets/shared/images/icons/github.png" width="16">

