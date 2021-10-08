export SRC_FILES_LIST=tagged_files.txt
rm -f $SRC_FILES_LIST
touch $SRC_FILES_LIST
find . -path "./*Cpu*/src/*" \( -iname "*.cpp" -o -iname "*.h" -o -iname "*.c" \) > $SRC_FILES_LIST
find . -path "./*shared*/app/*" \( -iname "*.cpp" -o -iname "*.h" -o -iname "*.c" \) >> $SRC_FILES_LIST
find . -path "./test_automation/*" \( -iname "*.py" -o -iname "*.proto" \) >> $SRC_FILES_LIST
find . -path "./tools/*" -iname "*.py" >> $SRC_FILES_LIST
ctags -L $SRC_FILES_LIST
