#!/bin/bash
# These variables are used to apply different colors to the terminal output.
RED=$(tput setaf 1)       # Red
GREEN=$(tput setaf 2)     # Green
YELLOW=$(tput setaf 3)    # Yellow
BLUE=$(tput setaf 4)      # Blue
MAGENTA=$(tput setaf 5)   # Magenta
CYAN=$(tput setaf 6)      # Cyan
WHITE=$(tput setaf 7)     # White
RESET=$(tput sgr0)        # Reset colors to default
#Check if the logo.sh file exists
if [[ -f "logo.sh" ]]; then 
    chmod +x logo.sh && ./logo.sh
else
    echo -e "${RED}Warning: logo.sh not found! Skipping logo display.${RESET}"
fi


#Function to request path
get_file_path() {
    echo -n "${GREEN}Enter the path to access.log: ${RESET}"
    read file_path
    echo ""
}

# Verify the file exists
attempts=0
max_attempts=3

# Ask the user to get the path while checking if the file exists
while [[ $attempts -lt $max_attempts ]]; do
    get_file_path
    if [[ -f "$file_path" ]]; then
        echo -e "${GREEN}File exists. Proceeding...${RESET}\n"
        break
    else
        echo -e "${RED}Error: File not found!${RESET}\n"
        ((attempts++))
        if [[ $attempts -lt $max_attempts ]]; then
            echo -e "Please try again.\n"
        fi
    fi
done

# If the attempt fails 3 times
if [[ $attempts -ge $max_attempts ]]; then
    echo -e "${RED}Maximum attempts reached. Exiting.${RESET}\n"
    exit 1
fi

# Print options for the user
while true; do
echo -e "==========================================================================================\n"
echo -e "${GREEN}1) Display and count IP addresses${RESET}\n"
echo -e "${RED}2) Display and count requests${RESET}\n"
echo -e "${YELLOW}3) Display and count User Agents${RESET}\n"
echo -e "${CYAN}4) Display and count Referrers${RESET}\n"
echo -e "${MAGENTA}5) All${RESET}\n"
echo -e "${RED}99) Exit${RESET}\n"

#Wait to enter the number
echo -n "${GREEN}Enter the number: ${RESET}"
read choice
echo ""

display_and_count_ips() {
    echo -e "${RED}Displaying and counting IP addresses...${RESET}\n"
    echo " IP Counter "
    
    cat $file_path | cut -d " " -f 1 | sort | uniq -c | sort -n | awk -v green="$GREEN" -v blue="$BLUE" -v reset="$RESET" '
    {
        print green $1 reset " ====>>" blue $2 reset
    }'
}

display_and_count_requests() {
     echo -e "${YELLOW}Displaying and counting requests...${RESET}\n"
    
    cat $file_path | cut -d '"' -f 2 | sort | uniq -c | sort -n | awk -v green="$GREEN" -v blue="$BLUE" -v Magenta="$MAGENTA" -v reset="$RESET" '
    {
# 
        print green $1 reset " ====>>" Magenta $2 " " $3 " " $4 reset
    }'
}

display_and_count_user_agents() {
    echo -e  "${GREEN}Displaying and counting User Agents...${RESET}\n"
    cat $file_path | cut -d '"' -f 6 | grep -v "^-$" | grep -E "Mozilla|Chrome|Safari|Googlebot|Edge|Bingbot|Baidu"  | sort | uniq -c | sort -n | \
    awk -v green="$GREEN" -v red="$RED" -v magenta="$MAGENTA" -v reset="$RESET" '
    BEGIN { counter = 1 }  # Initialize counter
    {
        # Print the full User-Agent with a counter
        print green "[" counter "]" reset " ====>>" red $0 reset
        counter++  # Increment the counter
    }'
}

display_referrers() {
    echo -e "${BLUE}Displaying and counting Referrers...${RESET}\n"
    
    cat $file_path | cut -d '"' -f 4 | grep -v "-" | sort | uniq -c | sort -rn | awk -v green="$GREEN" -v red="$RED" -v reset="$RESET" '
        {
            print green $1 reset " ====>> " red $2 reset
        }'
    }
    

case $choice in
    1)
        display_and_count_ips
        ;;
    2)
        display_and_count_requests
        ;;
    3)
        display_and_count_user_agents
        ;;
    4)
        display_referrers 
        ;;
    5)  
        echo "Displaying and counting all data..."
        display_and_count_ips
        echo ""
        echo "==============================================="
        display_and_count_requests
        echo ""
        echo "==============================================="
        display_and_count_user_agents
        echo ""
        echo "==============================================="
        display_referrers 
        ;;
    99)
        echo -e "${RED}Exiting the program...Goodbye!${RESET}\n"
        exit 0



         ;;

     *)
        echo "Invalid choice. Exiting."
        continue 
        ;;
esac
done

