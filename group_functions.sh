#!/usr/bin/bash

if [[ ! -f count_g ]]
then
touch count_g
echo '0' >count_g
fi

if [[ ! -f pass_g ]]
then
touch pass_g
fi

function create_g
{
read -p "Enter New Group Name: " gname
gid=$(cat count_g)



if [[ -z $(cut -d: -f1 pass_g|grep -x ^$gname) ]]
then
echo $gname:$gid >> pass_g
echo "Group Created Successfully"
next_id=$(($gid+1))
echo $next_id > count_g
else
echo "Group Already Exists!"
fi
}


function remove_g
{
read -p "Enter Group Name: " gname
gid=$(cat pass_g | cut -d: -f2) 
if [[ -n $(cut -d: -f1 pass_g | grep -x ^$gname) ]]
then

	if [[ -n $(grep -w ":$gname:$gid$" pass_u) ]]
	then
		read -p "$gname has users; to delete group and its users press y. Any other key to cancel: " yn
		if [[ $yn == y ]]
		then
			grep -w -v ":$gname:$gid$" pass_u > tmp
			\mv tmp pass_u
			grep -w -v ^$gname pass_g>tmp
			\mv tmp pass_g
			echo "Group $gname Removed Successfully."
		else
			echo "Group $gname has not been removed."
		fi
	else
		grep -w -v ^$gname pass_g>tmp
                \mv tmp pass_g
                echo "Group $gname Removed Successfully."
	
	fi
else
	echo "Group Does not Exist!"
fi
}


function testlogin
{
u_name=

while [[ -z $u_name ]]
do
read -p "Enter username: " u_name
if [[ -n $(cut -d: -f1 pass_u | grep -x ^$u_name) ]]
then
u_pass=

while [[ -z $u_pass ]]
do
read -p "Enter password: " u_pass
if [[ $u_pass ==  $(grep -w ^$u_name pass_u | cut -d: -f2) ]]
then
echo "Login Successful."
else
echo "Wrong password! Try Again."
u_pass=
fi
done

else
echo "User does not exist! Try Again."
u_name=
fi
done
}





