#fibonacci.asm

# F_n = 1 , 1 , 2 , 3 , 5 , 8 , ....
#       1   2   3   4   5   6        n 
#
# int main(void){
#   int n,i,anterior, atual;
#
#
#   printf("Digite o num de termos:");
#   scanf("%d", &n);
#   if(n<=0){
#     printf("o num de termos deve ser um inteiro positivo");
#     return 0; }
#	if((n ==1) || (n == 2)){    
#		printf("O fibonacci de %d eh: 1", n);
#		return 0;
#   }
#   anterior = 1;
#   atual = 1;
#   for(i = 3; i<=n; i++){
#   	tmp = atual;
#		atual = atual + anterior;
#		anterior = tmp;
#   }
#   printf("O fibonacci de %d eh: %d", n, atual); 
#}
# DDA 09.08.2021

.data
	n:			.space	4
	i:			.space	4
	anterior:	.space	4
	atual:		.space	4
	str1:		.asciiz "Digite o num de termos:"
	strerr:		.asciiz "o num de termos deve ser um inteiro positivo"
	str21:		.asciiz "O fibonacci de "
	str22:		.asciiz	" eh: 1"
	str31:		.asciiz "o fibonacci de "
	str32:		.asciiz	" eh: "

.text

#   printf("Digite o num de termos:");
	addiu		$v0, $zero, 4
	la			$a0, str1
	syscall
#   scanf("%d", &n);	
	addiu		$v0, $zero, 5
	syscall
	
	addu		$s0, $zero, $v0			#s0 = n
	la			$t0, n
	sw			$s0, 0($t0)				#MEM[t0+0] = s0

#   if(n<=0){  equiv 0 >= n
#     printf("o num de termos deve ser um inteiro positivo");
#     return 0; }
	slt			$t0, $zero, $s0		# 0 < n ? se sim t0 <- 1 senao t0 <- 0
	bne			$t0, $zero, SAI1
	#corpo do if
	addiu		$v0, $zero, 4
	la			$a0, strerr
	syscall
	j			EXIT
	#corpo do if /
SAI1:	
#	if((n == 1) || (n == 2)){    
#		printf("O fibonacci de %d eh: 1", n);
#		return 0;
#   }		
	addiu	$t1, $zero, 1
	addiu	$t2, $zero, 2
	
	beq		$s0, $t1, IF2
	beq		$s0, $t2, IF2
	j		SAI2
IF2: #corpo do if
	addiu		$v0, $zero, 4
	la			$a0, str21
	syscall
	
	addiu		$v0, $zero, 1
	addu		$a0, $zero, $s0
	syscall
	
	addiu		$v0, $zero, 4
	la			$a0, str22
	syscall

	 #corpo do if /
SAI2:

	for(i = 3; i<=n; i++){		i <= n equiv. i < n+1 forall Z
	addiu	$s2, $zero, 3   # i = 3
	addiu	$s3, $s0, 1		#s3 = n+1
FOR:slt     $t7, $s2, $s3  
	beq		$t7, $zero, SAIFOR
	#corpo do for
	
	#corpo do for /
	addiu	$s2, $s2, 1
	j		FOR
EXIT:												
	#return 0
	addiu		$v0, $zero, 10
	syscall