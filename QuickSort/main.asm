TITLE MASM Skeleton Project
INCLUDE Irvine32.inc


.data

array SDWORD 10,7,8,9,1,5
len = LENGTHOF array
message BYTE "Sorted Array:",0
seperator BYTE  ", ",0

.code
; int partition(int arr[],int low,int high)
; array addres : EBP+8
; low : EBP+12
; high : EBP+16
; return value : EAX
partition PROC

ret
partition ENDP
; void quickSort(int arr[],int low,int high)
; array addres : EBP+8
; low : EBP+12
; high : EBP+16
quicksort PROC
push ebp
mov ebp,esp
pushad

;body of quicksort


	;if(low<high)  cmp -> jmpcond
    mov eax,[ebp+12]   ; eax <- low
    cmp eax,[ebp+16]   ; compare low and high
    jnl L1             ; if low >= high then jump to L1
    ; body executed when low < high

    ; int pi=partition(arr,low,high);  ebx <- pi
    mov edi,[ebp+8]    ; edi <- arr address
    mov esi,[ebp+12]   ; esi <- low
    mov edx,[ebp+16]   ; edx <- high

    push edx
    push esi
    push edi
    call partition    ; partition return value in eax

;    quickSort(arr,low,pi-1);
	mov ebx,eax ; ebx <- pi
    dec ebx     ; ebx <- pi-1
    push ebx
    push esi
    push edi
    call quickSort

;    quickSort(arr,pi+1,high);
    mov ebx,eax ; ebx <- pi
    inc ebx     ; ebx <- pi+1
    push edx
    push ebx
    push edi
    call quickSort

L1:

popad
mov esp,ebp
pop ebp
ret 12
quicksort ENDP

main PROC
   
    push DWORD PTR len-1
    push DWORD PTR 0
	push OFFSET array
    call quicksort

    mov edx,OFFSET message
    call WriteString
    
    mov ecx,len
    mov esi,0
PRINT:
    mov eax,array[esi]
    add esi,4
    call WriteInt
    mov edx,OFFSET seperator
    call WriteString
    loop PRINT
exit
main ENDP
END main

  

