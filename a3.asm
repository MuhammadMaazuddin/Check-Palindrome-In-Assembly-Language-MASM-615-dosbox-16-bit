                             .model small
.stack 100h
.data
        reverse db 'Number in reverse is  : $'
        print_sum_digit db 'Sum of digits in variable : $'
        var dd 12345678h
        sum_digit db ?
        reverse_array db ?
.code
        mov ax,@data
        mov ds,ax
        mov si,offset var
        mov di,offset reverse_array
        mov bl,4
        mov cl,0
        SHIFTER:
        cmp bl,0
        je L1
        mov al,[si]
        and al,00001111b
        mov [di],al
        add cl,al
        inc di
        mov al,[si]
        and al,11110000b
        rol al,4
        mov [di],al
        add cl,al
        inc di
        inc si
        dec bl
        jmp SHIFTER
        L1:
        mov dx,offset reverse
        mov ah,9
        int 21h
        mov si,offset reverse_array
        mov bl,8
        DISPLAY:
        cmp bl,0
        je L3
        mov dl,[si]
        add dl,30h
        mov ah,2
        int 21h
        inc si
        dec bl
        jmp DISPLAY
        L3:
        mov dl,10
        mov ah,2
        int 21h
        mov dx,offset print_sum_digit
        mov ah,9
        int 21h
        mov sum_digit,cl
        mov dl,cl
        mov ah,2
        int 21









        EXIT:
        mov ah,4ch
        int 21h
end

