#!/bin/sh -l

. ./html_writer.sh

echo "Starting html_writer_tests"

echo "Backing up index.html"
# Backup the original file
cp ./tests/index.html ./tests/index.html.bak

update_html_version "./tests/index.html" "<a href='/test'>test</a>"

# Check if the file was changed as expected
grep -q "<a href='/test'>test</a>" ./tests/index.html
if [ $? -eq 0 ]; then
    echo "File was changed as expected"
    cat ./tests/index.html
else
    echo "File was not changed as expected"
    # Restore the original file
    cp ./tests/index.html.bak ./tests/index.html
    exit 1
fi

# Restore the original file
cp ./tests/index.html.bak ./tests/index.html
rm ./tests/index.html.bak

echo "Finished html_writer_tests"
