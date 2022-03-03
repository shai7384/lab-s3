# data from the Instance Metadata service
#!/bin/bash
FILE=metadata.txt
if test -f "$FILE"; then
    echo "$FILE exists. hence remove"
rm metadata.txt
else
touch metadata.txt
fi
curl http://169.254.169.254/latest/meta-data/hostname > metadata.txt
curl http://169.254.169.254/latest/meta-data/iam/info >> metadata.txt
curl http://169.254.169.254/latest/meta-data/security-groups >> metadata.txt
