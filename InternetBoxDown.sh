#!/bin/sh
test_Internet()
{
    #test if Speedtest program is installed
    #command -v speedtest >/dev/null 2>&1 || { echo >&2 "SpeedTest CLI is required for metrics but is not installed, or not part of ENV path.\nContinue with out metrics? (y/N)."; cont = read cont ; }
    # if not prompt if user wants to continue using ping only.
    # if [$cont == 'y']
    # then
    #     echo "Continuing with ping data only."
    # else
    #     exit
    # fi
    echo "TimeStamp::Download Speed"
    FailCount=0
    while true
    do
        ping_Addr
        
        if [ $? -eq 0 ] #Redirects output to null
            then 
            speedtest --simple
            
            #log()

        else 
            FailCount=$FailCount+1
            ping_Addr
            still_down=$?
            while [ $still_down -eq 1 ]
            do 
                start=date
                sleep 5m

                ping_Addr
                still_down=$?
            done
            end=date
           # log("Internet outage from ${start} to ${end}")

        fi
        sleep 5m
    done

}

log()
{
    touch results.txt
    echo "$1" > results.txt
}

ping_Addr()
{
    ping -c1 www.google.com 2>/dev/null 1>&2
    return $?
}


# At Start
#variables
test_Internet
