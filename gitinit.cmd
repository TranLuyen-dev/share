@ECHO OFF
set /p link=Nhap link github:
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin %link%
git push -u origin main
pause