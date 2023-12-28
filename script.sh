#!/bin/bash

# Function to display help manual
display_manual() {
    echo "internsctl - Custom Linux Command v0.1.0"
    echo "Usage: internsctl [command] [options]"
    echo
    echo "Commands:"
    echo "  cpu getinfo        Display CPU information"
    echo "  memory getinfo     Display memory information"
    echo "  user create        Create a new user"
    echo "  user list          List all regular users"
    echo "  user list --sudo-only  List users with sudo permissions"
    echo "  file getinfo       Get information about a file"
    echo
    echo "Options:"
    echo "  --help             Display this help message"
    echo "  --version          Display version information"
    echo "  --size, -s         Print file size"
    echo "  --permissions, -p  Print file permissions"
    echo "  --owner, -o        Print file owner"
    echo "  --last-modified, -m Print last modified time"
}

# Function to display version
display_version() {
    echo "internsctl v0.1.0"
}

# Function to get CPU information
get_cpu_info() {
    lscpu
}

# Function to get memory information
get_memory_info() {
    free
}

# Function to create a new user
create_user() {
    if [ -z "$1" ]; then
        echo "Error: Missing username. Usage: internsctl user create <username>"
        exit 1
    fi

    sudo useradd -m "$1"
    echo "User $1 created successfully."
}

# Function to list all regular users or users with sudo permissions
list_users() {
    if [ "$1" == "--sudo-only" ]; then
        getent passwd {1000..60000} | cut -d: -f1,3 | awk -F, '$2 == "0"'
    else
        getent passwd {1000..60000} | cut -d: -f1,3 | awk -F, '$2 != "0"'
    fi
}

# Function to get file information
get_file_info() {
    local file="$1"

    if [ ! -e "$file" ]; then
        echo "Error: File '$file' not found."
        exit 1
    fi

    local size_option=false
    local permissions_option=false
    local owner_option=false
    local last_modified_option=false

    while [ $# -gt 1 ]; do
        case "$2" in
            --size | -s) size_option=true ;;
            --permissions | -p) permissions_option=true ;;
            --owner | -o) owner_option=true ;;
            --last-modified | -m) last_modified_option=true ;;
            *) echo "Invalid option: $2"; exit 1 ;;
        esac
        shift
    done

    local stat_output=$(stat --format="%A %U %s %y" "$file")

    if [ "$size_option" == true ]; then
        echo $(echo "$stat_output" | awk '{print $3}')
    elif [ "$permissions_option" == true ]; then
        echo $(echo "$stat_output" | awk '{print $1}')
    elif [ "$owner_option" == true ]; then
        echo $(echo "$stat_output" | awk '{print $2}')
    elif [ "$last_modified_option" == true ]; then
        echo $(echo "$stat_output" | awk '{print $4}')
    else
        echo "File: $file"
        echo "Access: $stat_output"
        echo "Size(B): $(echo "$stat_output" | awk '{print $3}')"
        echo "Owner: $(echo "$stat_output" | awk '{print $2}')"
        echo "Modify: $(echo "$stat_output" | awk '{print $4, $5}')"
    fi
}

# Main script logic
case "$1" in
    cpu) get_cpu_info ;;
    memory) get_memory_info ;;
    user) 
        case "$2" in
            create) create_user "$3" ;;
            list) list_users "$3" ;;
            *) echo "Invalid user command: $2"; exit 1 ;;
        esac
        ;;
    file) get_file_info "$2" "${@:3}" ;;
    --help) display_manual ;;
    --version) display_version ;;
    *) echo "Invalid command: $1"; exit 1 ;;
esac
