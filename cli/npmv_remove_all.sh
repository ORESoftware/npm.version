#!/usr/bin/env bash

set -e;
rm -rf "$npmvv";
mkdir -p "$npmvv";
echo "Total number of installations: $(ls "$npmvv" | wc -l)"
