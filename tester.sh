#!/bin/bash
#directory where file and tests are
dirpath="/home/lena/Documents/Folder"
#lang options: "cpp", "java"
lang="java"
#file to compile name
file="source.java"
#executable file  name
execname="Source"
#input extension
inp="in"
#output extension
ext="out"
#---------------------------------------------
cd $dirpath
temp=tests/temp.temp
last_time=$(stat -c %y $file)
if [ $lang = "cpp" ]
then
#CPP------------------------------------------
while true 
do
now_time=$(stat -c %y $file)
if [ "$last_time" != "$now_time" ]
then
	if g++ -o $execname $file
	then
	echo -e "\e[42m$now_time $file compiled\e[0m"
	all=0
	accepted=0
	failed=0
	for tescik in tests/*.in
	do
		out=${tescik%$inp}
		out=$out$ext
		./$execname < $tescik > $temp
		czy=0;
		all=$(($all+1))
		diff --ignore-trailing-space $out $temp > /dev/null && czy=1;
		if [ $czy -eq 1 ]
		then
			accepted=$(($accepted+1))
			echo -e "$now_time \e[32m\e[1m\e[4m$tescik\e[0m" "\e[32m\e[1mpassed!\e[0m"
		else
			failed=$(($failed+1))
			echo -e "$now_time \e[31m\e[1m\e[4m$tescik\e[0m" "\e[31m\e[1mfailed!\e[0m"
			echo -e "\e[34mINPUT\e[0m"
			echo -e "\e[34m$(<$tescik)\e[0m"
			echo -e "\e[32mOUTPUT\e[0m"
			echo -e "\e[32m$(<$temp)\e[0m"
			echo -e "\e[31mRESULT\e[0m"		
			echo -e "\e[31m$(<$out)\e[0m"
		fi	
	done
	echo -e "\e[34mSUMMARY---------------------\e[0m"
	if [ $accepted -eq $all ]
	then
		echo -e "\e[32m\e[1mAll tests passed!\e[0m"
	else
		echo -e "\e[32m\e[1m$accepted tests passed!\e[0m"
		echo -e "\e[31m\e[1m$failed tests failed!\e[0m"
	fi
	echo -e "\e[34m----------------------------\e[0m"
	else
	echo -e "\e[41m$now_time $file compilation FAILED\e[0m"
	fi
	last_time=$now_time
fi
sleep 2
done
#JAVA-----------------------------------------
else
while true 
do
now_time=$(stat -c %y $file)
if [ "$last_time" != "$now_time" ]
then
	if javac $file
	then
	echo -e "\e[42m$now_time $file compiled\e[0m"
	all=0
	accepted=0
	failed=0
	for tescik in tests/*.in
	do
		out=${tescik%$inp}
		out=$out$ext
		java $execname < $tescik > $temp
		czy=0;
		all=$(($all+1))
		diff --ignore-trailing-space $out $temp > /dev/null && czy=1;
		if [ $czy -eq 1 ]
		then
			accepted=$(($accepted+1))
			echo -e "$now_time \e[32m\e[1m\e[4m$tescik\e[0m" "\e[32m\e[1mpassed!\e[0m"
		else
			failed=$(($failed+1))
			echo -e "$now_time \e[31m\e[1m\e[4m$tescik\e[0m" "\e[31m\e[1mfailed!\e[0m"
			echo -e "\e[34mINPUT\e[0m"
			echo -e "\e[34m$(<$tescik)\e[0m"
			echo -e "\e[32mOUTPUT\e[0m"
			echo -e "\e[32m$(<$temp)\e[0m"
			echo -e "\e[31mRESULT\e[0m"		
			echo -e "\e[31m$(<$out)\e[0m"
		fi	
	done
	echo -e "\e[34mSUMMARY---------------------\e[0m"
	if [ $accepted -eq $all ]
	then
		echo -e "\e[32m\e[1mAll tests passed!\e[0m"
	else
		echo -e "\e[32m\e[1m$accepted tests passed!\e[0m"
		echo -e "\e[31m\e[1m$failed tests failed!\e[0m"
	fi
	echo -e "\e[34m----------------------------\e[0m"
	else
	echo -e "\e[41m$now_time $file compilation FAILED\e[0m"
	fi
	last_time=$now_time
fi
sleep 2
done
fi
