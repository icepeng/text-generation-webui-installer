@echo off

@echo Fixing bitsandbyte's Windows issues...

copy bitsandbytes_windows\libbitsandbytes_cuda116.dll installer_files\env\lib\site-packages\bitsandbytes\libbitsandbytes_cuda116.dll

@echo Rewriting cuda_setup/main.py...

Echo off
cd installer_files\env\lib\site-packages\bitsandbytes\cuda_setup
set "textfile=main.py"
set "tempfile=temp.py"
(for /f "delims=" %%i in (%textfile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:if not torch.cuda.is_available(): return 'libsbitsandbytes_cpu.so', None, None, None, None=if torch.cuda.is_available(): return 'libbitsandbytes_cuda116.dll', None, None, None, None!"
    set "line=!line:ct.cdll.LoadLibrary(binary_path)=ct.cdll.LoadLibrary(str(binary_path))!"
    echo(!line!
    endlocal
))>"%tempfile%"
del %textfile%
rename %tempfile%  %textfile%

pause
