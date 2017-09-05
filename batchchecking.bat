rem git config credential.helper store

set DATESTAMP=%DATE:~10,4%_%DATE:~4,2%_%DATE:~7,2%
set TIMESTAMP=%TIME:~0,2%_%TIME:~3,2%_%TIME:~6,2%
set DATEANDTIME=%DATESTAMP%_%TIMESTAMP%
cd applied-regression-with-R 
git add --all .
git commit -m "%DATEANDTIME%"
git push
cd ../
cd applied-time-series-analysis-with-R 
git add --all .
git commit -m "%DATEANDTIME%"
git push
cd ../
cd r-scratchpad-repo 
git add --all .
git commit -m "%DATEANDTIME%"
git push
cd ../
cd intro-statistical-learning 
git add --all .
git commit -m "%DATEANDTIME%"
git push
cd ../