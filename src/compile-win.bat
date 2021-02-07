
rmdir /s /q win_bin
mkdir win_bin

call %USERPROFILE%\Miniconda3\Scripts\activate.bat %USERPROFILE%\Miniconda3\envs\mozc
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\vsvars32.bat"

python build_mozc.py clean
python build_mozc.py gyp --qtdir=c:\Qt\Qt5.6.2\5.6\msvc2015
python build_mozc.py build -c Release package

xcopy out_win\Release\mozc_broker32.exe win_bin
xcopy out_win\Release\mozc_cache_service.exe win_bin
xcopy out_win\Release\mozc_renderer.exe win_bin
xcopy out_win\Release\mozc_server.exe win_bin
xcopy out_win\ReleaseDynamic\mozc_tool.exe win_bin
xcopy out_win\ReleaseDynamic\Qt5Core.dll win_bin
xcopy out_win\ReleaseDynamic\Qt5Gui.dll win_bin
xcopy out_win\ReleaseDynamic\Qt5Widgets.dll win_bin
xcopy out_win\ReleaseDynamic\platforms\qwindows.dll win_bin
xcopy out_win\Release_x64\mozc_broker64.exe win_bin

xcopy out_win\Release\mozc_ja_tip32.dll win_bin
xcopy out_win\Release_x64\mozc_ja_tip64.dll win_bin

rmdir /s /q "%ProgramFiles(x86)%\Mozc"
mkdir "%ProgramFiles(x86)%\Mozc"
xcopy /C win_bin\* "%ProgramFiles(x86)%\Mozc"

:: /S is for Silent (no popup on screen, baka windows)


regsvr32 /S "%ProgramFiles(x86)%\Mozc\mozc_ja_tip32.dll"
regsvr32 /S "%ProgramFiles(x86)%\Mozc\mozc_ja_tip64.dll"

:: regsvr32 /S /U "%ProgramFiles(x86)%\Mozc\mozc_ja_tip32.dll"
:: regsvr32 /S /U "%ProgramFiles(x86)%\Mozc\mozc_ja_tip64.dll"