.model small
.stack 100h

.data
    a dw 0
    b dw 0
    i dw 0
    k dw 0
	
.code
main:
    mov ax, @data
    mov ds, ax

; Начало главной вычислительной части
	mov ax, 10		   ; ax = 10
    mov bx, i          ; bx = i
    add bx, bx         ; bx = 2i
    mov di, bx         ; di = bx = 2i
    shl di, 1          ; di = 4i
	add di, bx     	   ; di = 6i
	neg di			   ; di = -6i
    mov si, a          ; si = a
    cmp si, b          ; сравнить a и b
    jle branch_ab      ; если a <= b переход
    
; a > b
	lea si, [bx+di+7]  ; si = 2i - 6i + 7 = 7 - 4i = i1
	lea di, [di+4]	   ; di = 4 - 6i = i2	
    jmp calc_res       ; переход к вычислению res
    
; a <= b
branch_ab:
	lea si, [di+8]	   ; si = 8 - 6i = i1
    mov di, i          ; di = i
    lea di, [bx+di+6]  ; di = 2i + i + 6 = 3i + 6 = i2
    
; Вычисление res
calc_res:
    cmp k, 0           ; сравнить k с 0
    jns k_positive     ; если k >= 0, переход
; k < 0: res = max(i1, 10 - i2)
    sub ax, di         ; ax = 10 - i2
    cmp ax, si         ; сравнение 10 - i2 и i1
    jge finish         ; если 10 - i2 >= i1, ax уже max
    mov ax, si         ; иначе ax = i1
	jmp finish
  
; k >= 0: res = |i1 - i2|
k_positive:
    mov ax, si         ; ax = i1
    sub ax, di         ; ax = i1 - i2
    jns finish         ; если ax >= 0, модуль есть
    neg ax             ; иначе ax = |i1 - i2|
; Результаты: ax = res, si = i1, di = i2
; Конец главной вычислительной части, 27 команд
finish:
    mov ax, 4C00h
    int 21h
end main