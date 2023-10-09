@ECHO OFF
TITLE Flash Firmware ESP32 By Nhox
set path_file=0
:add_com
reg query HKLM\HARDWARE\DEVICEMAP\SERIALCOMM
set /p COM= " Nhap COM: "

IF %path_file% EQU 0 (
set path_file=1
:add_file
set /p file= " File Firmware: "
set /p bootloader= " File Bootloader: "
set /p partitions= " File Partitions: "
set /p memory= " Flash Size: "
)

cls

:in_cmd
echo  Dang chon COM%COM%
echo  File Firmware: %file% 
echo  File Bootloader: %bootloader% 
echo  File Partitions: %partitions% 
echo  Flash Size: %memory% 
echo  1. Upload Firmware
echo  2. Read MAC and Dectect Flash
echo  3. Exit

set /p cmd= " Enter CMD and press Enter: "

IF %cmd% EQU 1 (
cls
GOTO flash
)

IF %cmd% EQU 2 (
cls
GOTO mac_flash
)

IF %cmd% EQU 3 exit

:mac_flash
esptool.exe --chip esp32 --port COM%COM% --baud 921600 flash_id
GOTO in_cmd

:flash
esptool.exe --chip esp32 --port COM%COM% --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size %memory% 0x1000 %bootloader% 0x8000 %partitions% 0xe000 boot_app0.bin 0x10000 %file%
GOTO in_cmd
