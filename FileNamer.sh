#!/bin/bash

# Function to print script usage instructions
usage() {
    echo "Usage: $0 -id <input_directory> -iext <input_extension> -oext <output_extension> [-od <output_directory>] [-help <argument>]"
    echo "Description:"
    echo "This script will rename files in the input directory with the specified input extension to have the output extension."
    echo "If the output directory is provided, the script will save the converted files there; otherwise, it will mutate the input files."
    echo "Arguments:"
    echo "-id    : Input file directory (where the files are located that you want to convert)."
    echo "-iext  : Input file extension to look for (without a dot; the script will automatically handle this)."
    echo "-oext  : Output file extension (without a dot; the script will automatically handle this)."
    echo "-od    : (Optional) File directory for the output of converted files (when provided, it will not mutate the input files)."
    echo "-help  : (Optional) Get help for a specific argument. Use -help followed by an argument (e.g., -help -id) to get details for that argument."
    exit 1
}

# Function to print help for a specific argument
argument_help() {
    case $1 in
        -id)
            echo "Argument -id:"
            echo "Input file directory where the files are located that you want to convert."
            ;;
        -iext)
            echo "Argument -iext:"
            echo "Input file extension to look for. Do not include the dot (e.g., 'html', not '.html')."
            ;;
        -oext)
            echo "Argument -oext:"
            echo "Output file extension to use for the converted files. Do not include the dot (e.g., 'pdf', not '.pdf')."
            ;;
        -od)
            echo "Argument -od:"
            echo "Optional. File directory for the output of converted files."
            echo "When provided, the script will save the converted files in this directory, and it will not modify the input files."
            echo "If not provided, the script will rename the files in the input directory directly."
            ;;
        -help)
            echo "Argument -help:"
            echo "Optional. Get help for a specific argument."
            echo "Use -help followed by an argument (e.g., -help -id) to get details for that argument."
            ;;
        *)
            echo "Invalid argument. Use -help to see the available arguments."
            ;;
    esac
    exit 1
}

# Parse input arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -id)
            input_directory="$2"
            shift
            shift
            ;;
        -iext)
            input_extension="$2"
            shift
            shift
            ;;
        -oext)
            output_extension="$2"
            shift
            shift
            ;;
        -od)
            output_directory="$2"
            shift
            shift
            ;;
        -help)
            argument_help "$2"
            ;;
        *)
            usage
            ;;
    esac
done

# Check if the user asked for help
if [[ "$1" == "-help" ]]; then
    usage
fi

# Check if required input arguments are provided
if [[ -z $input_directory ]] || [[ -z $input_extension ]] || [[ -z $output_extension ]]; then
    usage
fi

# Ensure input and output extensions start with a dot
input_extension=$(echo "$input_extension" | sed 's/^\.*//')
output_extension=$(echo "$output_extension" | sed 's/^\.*//')

# If output directory is not provided, use the input directory for output
if [[ -z $output_directory ]]; then
    output_directory="$input_directory"
fi

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Process each file in the input directory
for file in "$input_directory"/*."$input_extension"; do
    if [[ -f $file ]]; then
        # Get the file name without extension
        filename=$(basename "$file" ".$input_extension")
        # Rename the file with the new extension and move it to the output directory
        mv "$file" "$output_directory/$filename.$output_extension"
    fi
done

echo "File extension replacement completed!"
