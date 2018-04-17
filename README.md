# April 2018 Technical Prompt 2

This script was created in a virtualized environment using Ubuntu 16.04.

Make script executable and run with sudo using the following commands:  

    chmod +x prompt2.sh  
    sudo ./prompt2.sh

In order to run these scripts, you will have to put them in a directory.  
Put php files into /var/www/html directory. Then,
    
    chmod 777 index.php
    chmod 777 webconfig.php 

To move them onto the webserver run the following commands:  

    git init  
    git add .  
    git commit -m “Test”

You want to then add a new remote. Use the this command in the directory your repository is stored at. You can do this with the following commands:
 
    git remote add origin admin@<Insert your server address here>:admin  
    git push --set-upstream origin master  
  
You will then have to enter a password. Enter the following: 

    empiredidnothingwrong  
  
You must go to the web server using a browser of your choice.  
