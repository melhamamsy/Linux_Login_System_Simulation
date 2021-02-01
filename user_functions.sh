#!/usr/bin/bash
if [[ ! -f pass_u ]]
        then
	touch pass_u
fi

if [[ ! -f count_u ]]
        then
        touch count_u
	echo '1000'>$count_u
fi


function create_u {
	uid_u=$(($(cat /root/project/count_u)+1))
	
	read -p "Enter username: " usr_u
        if [[ -z $(\grep -w ^$usr_u pass_u) ]]
        then
		read -p "Enter groupname: " grp_u
                if [[ -n $(\grep -w  ^$grp_u pass_g) ]]
                then
			gid_u=$(grep -w  ^$grp_u pass_g | cut -d: -f2)
			read -p "Enter password: " pswd_u
                        echo $usr_u':'$pswd_u':'$uid_u':'$grp_u':'$gid_u>> pass_u
			echo $uid_u> count_u
			echo "User Created Successfully"
                else
                        echo "Group does not exist, Please add the group first."

                fi
        else
                echo "User already exists!"
        fi
}


function remove_u {
        read -p "Enter username: " usr_u
        
	if [[ -n $(\grep -w  ^$usr_u pass_u) ]]
        then
		grep -w -v ^$usr_u pass_u>tmp
		\mv tmp pass_u
		echo "User $usr_u has been successfully deleted"
        else
		echo "User does not exist!"
        fi
}



function change_pass {
	read -p "Enter username: " usr_u


        if [[ -n $(\grep -w ^$usr_u pass_u) ]]
        then
		read -p "Enter old password: " pass_old
		if [[ $(grep -w  ^$usr_u pass_u | cut -d: -f2) == $pass_old ]]
		then
			read -p "Enter new password: " pass_new
                	sed -i "/^$usr_u:/ s/:$pass_old:/:$pass_new:/g" pass_u
			echo "User $usr_u password has been updated"
		else
			echo "Old password entered is wrong!"
		fi
        else
                echo "User does not exist!"
        fi
}

