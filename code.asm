.model small

pulalinha macro
    mov ah, 02
    mov dl, 13
    int 21h

    mov ah, 02
    mov dl, 10
    int 21h
endm

numeros macro
    local lenum, leenter, outrojump, segundonum, continua, lenum1, leenter1, outrojump1

        mov ah, 09
        lea dx, msg1
        int 21h
        
    lenum:
        mov ah, 08
        int 21h

        cmp al, 13
        je lenum
        cmp al, 8
        je lenum
        mov ah, 02
        mov dl, al
        mov bh, al
        sub bh, 30h
        int 21h

    leenter:
        mov ah, 08
        int 21h
        cmp al, 8
        je outrojump
        cmp al, 13
        je segundonum 
        jmp leenter
        

    outrojump:
        mov ah, 02
        mov dl, 8
        int 21h 
        jmp lenum
    
        segundonum:
        mov ah, 09
        lea dx, msg2
        int 21h

    lenum1:
        mov ah, 08
        int 21h

        cmp al, 13
        je lenum1
        cmp al, 8
        je lenum1
        mov ah, 02
        mov dl, al
        mov ch, al
        sub ch, 30h
        int 21h

    leenter1:
        mov ah, 08
        int 21h
        cmp al, 8
        je outrojump1
        cmp al, 13
        je continua 
        jmp leenter1
        

    outrojump1:
        mov ah, 02
        mov dl, 8
        int 21h 
        jmp lenum1
    
    continua:
        mov ah, 09
        lea dx, msg3
        int 21h

        
endm

.data
    menu db 13,10,13, 10, 'Qual operacao deseja efetuar?? $'
    menu1 db 13,10, '1- SOMA // 2- SUBTRACAO // 3- MULTIPLICACAO // 4- DIVISAO: $'
    menu2 db 13, 10, 'Qual outra operacao deseja efetuar?? $'
    msg1 db 13,10, 'Digite o primeiro numero: $'
    msg2 db 13,10, 'Digite o segundo numero: $'
    msg3 db 13,10, 'O resultado e: $'
    msg4 db 13,10, 'E o resto e: $'
    msg5 db 13,10, 'Deseja continuar?? (1- SIM // 2- NAO): $'
    msg6 db 13,10, 'FIM!!!$'
    msg7 db 13,10, 'OPCAO INVALIDA, TENTE NOVAMENTE!!! $'
    msg8 db 13,10, 'OPERACAO IMPOSSIVEL, TENTE NOVAMENTE!!! $'
    msg9 db 'Negativo!!! $'
    msg10 db 13,10, '============================================$'
    msg11 db 13,10, 'SEJA BEM VINDO A CALCULADORA$'
    msg12 db 13,10, 'VOCE SELECIONOU PARA CONTINUAR PARA OUTRA OPERACAO$'


    

.code
    main proc

    mov ah, 06h    ; scroll up function
	xor al, al     ; clear entire screen
	xor cx, cx     ; upper left corner ch=row, cl=column
	mov dx, 184fh  ; lower right corner dh=row, dl=column 
	mov bh, 70h
	int 10h

    

    mov ax, @data
    mov ds, ax

    ;imprimir mensagem de boas vindas
    mov ah, 09
    lea dx, msg10
    int 21h
    mov ah, 09
    lea dx, msg11
    int 21h
    mov ah, 09
    lea dx, msg10
    int 21h

    ;imprimir o menu
    mov ah, 09
    lea dx, menu
    int 21h
    lea dx, menu1
    int 21h


    jmp continuanormal

    repetir1:
    ;imprimir texto inicial para outra operação
    pulalinha
    pulalinha
    mov ah, 09
    lea dx, msg10
    int 21h
    mov ah, 09
    lea dx, msg12
    int 21h
    mov ah, 09
    lea dx, msg10
    int 21h
    pulalinha
    pulalinha

    ;imprimir o menu para outra operação
    mov ah, 09
    lea dx, menu2
    int 21h
    lea dx, menu1
    int 21h

    continuanormal:

    mov ah, 01
    int 21h
    ;comparar agora para fazer o respectivo jump da operacao
    cmp al, 31h
    je um
    cmp al, 32h
    je dois
    cmp al, 33h
    je tres
    cmp al, 34h
    je quatro
    jne invalida1

    ;jump equal perto para usar um jmp maior
    um:
        jmp soma
    
    dois:
        jmp subtracao
    
    tres:
        jmp multi

    quatro:
        jmp divi

    invalida1:
        mov ah, 09
        lea dx, msg7
        int 21h
        jmp repetir

    soma: ;jump para soma
        ;digitar os numeros
        numeros

        add bh, ch

        mov ax, 0
        mov al, bh
        mov bl, 10
        div bl
        mov cl, ah
        add cl, 30h
        mov ch, al
        add ch, 30h



        mov dl, ch
        mov ah, 02
        int 21h

        mov dl, cl
        mov ah, 02
        int 21h

        jmp fim



    subtracao: ;jump para subtracao
        ;digitar os numeros
        numeros
        cmp bh, ch
        jl menor
        sub bh, ch
        add bh, 30h

        mov dl, bh
        mov ah, 02
        int 21h

        jmp fim

        menor:
            mov ah, 09
            lea dx, msg9
            int 21h
            jmp fim


    multi: ;jump para multiplicacao
        ;digitar os numeros
        numeros

        mov al, ch
        mul bh

        
        mov bl, 10
        div bl
        mov cl, al
        add cl, 30h
        mov ch, ah
        add ch, 30h


        mov dl, cl
        mov ah, 02
        int 21h

        mov dl, ch
        mov ah, 02
        int 21h

        jmp fim


    divi: ;jump para divisao
        ;digitar os numeros
        numeros

        cmp ch, 0
        je impossivel
        jne dividir

        impossivel:
            mov ah, 09
            lea dx, msg8
            int 21h
            jmp repetir

        dividir:

            mov ax, 0
            mov al, bh
            div ch

            add al, 30h
            mov bh, ah
            add bh, 30h

            mov dl, al
            mov ah, 02
            int 21h
            
            mov ah, 09
            lea dx, msg4
            int 21h
            mov dl, bh
            mov ah, 02
            int 21h

            jmp fim


    
    fim:

        pulalinha
        mov ah, 09
        lea dx, msg5
        int 21h

        mov ah, 01
        int 21h
        cmp al, 31h
        je repetir
        cmp al, 32h
        je fim1
        jne invalida
        
        
    invalida:
        mov ah, 09
        lea dx, msg7
        int 21h
        jmp fim
        
    repetir:
        jmp repetir1

    fim1:

        mov ah, 09
        lea dx, msg6
        int 21h

        mov ah, 4ch
        int 21h

    
    main endp
    end main
