# Basic Filesystem Hierarchy Standard(FHS) Directories
---
## Table 1-1

| Directory |Description                         |
| --------- |:---------------------------------:|
| `/`       | The top level directory in the FHS. |
| `/bin`    | Essential command line utilities.  |
| `/boot`   | Startup file, including the Linux kernel. |
| `/dev`    | Hardware and software device. |
| `/etc`    | Most basic configuration files. |
| `/home`   | Home directories for almost every user. |
| `/lib`    | Program libraries for the kernel and various command line utilities |
| `/mnt`    | The mount point for removable media. |
| `/opt`    | Applications such as WordPerfect or StarOffice. |
| `/proc`   | Currently running kernel-related processes. |
| `/root`   | The home directory of the root user. |
| `/sbin`   | System administration commands. |
| `/tmp`    | Temporary files. |
| `/usr`    | Small programs accessible to all users. |
| `/var`    | Variable data, including log files and printer spools. |


# Filesystem Formatting and Checking
---
- `fdisk`
    + 磁碟管理(如分割新區域、列出硬碟區域、刪除硬碟區域)
- `mkfs`
    + 格式化磁碟(可指定檔案系統格式)
- `fsck`
    + 檢查、修復磁碟

# Mounting Partition
---
- `mount -t 檔案格式(eg.vfat) 裝置(eg./dev/fd0) 資料夾(eg./mnt/floppy)`
- `unmount dir` ----卸載，即我們常用的拔除USB裝置，避免裝置損壞。
- `mount -t iso9660 -o loop /home/seal/myiso.iso /mnt/myiso` ----掛載ISO映像檔

# Looking for Files
---
- `find`
    + `find dir(/ or /home) -name file`
- `locate`
    + `locate file` ----使用Red Hat Linux內建的Database搜尋，速度快但缺點是通常一天只更新一次。

# Creating Files
---
- `cp`
- `mv`
- `ln`
    + 即`捷徑`
    + hard link ----一個檔案擁有多個名字
    + symbolic link ----有一個檔案的內容就是連向原檔案的link
    + `ln file2 file1` ----建立硬連結file2
    + `ln -s file2 file1` ----建立軟連結file2

# File Filters
---
- `sort`
- `grep` and `egrep`
- `wc`

# Administrative Commands
---
- `ps`
- `who` and `w`
    + `who` ----Show who is logged on.
    + `w` ----Show who is logged on and what they are doing.

# Wildcards
---
- `*`
- `?`
- `[]`
- 即glob。

# Crontab
---
- `crontab -u username\[optional\] -e`
- `crontab -l`
- format:
  ```
  分 時 日 月 星期 執行指令
  50 * * * * sh /home/robinyang064023/my_shell.sh
  00 00 * * * python /home/robinyang064023/my_python.py
  ```

# Network Tools and Cmmands
---
- `ping`
- `ifconfig`
    + helps you check and configure network adapters.
- `netstat`

# Name Resolution 
---
- `/etc/hosts`
    + host for record local networks
    + `192.168.132.32   linux1.mommabears.com laptop`
- `/etc/resolv.conf`
    + DNS for record other networks and/or the Internet
    + `nameserver   192.168.0.1`
- `/etc/host.conf`
    + This file determines whether it searches though `/etc/hosts` or `DNS` when searching the networks and/or Internet.
- `/etc/nsswitch.conf`
    + This file lookup the specific system database for the service.

# Recommended Configuration
---
- `/, /boot, /usr, /tmp, /var, and /home`
- To improve security, you can mount a read-only disk as /usr to prevent one including root from editing it.
- If the hard drive space is limited, you can create the partitions without `/var`.
- A mail server will require more space for the `/var` directory.
- A recommended file server partitions configuration(2002)
  ```
  | Filesystem | Size(MB) | Mounted Directory |
  |------------|:--------:|:-----------------:|
  | /dev/sda1 | 16 | /boot |
  | /dev/sda2 | 400 | / |
  | /dev/sda5 | 2000| /var |
  | /dev/sda6 | 300 | /usr |
  | /dev/sda7 | 60 | Swap space |
  | /dev/sda8 | 1000 | /home |
  | /dev/sda9 | 3000 | /home/shared |
  ```
