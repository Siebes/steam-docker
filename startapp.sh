#!/bin/bash
DISPLAY=:1 winetricks --no-isolate steam;DISPLAY=:1 wine /home/wine/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-dwrite;
