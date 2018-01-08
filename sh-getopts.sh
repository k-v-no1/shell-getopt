#! /bin/bash

USAGE="Usage: `basename $0` [-h] [-k server] [-n -g groupname] [-d describe] \n
\t -h: Help \n
\t -k: Kafka server\n
\t -n: this option should be used along with -g\n
\t -g: Consumer group name\n
\t -d: describe
"

describe() 
{
    if [ $kafkaServer = "broker1" ]; then
        if [ $groupName = "grp1" ] && [ $nExists = "true" ]; then
        # GROUP, TOPIC, PARTITION, CURRENT OFFSET, LOG END OFFSET, LAG, OWNER  
            echo "consumer-group, topic_gt, 0, 542477, 542477, 10, owner"
            echo "consumer-group, topic_pt, 1, 542477, 542477, 20, owner"
            echo "consumer-group, topic1_gt, 0, 542477, 542477, 30, owner"
            echo "consumer-group, topic1_pt, 1, 542477, 542477, 40, owner"
        fi
    fi
}

# Parse command line options with "getopts"
# the colon after the character indicates that the options must be supplied with an argument

# e.g. there is no colon after 'h' char so "sh-getopts.sh -h" will work without any issue
# and "sh-getopts.sh -k" doesn't work as -k option is expecting some argument to be passed 
# because of the colon present after it

while getopts hk:ng:d OPT; do
    case "$OPT" in
        h)
            echo -e ${USAGE}
            exit 0
            ;;
        k)
            kafkaServer=${OPTARG}
            ;;
        n)
            nExists="true"
            ;;
        g)
            groupName=${OPTARG}
            ;;
        d)
            describe    # calling describe function
            ;;
        \?)
            # getopts issues an error message
            echo -e ${USAGE} >&2
            exit 1
            ;;
    esac
done