- **Swap partitions near the front of a hard disk, thus on a primary partition, have faster access times.**
  + 我們希望他能越快越好，因為它真的很慢。(compare with RAM)

# Red Hat 7 Recommended Partitioning Scheme
---
1. `/boot` partition - recommended size at least 1 GiB.
2. `/root` partition - recommended size of 10 GiB.
3. `/home` partition - recommended size at least 1 GiB.
4. `/swap` partition - recommended size at least 1 GB.
5. Optional advice:
  - In most cases, you should at least encrypt the `/home` partition.
  - **Each kernel** installed on your system **requires approximately 20 MiB** on the `/boot` partition. The **default partition size of 1 GiB** for `/boot` should suffice for most common uses; **increase the size of this partition if you plan to keep many kernels installed at the same time.**
  - **The `/var` directory holds content for a number of applications, including the Apache web server.** It also is used to store downloaded update packages on a temporary basis. **Ensure** that the partition containing the `/var` directory **has enough space** to download pending updates and hold your other content.
  - If you create a separate partition or volume for `/var`, ensure that it is **at least 3GB in size to accommodate downloaded package updates.**
  - The `/usr` directory **holds the majority of software content** on a Red Hat Enterprise Linux system. For an installation of the **default set of software, allocate at least 5 GB of space. If the system will be used as a software development workstation, allocate at least 10GB.
  - If `/usr` or `/var` is partitioned separately from the rest of the root volume, the boot process becomes much more complex because these directories contain components critical to it. In some situations, such as when these directories are placed on an **iSCSI drive** or an **FCoE location**, the system can either be unable to boot, or it can hang with a `Device is busy` error when powering off or rebooting.
  *This limitation only applies to /usr or /var, not to directories below them. For example, a separate partition for /var/www will work without issues.*
  - If you separate subdirectories into partitions, you can retain content in those subdirectories if you decide to install a new version of Red Hat Enterprise Linux over your current system.
  - On a BIOS system with its boot loader using **GPT (GUID partition table)**, you need to create the biosboot partition of **1 MiB** in size. See Section 8.14.1, “Boot Loader Installation” for more details.
  - **UEFI systems** need to contain a small partition with a **mount point** of **/boot/efi/** containing an EFI System Partition file system. Its recommended size is **200 MiB**, which is also the default value for automatic partitioning.

# User Environment
---
- `etc/skel/*`

# Filesystem
---
- `/etc/fstab`

# Networking
---
- `/etc/sysconfig/*`
- `ifup/ifdown`
- `ifconfig`
  + `ifconfig eth0 207.174.142.142` --change ip address
- `netstat -r`
  + display a plethora of network connectivity

# Boot Process
---
- Runlevels
  + six basic runlevels
  + Each runlevel is associated with a level of functionality in Linux.
- fundamental Linux process
  + printing(cups)
  + scheduling
  + Apache(httpd)
  + Samba(smbd)
- `chkconfig`
  + a simple way to maintain different runlevels within the `/etc/rc.d`
- `ntsysv`
  + takes the functionality of chkconfig and wraps it into an easy-to-use screen interface.
- `/etc/inittab`
  + Virtual consoles are configured in the init configuration, `/etc/inittab`

# Kernel Modules
---
- A kernel module is not compiled directly into the kernel but instead operates as a pluggable driver that can be loaded into the kernel as needed.
- The kernel modules approach three basic advantages
  + It reduce the size of the kernel.
  + Smaller kernels are faster.
  + When a module isn't required, it can be dynamically unloaded to take up less memory.
- To see what module are loaded:
  + `cat /proc/modules`
  + `lsmod`
- The `/lib/mdules/kernel_version/*`
  + many device


