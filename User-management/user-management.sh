#!/bin/bash

# Function to create a user
function create_user {
    read -p "Enter Username: " uname
    read -p "Enter Password: " password

    # Add user with home directory and password
    sudo useradd -m $uname -p $password
    echo "User $uname created successfully"
}

# Function to delete a user
function del_user {
    read -p "Enter username to be deleted: " uname
    sudo deluser $uname
    echo "User $uname deleted successfully"
}

# Function to create a group
function create_group {
    read -p "Enter group name: " groupname
    sudo groupadd $groupname
    echo "Group $groupname created successfully"
}

# Function to delete a group
function del_group {
    read -p "Enter group name to be deleted: " groupname
    sudo delgroup $groupname
    echo "Group $groupname deleted successfully"
}

# Function to add a user to a group
function add_user_to_group {
    read -p "Enter Username: " uname
    read -p "Enter Group name: " groupname
    sudo usermod -aG $groupname $uname
    echo "User $uname added to group $groupname successfully"
}

# Function to remove a user from a group
function remove_user_from_group {
    read -p "Enter Username: " uname
    read -p "Enter Group name: " groupname
    sudo gpasswd -d $uname $groupname
    echo "User $uname removed from group $groupname successfully"
}

# Function to change group ownership of a file
function change_file_group {
    read -p "Enter Filename: " filename
    read -p "Enter Group name: " groupname
    sudo chgrp $groupname $filename
    echo "Group ownership of $filename changed to $groupname"
}

# Function to set or change user password
function change_user_password {
    read -p "Enter Username: " uname
    sudo passwd $uname
    echo "Password for user $uname changed successfully"
}

# Function to handle errors
function handle_error {
    if [ $? -ne 0 ]; then
        echo "An error occurred. Please check your input and try again."
        exit 1
    fi
}

# Main script to call functions based on user input
case $1 in
    1)
    echo "Create User in progress"
    create_user
    handle_error
    ;;
    2)
    echo "Delete User in progress"
    del_user
    handle_error
    ;;
    3)
    echo "Create Group in progress"
    create_group
    handle_error
    ;;
    4)
    echo "Delete Group in progress"
    del_group
    handle_error
    ;;
    5)
    echo "Add User to Group in progress"
    add_user_to_group
    handle_error
    ;;
    6)
    echo "Remove User from Group in progress"
    remove_user_from_group
    handle_error
    ;;
    7)
    echo "Change File Group in progress"
    change_file_group
    handle_error
    ;;
    8)
    echo "Change User Password in progress"
    change_user_password
    handle_error
    ;;
    *)
    echo "Invalid option. Please use: 1 (create user), 2 (delete user), 3 (create group), 4 (delete group), 5 (add user to group), 6 (remove user from group), 7 (change file group), 8 (change user password)"
    ;;
esac
