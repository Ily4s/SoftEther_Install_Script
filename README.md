SoftEther Install Script
========================

Installation
------------
1. Determine what architecture you are currently running
2. Download the proper script using wget, curl or (s)FTP, eg, "wget URL"
3. Run the script as root, eg "sudo sh SCRIPT.sh"
4. When persistent iptables asks if you want to save any IPv4 rules, choose yes, and it doesn't matter what you answer for IPv6
5. At this point, the VPN and DHCP server should be running
6. Download the server manager from http://www.softether-download.com/en.aspx
7. Connect to the VPN using the server manager, the default password is "password"
8. Go to "Encryption and Network" and CHANGE THE PASSWORD
9. While you're in that menu, generate a new key to your liking
10. Save all that, navigate to "Manage Virtual Hub" and add users and groups as you like.
11. Configure anything else you might want
12. At this point you have a VPN server that supports L2TP, OpenVPN, SSTP, and SoftEther's own protocol
13. Use the following diagram for choosing a client to connect with. Picture from SoftEther homepage
![Client Diagram](https://www.softether.org/@api/deki/files/4/=1.2.jpg)

Support
-------
- This script has been tested on Ubuntu 14.04 Server x64, other distros using apt for repo/package management "should" work fine.

Notes
-----
- As I might not continute to update this script, it should be a good idea to update the URL on line 8 and file name on line 11 from http://www.softether-download.com/files/softether/
- IPv6 support can be added if you configure the DHCP server and iptables yourself
- Don't enable DNS traversing as it will conflict with the DHCP server
- If the speeds are slow, try lowering encryption settings

Credits
-------
- https://www.softether.org
- https://www.digitalocean.com/community/tutorials/how-to-setup-a-multi-protocol-vpn-server-using-softether
- http://blog.lincoln.hk/blog/2013/05/17/softether-on-vps-using-local-bridge
