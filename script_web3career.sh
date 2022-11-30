#!/bin/bash

#scrapping website
curl -o tempo.txt https://web3.career/dev+entry-level-jobs  

#regex to catch the last job offer and the hiring organization
grep -o -P -m1 '(?<="title":).*(?=,)' tempo.txt>result.txt 

#using sed to get the 7th line after the match to get the organization name
sed -n '/"title": /{ n; n; n;n;n;n;n; p }' tempo.txt>result_organization.txt

if cmp -s -- result.txt tempo_result.txt; then
    :
  else

  #clone the resumt.txt to tempo_result.txt to keep it in memory
    cp result.txt tempo_result.txt

    # creation of the message 
    job_offer=$(head -n 1 result.txt)
    organization=$(head -n 1 result_organization.txt)
    NEWLINE=$'\n'
    render="New job offer on web3.career :${NEWLINE}${job_offer}${NEWLINE}Organization${organization}"

    #sending the message with telegram api
    curl -s --data "text=$render" --data "chat_id=-1001811074866," 'https://api.telegram.org/bot5659403567:AAEsW1aNBOSf32F6w_xjQbJGPw3mS-iWDb8/sendMessage' > /dev/null

  fi