#### Git Large File Storage
This repository requires the use of GIT LFS to retreive large files. [Git Large File Storage (LFS)](https://git-lfs.github.com/) replaces large files with text pointers inside Git, while storing the file contents on GitHub.
* Download the windows installer from [here](https://github.com/git-lfs/git-lfs/releases).
* Run the windows installer
* Start a command prompt/or git for windows prompt and run `git lfs install`.

#### Required Resources
* [F4SE](http://f4se.silverlock.org/)
* * Papyrus: `Fallout 4\Data\Scripts\Source\F4SE`
* [HUD Framework](http://www.nexusmods.com/fallout4/mods/20309/)
* * Papyrus: `Fallout 4\Data\Scripts\Source\HUD_FRAMEWORK`
* * Actionscript: `Fallout 4\Data\Interface\Source\HUD_FRAMEWORK`

#### Papyrus
To compile the papyrus scripts, start a command prompt and run the following. Adjust the path for your machine.
`PapyrusCompiler.exe "D:\Games\Steam\SteamApps\common\Fallout 4\Data\Scripts\Source\FO4_Games\Build.ppj"`
