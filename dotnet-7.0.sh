#!/bin/bash 
if ! command -v sudo &> /dev/null
then
	echo "Sudo isnt Installed!"
	echo "Installing Sudo"
	if command=$(apt-get install sudo); then
    echo "Successfully Installed!"
    else
        if command=$(apt-get update --allow-releaseinfo-change) ; then
            echo "Successfully Changed the Release Info System was Outdated"
            echo "Upgrading Packages this can take a long time"
            if command=$(apt-get upgrade); then
            echo "Sucessfully Upgraded packages"
            else
            echo "Failed Upgrading Exiting"
            exit
            fi
            else
            echo "Fatal Error Exiting"
            exit
        fi
    fi
fi
echo "Found sudo installing DotNet 5.0"
if command=$(wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && sudo dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb); then 
    echo "Got Packages Succesfully"
else
    echo "Trying to handle the Exception"
    if command=$(apt-get update) ; then
        echo "Runned Apt Get Successfully"
    else 
        echo "Failed apt-get upgrade"
            if command=$(apt-get update --allow-releaseinfo-change) ; then
            echo "Successfully Changed the Release Info System was Outdated"
        else
            echo "Fatal Error Exiting"
            exit
        fi
    fi
        command=$(apt-get upgrade)
    if command=$(wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && sudo dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb);
    then echo "Fixed issue above got Packages Successfully!"
    else
     
        echo "Fatal Error count Fix Error Exiting" 
        exit
    fi
fi
echo "Installing SDK 1/3"
if command=$(sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-7.0); then
echo "Successfully Installed SDK!"
else
echo "Failed Installing SDK"
exit
fi
echo "Installing ASP Net Runtime 2/3"
if command=$(sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-7.0); then
echo "Successfully Installed ASP Net Runtime!"
else
echo "Failed installing Asp net runtime!"
exit
fi
echo "Installing Net Core Runtime 3/3"
if command=$(sudo apt-get install -y dotnet-runtime-7.0); then
echo "Successfully Installed Net Core Runtime!"
else
echo "Failed Installing dotnet Runtime!"
exit
fi
echo "Checking if the Install was Successfull"
if command=$(dotnet) ; then
echo "Successfully Installed NET 7.0!"
echo "Showing List of all Installed Versions below"
echo ""
echo command=$(dotnet --info)
else
echo "Failed Installing dotnet Runtime!"
exit
fi
exit