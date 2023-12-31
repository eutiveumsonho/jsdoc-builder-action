#!/bin/sh -l

. ./index_manager.sh

echo "Starting index_manager_tests"

echo "Starting find_first_html_file tests"
echo "Finding first html file in root folder should output /templates/index.html"
output_find_test=$(find_first_html_file ".")
echo "$output_find_test"
case "$output_find_test" in
  *"/templates/index.html"*)
    echo "Test passed"
    ;;
  *)
    echo "Test failed"
    ;;
esac

echo "Starting create_index_html tests"
echo "Creating index.html when it doesn't exist, in ./tests"
output_create_test=$(create_index_html "./tests" "templates/index.html")
echo "$output_create_test"
case "$output_create_test" in
  *"index.html created in"*)
    echo "Test passed"
    cat ./tests/index.html
    ;;
  *)
    echo "Test failed"
    ;;
esac
rm ./tests/index.html

echo "Skipping index.html creation when it already exists, in ./templates"
output_skip_test=$(create_index_html "./templates" "templates/index.html")
echo "$output_skip_test"
case "$output_skip_test" in
  *"index.html exists in"*)
    echo "Test passed"
    ;;
  *)
    echo "Test failed"
    ;;
esac
echo "Finished create_index_html tests"

echo "Starting update_index_html tests"
echo "Backing up index.html"
# Backup the original file
cp ./templates/index.html ./templates/index.html.bak

update_index_html "./templates/index.html" "<a href='/test'>test</a>"

# Check if the file was changed as expected
grep -q "<a href='/test'>test</a>" ./templates/index.html
if [ $? -eq 0 ]; then
    echo "File was changed as expected"
    cat ./templates/index.html
else
    echo "File was not changed as expected"
    # Restore the original file
    cp ./templates/index.html.bak ./templates/index.html
    rm ./templates/index.html.bak
    exit 1
fi

update_index_html "./templates/index.html" "<a href='/test2'>test2</a>"

# Check if the file was changed as expected
grep -q "<a href='/test2'>test2</a>" ./templates/index.html
if [ $? -eq 0 ]; then
    echo "File was changed as expected"
    cat ./templates/index.html
else
    echo "File was not changed as expected"
    # Restore the original file
    cp ./templates/index.html.bak ./templates/index.html
    rm ./templates/index.html.bak
    exit 1
fi

duplicate_index_entry_output=$(update_index_html "./templates/index.html" "<a href='/test'>test</a>")
echo "$duplicate_index_entry_output"
case "$duplicate_index_entry_output" in
  *"File already contains"*)
    echo "Test passed"
    ;;
  *)
    echo "Test failed"
    ;;
esac

# Restore the original file
cp ./templates/index.html.bak ./templates/index.html
rm ./templates/index.html.bak
echo "Finished update_index_html tests"

echo "Finished index_manager"
