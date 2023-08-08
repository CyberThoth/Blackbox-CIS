#Author : Ashish
#check to see if script is being run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

##################################################
function audit_WithOutput () {

	if [[ $2 ]]; then
	    echo "$1,Complaince : Yes " >> $filename
	    echo -e "\n $:">>$filename
	else
	    echo "$1,Complaince : NO" >> $filename
	fi
}
function audit_WithNoOutput () {

	if [[ $2 ]]; then
		echo "$1,Complaince : NO" >> $filename
		echo -e "\n $2:">>$filename
	else
		echo "$1,Complaince : Yes" >> $filename
	fi
}
function audit_Exception () {
	echo "$1,exception" >> $filename
}

#####################################################
#get hostname
host=`hostname`
#get current date
dateTime=`date +"%m%d%y-%H%M"`
#create filename
filename="CIS_SLES-"$host"-"$dateTime".csv"
#create new file
touch $filename
#####################################################

#1 Install Updates, Patches and Additional Security Software 

#1.1 Disable Unused File System

echo "1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Scored)"
auditStep="1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Scored)"
auditCmd=`modprobe -n -v cramfs lsmod|grep -c cramfs`
audit_WithNoOutput "$auditStep" "$auditCmd"

echo "1.1.1.2 Ensure mounting of freevxfs filesystems is disabled (Scored)"
auditStep="1.1.1.2 Ensure mounting of freevxfs filesystems is disabled (Scored)"
auditCmd=`modprobe -n -v freevxfs lsmod | grep -c freevxfs`
audit_WithNoOutput "$auditStep" "$auditCmd"

echo "1.1.1.3 Ensure mounting of jffs2 filesystems is disabled (Scored)"
a
