#!/bin/bash
set -x
if [ $# -gt 1 ]
then
    for USER in "$@"
    do
       echo $USER
       EXISTING_USER=$(cat /etc/passwd | grep -i -w $USER | cut -d ":" -f1)
       if [ "$EXISTING_USER" = "$USER" ]
       then
           echo "USER $USER already exists"
       else
           if [ ${USER} =~ ^[a-zA-Z]+$ ]
           then
               echo "Invalid username $USER, Username must start with an alphabet and can contain only alphanumeric characters"
               continue
           fi
           sudo useradd -m $USER -s /bin/bash
           SPECIAL_CHARACTERS='!@#$%^&*()_+{}|:<>?-=[];,./'
           SPEC=$(echo ${SPECIAL_CHARACTERS} | fold -w1 | shuf | head -n1)
           PASSWORD=devopswithsabir@${RANDOM}${SPEC}
           echo "$USER:$PASSWORD" | sudo chpasswd
           passwd -e $USER
           echo "USER $USER added successfully, Password is $PASSWORD"
       fi
    done
else
    echo "Invalid number of arguments"
    exit 1
fi

