
.model small
.stack 100h
.data
    input db 'Enter the string and press / : $'
    palindrome db 'The string is palindrome $'
    notPalindrome db 'The string is not palindrome $'
    result db ?
    stringArray db 50 DUP(?)
    stringArrNTPUNC db 50 DUP(?)
.code
    charRemover proc
        push bp
        jmpToAlpha:
        inc si
        mov al,[si]
        cmp  al,020h
        je CL1
        jmp jmpToAlpha
        Cl1:
        pop bp
        ret
    charRemover endp
    removePunctuation proc
        push bp
        mov si,offset stringArray
        mov di,offset stringArrNTPUNC
        stringParser:
        mov al,[si]
        cmp al,020h
        jne PL3
        inc si
        mov al,[si]
        PL3:
        cmp al,2fh
        je PLE1
        cmp al,041h
        jb PL1
        cmp al,05bh
        jb PL2
        cmp al,061h
        jb PL1
        cmp al,07bh
        jb PL2
        PL1:
        call charRemover
        inc si
        mov al,[si]
        PL2: ;ignoring char as it may be alphabet
        mov [di],al
        inc di
        inc si
        jmp stringParser
        PLE1:
        mov al,024h
        mov [di],al
        pop bp
        ret
    removePunctuation endp
    checkPalindrome proc
        mov cx,bp
        mov di,offset stringArrNTPUNC
        reverser:
        mov al,[di]
        cmp al,024h
        je CPLS
        inc di
        jmp reverser
        CPLS:
        dec di
        mov si,offset stringArrNTPUNC
        checker:
        mov al,[si]
        mov ah,[di]
        cmp al,024h
        je Palin
        cmp al,ah
        jne CPL2
        inc si
        dec di
        jmp checker
        Palin:
        mov [result],'P'
        mov dx,offset palindrome
        mov ah,9
        int 21h
        jmp CPLE
        CPL2:
        notPalin:
        mov [result],'N'
        mov dx,offset notPalindrome
        mov ah,9
        int 21h
        CPLE:
        mov bp,cx
        ret
    checkPalindrome endp
    main proc
        mov ax,@data
        mov ds,ax
        mov dx,offset input
        mov ah,9
        int 21h
        mov si,offset stringArray
        takeInput:
        cmp al,02fh
        je L1
        mov ah,1
        int 21h
        mov [si],al
        inc si
        jmp takeInput
        L1:
        call removePunctuation
        EXIT:
        mov dx,offset stringArrNTPUNC
        mov ah,9
        int 21h
        call checkPalindrome
        mov ah,4ch
        int 21h
    main endp
    end main



