#!/usr/bin/env bash
dt=$(date '+%d-%m-%y')
echo "Uploading started at $(date -Iseconds)" >> /opt/zm/log/upload-$dt.log
if [[ $(gdrive files list --skip-header --field-separator " "|grep folder| cut -d" " -f2) ==  $dt ]]; then
        dir=$(gdrive files list --skip-header --field-separator " "|grep folder|grep $dt| cut -d" " -f1)
else
        dir=$(gdrive files mkdir $dt --print-only-id)
fi
for i in `find /zm-store/ -type f -name "*.mp4" -mmin +20`;
do
        gdrive files upload --parent $dir $i && rm $i
done
echo "Done at $(date -Iseconds)" >> /opt/zm/log/upload-$dt.log
