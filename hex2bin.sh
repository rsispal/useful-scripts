#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <input_file> <output_file> <format>"
  echo "  <format>: raw or formatted"
  exit 1
fi

input_file=$1
output_file=$2
format=$3

if [ ! -f "$input_file" ]; then
  echo "Error: Input file not found: $input_file"
  exit 1
fi

if [ "$format" != "raw" ] && [ "$format" != "formatted" ]; then
  echo "Error: Invalid format. Use 'raw' or 'formatted'."
  exit 1
fi

echo "Converting $input_file to binary..."

if [ "$format" == "raw" ]; then
  xxd -r -p "$input_file" > "$output_file"
else
  sed 's/0x//g; s/,//g' "$input_file" | xxd -r -p > "$output_file"
fi

echo "Conversion complete. Binary output saved to $output_file"
