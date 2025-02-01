# analyze-access

`analyze-access` is a powerful and efficient Bash script designed to analyze Apache `access.log` files. The tool extracts and displays useful information from the logs, including IP addresses, requests, user agents, and referrers. It also offers a "Top N" feature that allows you to view the most frequent results, making it ideal for analyzing traffic patterns and identifying potential security risks or trends.

## Features

- **IP Analysis**: Counts and displays unique IP addresses in the log file.
- **Request Analysis**: Displays and counts unique HTTP requests.
- **User Agent Analysis**: Identifies and counts different user agents accessing the server.
- **Referrer Analysis**: Displays and counts referrers to track the origin of traffic.
- **Top N**: Allows users to specify the number of top results they wish to display for each category (e.g., Top 10 IPs, Top 5 requests).

## Installation

To get started with `analyze-access`, follow these steps:

### Prerequisites

Make sure you have the following installed on your system:
- **Bash** (typically pre-installed on most Linux systems)
- **Access to an Apache `access.log` file** to analyze

### Step 1: Clone the repository

Clone the repository to your local machine using Git:

```bash
git clone https://github.com/username/analyze-access.git
cd analyze-access
