#!/bin/bash
remote_hosted= 
if [ "$remote_hosted" = "y" -o "$remote_hosted" = "Y" ]; then
      echo "Variable is NOT empty"  
else
      echo "Variable is empty" 
fi

