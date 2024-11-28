#!/bin/bash
# Program:
# Program Name: doAll.sh
# Program location: Linux_Week5_Lab/
# This Program are split into four steps:

# step1: record people who didn't hand in files into missing_list

# step2: record those hand in the incorrect file format into wrong_list

# step3: sorting the files that are in the compressed_files into zip,rar,tar.gz,and unknown respectiely

# step4: uncompress all the files in zip,rar,and tar.gz

# show the program info and the detail of each step
echo ""
echo "Program:"
echo ""
echo "  Name: doAll.sh"
echo "  location: Linux_Week5_Lab/"
echo ""
echo "Every step's purpose:"
echo ""
echo "  Step1: record those didn't hand in files into missing_list"
echo "  Step2: record those hand in the incorrect file format into wrong_list"
echo "  Step3: sorting the files into zip,rar,tar.gz,and unknown respectiely"
echo "  Step4: uncompress all the files in zip,rar,and tar.gz"

# stop for 10 sec
sleep 10s

# before start
echo ""
echo "before start:"
echo "in Linux_Week5_Lab:"
echo "  "$(ls)
echo ""
tree -L 1
sleep 5s

# step1
# show the current stage
echo ""
echo "Step1 now"

# current location: Linux_Week5_Lab/

# show current path
echo "current path: "$(pwd)
sleep 5s

# create missing_list under Linux_Week5_Lab, if it hasn't been created yet
touch missing_list

# create student_id_temp, and let it be empty every time run the program
touch student_id_temp
echo -n "" > student_id_temp

# create compressed_files_temp, and let it be empty every time run the program
touch compressed_files_temp
echo -n "" > compressed_files_temp

# create temp, and let it be empty every time run the program
touch temp
echo -n "" > temp

# copy the content of student_id to student_id_temp
cp student_id student_id_temp

#declare variables
declare fname
declare route
declare -i index=1

cd ./compressed_files

# strore ls result under compressed_files/ into variable route
route=$(ls)

# read every file in compressed_files/ ,and store their filenames into compress# ed_files_temp
for file in *
do
        fname=$(echo ${route} | cut -d ' ' -f ${index})

        index=$((index+1))

        echo ${fname:0:9} >> .././compressed_files_temp
done

# back to Linux_Week5_Lab/
cd ../

# sort the file
sort -o student_id_temp student_id_temp
sort -o compressed_files_temp compressed_files_temp

# record people who didn't hand in files into temp
echo $(comm -23 student_id_temp compressed_files_temp) > temp

# replace " " with "\n" in temp, and then write the result into missing_list
cat temp | tr " " "\n" > missing_list

# remove student_id_temp, compressed_files_temp, and temp
rm -f student_id_temp
rm -f compressed_files_temp
rm -f temp

# show message
echo ""
echo "step1 is done"
echo "Those who didn't hand in files have all been record into missing_list"
echo""
tree -L 1
sleep 5s

# step2
# show the current stage
echo ""
echo "Step2 now"

#current location: Linux_Week5_Lab/

# show current path 
echo "current path: "$(pwd)
sleep 5s

# if wrong_list does not exist, then create one, else update the time
touch wrong_list

# make the content of wrong_list be empty before start
echo -n "" > wrong_list

# change route
cd ./compressed_files

# declare a string variable
declare format

# check each file's format, if it isn't in rar,zip, or tar.gz format, then reco#rd into wrong_list
for file in *
do
        format=${file}

        if [ "${format:9}" == ".zip" ]; then
                :
        elif [ "${format:9}" == ".rar" ]; then
                :
        elif [ "${format:9}" == ".tar.gz" ]; then
                :
        else
                echo ${format:0:9} >> .././wrong_list
        fi
done

# show message
echo "" 
echo "Step2 is done"
echo "Those hand in wrong file format have already been record into wrong_list"
cd ../
echo ""
tree -L 1
cd ./compressed_files
sleep  5s

# step3
# show the current stage
echo ""
echo "Step3 now"

# current locate: Linux_Week5_Lab/compressed_files/

# show current path:
echo "current path: "$(pwd)
sleep 5s

# to see whether the four directory are created or not.If not, then create one
test -d zip || mkdir zip

test -d rar || mkdir rar

test -d tar.gz || mkdir tar.gz

test -d unknown || mkdir unknown

declare str
# move the files that have .zip format into zip directory
for file in *
do
        str=${file}
        if [ "${str:0-4}" == ".zip" ]; then
                mv -f ${file} ./zip
        fi
done

# move the files that have .rar format into rar directory
for file in *
do
        str=${file}
        if [ "${str:0-4}" == ".rar" ]; then
                mv -f ${file} ./rar
        fi
done

# move the files that have .tar.gz format into tar.gz directory
for file in *
do
        str=${file}
        if [ "${str:0-7}" == ".tar.gz" ]; then
                mv -f ${file} ./tar.gz
        fi
done


# move the remain files into unknown directory
for file in *
do
        str=${file}
        if [ "${str}" == "zip" ]; then
                :
        elif [ "${str}" == "rar" ]; then
                :
        elif [ "${str}" == "tar.gz" ]; then
                :
        elif [ "${str}" == "unknown" ]; then
                :
        else
                mv -f ${file} ./unknown
        fi
done

# show the message
echo ""
echo "after sorting:"
echo "in compressed_files:"
echo "  "$(ls)
sleep 5s
echo ""
echo "Step 3 is done"
echo "The sorting process is done"
cd ../
echo ""
tree -L 2
cd ./compressed_files
sleep 5s

# step4
# show the current stage
echo ""
echo "Step4 now"

# current location: Linux_Week5_Lab/compressed_files/

# current path: 
echo "current path: "$(pwd)
sleep 5s

# uncompress process

# uncompress zip

cd ./zip

for file in *
do
        unzip ${file}
done

# uncompress rar

cd .././rar

for file in *
do
        unrar e ${file}
done

# uncompress tar.gz

cd .././tar.gz

for file in *
do
        tar zxvf ${file}
done

# show the message
echo ""
echo "Step 4 is done"
echo "Uncompress process are all done"
sleep 5s

#show the final message
echo ""
echo "All steps are done"
echo "Successfully execute the doAll.sh !!!"
sleep 5s

# back to the Linux_Week5_Lab
cd ../../

# show the tree of the directory of Linux_Week5_Lab
echo ""
echo "The final result:"
tree -L 2
