#!/bin/bash

input=$@

if [ $# -eq 0 ]; then 

  echo "getmac: try 'getmac --help' or 'getmac help' for more information"
  echo "                             OR"
  echo "        try 'getmac <<MACADDRESS>> (e.g.) 'getmac 60:f8:1d:c0:3a:94'"

elif [[ $input =~ "help" ]]; then 
  
  #print the help.txt 
  echo "$(cat /opt/software/scripts/getmac/help.txt)"
  exit;

else

  #Get the macaddress 
  inputarray=($input)
  mname=${inputarray[0]}
  passkey=${inputarray[1]}

  #Encrypted Password is stored in cloud. 

  cd /opt/software/scripts/getmac
  wget --timestamping --quiet https://storage.googleapis.com/getmac/symmetric_secrets_apikey.enc
  
  API_KEY_OUT=$(openssl aes-256-cbc -d -a -in symmetric_secrets_apikey.enc -out symmetric_secrets_apikey.dec -k $passkey)
  API_KEY=$(cat /opt/software/scripts/getmac/symmetric_secrets_apikey.dec) 

  echo "*********************************************************"
  echo -e "MAC Address     :: $mname"
  echo -e "Vendor Name     :: \c"
  curl -H "X-Authentication-Token: $API_KEY" "https://api.macaddress.io/v1?output=vendor&search=$mname"
  echo ""
  echo "*********************************************************"

fi

