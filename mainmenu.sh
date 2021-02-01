#!/usr/bin/bash
source "group_functions.sh"
source "user_functions.sh"

function login_sys
{
PS3='Choose a number: '
select op in 'Create Group' 'Remove Group' 'Create User' 'Remove User' 'Change User Password' 'Login' 'Exit'
do
case $op in
"Create Group")
create_g
;;
"Remove Group")
remove_g
;;
"Create User")
create_u
;;
"Remove User")
remove_u
;;
"Change User Password")
change_pass
;;
"Login")
testlogin
;;
"Exit")
break
;;
*)
echo "Invalid choice! Choose another option."
esac
done
}
login_sys
