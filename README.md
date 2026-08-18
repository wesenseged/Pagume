<p align="center"><img width="128" src="https://wesen.vercel.app/assets/calendar-0NWxBfhW.png">
<h1 align="center">Pagume</h1>


<p align="center">Pagume is a modern and elegant Ethiopian Calendar.</p>

<p align="center">
    <a href='https://flathub.org/apps/io.github.wesenseged.Pagume'><img width='190' alt='Download on Flathub' src='https://flathub.org/api/badge?locale=en'/></a><br><br>
</p>

| ![Screenie 1](https://raw.githubusercontent.com/wesenseged/Pagume/main/screenshots/Main.png) 
|:---------------------------------------------------------------:|

## Installation

### Flathub
> [!TIP]
> You may need to [install Flatpak and add the Flathub repository](https://flathub.org/setup) if you haven't already.

Use your system's app store to find Pagume or run this command to install it.

```BASH
flatpak install flathub io.github.wesenseged.Pagume
```
##### Compiling manually

Before proceeding, ensure that you have the necessary packages installed for Qt 6 and KDE Frameworks.

```Bash
git clone https://github.com/wesenseged/Pagume
cd Pagume

cmake -B build/ --install-prefix ~/.local
cmake --build build/
cmake --install build/
Pagume
```

To uninstall:
```BASH
cmake --build build/ --target uninstall

```

### Features
- Ethiopian Calendar  
- Public Holidays
- Ethiopian to Gregorian Calendar converter 
- Gregorian to Ethiopian Calendar converter
 
### License
Pagume is licensed under the **GNU General Public License v3.0 or later**

### Contributing
Contributions and feedback are welcome! If you find a bug or want to suggest a feature, please [open an issue](https://github.com/wesenseged/Pagume/issues).
