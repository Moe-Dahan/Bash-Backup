# Bash-Backup

A lightweight, straightforward Bash script that automates backing up local directories to a remote server using `scp` and a centralized configuration file.

---

## Features

* **Centralized Configuration:** Keeps your server credentials and backup paths separate from the execution script.
* **Batch Folder Processing:** Define multiple directories in a single list to back up in one go.
* **Flexible Execution:** Run it on-demand via the terminal or automate it with a `cron` job.
* **Built-in Validation:** Automatically checks if your configuration file exists and alerts you if it's missing or misconfigured.

---

## Prerequisites

* A Unix-like environment (Linux, macOS, etc.)
* SSH access configured with your remote server (SSH keys are recommended so `scp` runs without password prompts during automation).

---

## Getting Started & Configuration

### 1. Create the Configuration Directory and File
The script looks for a configuration file in your home directory under `.script_settings/settings.txt`. Create it by running:

```bash
mkdir -p ~/.script_settings
nano ~/.script_settings/settings.txt

```

# 2. Add Your Settings

Paste your remote server destination and the list of folders you want to back up using the following format:
Plaintext

* server_path = username@server_ip:/path/to/backup
* folders = [
    "/path/to/backup/folder1",
    "/path/to/backup/folder2"
]

# 3. Download and Prepare the Script

Save the backup script to your machine (e.g., as backup.sh), and make it executable:
Bash

``` bash
chmod +x backup.sh
```

How to Use
Run Manually via Terminal

You can execute the script directly at any time:
Bash

``` bash
./backup.sh
```

Automate with Cron

To run your backups automatically (for example, every night at 2:00 AM), open your crontab:
Bash

``` bash
crontab -e
```

Add the following line (adjusting the path to where your script is saved):
Code snippet
``` bash
0 2 * * * /path/to/your/backup.sh >/dev/null 2>&1
```
Tip: Make sure you have passwordless SSH authentication set up (via SSH keys) if you plan on running this script automatically through cron, otherwise the scp commands will hang waiting for a password prompt.

