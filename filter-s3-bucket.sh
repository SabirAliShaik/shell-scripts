#!/bin/bash
set -x
aws s3 ls | cut -d " " -f 3 | grep -E www[.]
echo "script is completed"