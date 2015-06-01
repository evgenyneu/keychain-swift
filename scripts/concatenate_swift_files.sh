#!/bin/bash

#
#  Combines *.swift files into a single file.
#
#  Usage
#  ------
#
#  ./combine_swift_files.sh source_dir destination_file [optional_header_text]
#

destination=$2
headermessage=$3

if [ "$#" -lt 2 ]
then
  echo "\nUsage:\n"
  echo "   ./combine_swift_files.sh source_dir destination_file [optional_header_text]\n"
  exit 1
fi

# Create empty destination file
echo > "$destination";
text=""
destination_filename=$(basename "$destination")

for swift in `find $1 ! -name "$destination_filename" -name "*.swift"`;
do
  filename=$(basename "$swift")

  text="$text\n// ----------------------------";
  text="$text\n//";
  text="$text\n// ${filename}";
  text="$text\n//";
  text="$text\n// ----------------------------\n\n";

  text="$text$(cat "${swift}";)\n\n";

  echo "Combining $swift";
done;

# Add header message
if [ -n "$headermessage" ]
then
  text="$headermessage\n\n$text"
fi

# Write to destination file
echo -e "$text" > "$destination"

echo -e "\nSwift files combined into $destination"


