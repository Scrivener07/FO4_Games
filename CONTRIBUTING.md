This project uses the following import and namespace for scripting and assets.
* Namespace: `Games`
* Papyrus: `Fallout 4\Data\Scripts\Source\FO4_Games`
* Flash: `Fallout 4\Data\Interface\Source\FO4_Games`

#### Required
* [F4SE](http://f4se.silverlock.org/)
* * Papyrus: `Fallout 4\Data\Scripts\Source\F4SE`
* [HUD Framework](http://www.nexusmods.com/fallout4/mods/20309/)
* * Papyrus: `Fallout 4\Data\Scripts\Source\HUD_FRAMEWORK`
* * Flash: `Fallout 4\Data\Interface\Source\HUD_FRAMEWORK`


## Git

#### GitHub Desktop
If you use git on the command line or another git client then feel ignore this.

You will need a git client to download files from the repository and stay in sync with any changes. Github has their own git client that I use and recommend.
* Download the installer from [here](https://desktop.github.com/).
* Run the installer.
* On the github website, select the green `Clone or download` button, and then select `Open in Desktop`.

#### Git Large File Storage
This repository requires the use of GIT LFS to retreive large files. [Git Large File Storage (LFS)](https://git-lfs.github.com/) replaces large files with text pointers inside Git, while storing the file contents on GitHub.
* Download the windows installer from [here](https://github.com/git-lfs/git-lfs/releases).
* Run the windows installer.
* Start a command prompt/or git for windows prompt and run `git lfs install`.

## Compiling

#### Data Plugin
Rename to `Games.esm` and use xEdit to edit the files header with the `ESM` flag.

#### Papyrus
To compile this projects papyrus source code, start a command prompt and run the following. Adjust the path for your machine.
`PapyrusCompiler.exe "D:\Games\Steam\SteamApps\common\Fallout 4\Data\Scripts\Source\FO4_Games\Build.ppj"`

#### Flash
To publish this projects flash interface files, open the `FLA` file in Flash and publish the `SWF` file.


## Release Checklist
* Commit all source changes to the `master` branch.
* Compile
* * Compile the projects interface Flash files.
* * Compile the prjects script Papyrus files.
* Plugin
* * Load `Games.esp` with the Creation Kit in order to check for errors.
* * Load `Games.esp` with the xEdit in order to check for errors.
* * In Wrye, use the `Copt to ESM` feature to convert `Games.esp` to `Games.esm`.
* Archive
* * Verify that `Games.achlist` is correct.
* * Package the `Games.achlist` into the required `.ba2` archives.
