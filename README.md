# SLAEx86
SecurityTube Linux Assembly Expert

SLAE 7 Assigments:

1. Create a Shell_Bind_TCP shellcode
	- Binds to a port
	- Execs shell on incoming connection
	- Port number should be easily configurable

2. Create a Shell_Reverse_TCP shellcode
	- Reverse connects to configured IP and Port
	- Execs shell on successful connection
	- IP and port should be easily configurable

3. Create Egg Hunter Shellcode
	- Study about Egg Hunter shellcode
	- Create a working demo of the Egghunter
	- Should be configurable for different payloads

4. Create Custom Encoder Shellcode
	- Create custom encoding shceme like "Insertion Encoder"
	- PoC with using execve-stack as the shellcode to encode your schema and execute

5. Analyze at least 3 Msfpayload Shellcode samples
	- Examine linux/x86 samples
	- Use GDB/Ndisasm/Libemu to dissect the functionality

6. Create 3 Polymorphic versions of Shellcode samples from Shell-Storm
	- Should beat pattern matching
	- Cannot be larger than 150% of the original sample shellcode
	- Bonus points for making it smaller

7. Create a custom Crypter Shellcode
	- Can use existing or original encryption schema
	- Can use any programming language to demo

Blog Posts must contain SLAE-XXXXX (Student ID: PA-1065)
