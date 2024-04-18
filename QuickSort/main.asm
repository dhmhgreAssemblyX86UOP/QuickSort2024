TITLE MASM Skeleton Project
INCLUDE Irvine32.inc


.data

array SDWORD 10,7,8,9,1,5
len = LENGTHOF array
message BYTE "Sorted Array:",0
seperator BYTE  ", ",0

.code
; a-> [ebp+8]
; b-> [ebp+12]
;void swap(int *a,int *b)
;{
;	int t=*a;
;	*a=*b;
;	*b=t;
;}
swap PROC
push ebp
mov ebp,esp
pushad

mov edi ,[ebp+8]
mov eax , [edi]  ; eax <- *a

mov esi ,[ebp+12]
mov ebx , [esi]  ; ebx <- *b

mov [esi],eax    ; *b <- *a
mov [edi],ebx    ; *a <- *b

popad
mov esp,ebp
pop ebp
ret 8
swap ENDP

; int partition(int arr[],int low,int high)
; array addres : EBP+8
; low : EBP+12
; high : EBP+16
; return value : EAX
partition PROC
push ebp
mov ebp,esp
pushad

; edi : array address
; ebx : pivot
; edx : i



;//choose the pivot   
;  int pivot=arr[high];  ebx <- pivot
   mov edi,[ebp+8]    ; edi <- arr address
   mov esi,[ebp+16]   ; esi <- high]
   shl esi,2
   mov ebx,[edi + esi]


;  //Index of smaller element and Indicate
;  //the right position of pivot found so far
;  int i=(low-1);   edx <- i
   mov edx,[ebp+12]
   dec edx


   mov ecx,[ebp+16]
   sub ecx,[ebp+12] ; ecx <- high-low
   inc ecx          ; ecx <- high-low+1
   mov eax,[ebp+12] ; eax <- j = low
L1: ;  for(int j=low;j<=high;j++)  high-low+1

    ;if(arr[j]<pivot)
    cmp [edi+eax*4],ebx
    jnl L2
    ; if body executed when arr[j] < pivot

    ;;//Increment index of smaller element
    ;i++;
    inc edx

    ;xchg [edi+edx*4],[edi+eax*4]



L2:
    loop L1

  
;  for(int j=low;j<=high;j++)  high-low+1
;  {
;    //If current element is smaller than the pivot
;    if(arr[j]<pivot)
;    {
;      //Increment index of smaller element
;      i++;
;      swap(arr[i],arr[j]);
;    }
;  }
;  swap(arr[i+1],arr[high]);
;  return (i+1);

popad
mov esp,ebp
pop ebp
ret 12
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

  

