# Anderson Alves Araujo - 12011BCC031

# --------------------------------------------------------------
#   int n;
#    int fat = 1;
#    int x;
#    printf("\n Digite o valor desejado: ");
#    scanf("%d", &n);

#    if(n < 0)
#        printf("\n Não existe fatorial menor a 0");

#    if (n == 0){
#        printf("\n Fatorial de 0 sera: 1");
#        return 0;
#    }
#    for(x=1;x<=n;x++){
#       fat = fat * x;
#   }

#    printf("\n Fatorial de %d sera: %d",n,fat);
#    return 0;

# --------------------------------------------------------------
# t0 = Guarda endereço do Label FAT
# s0 = Guarda o conteudo de FAT

# t1 = Guarda endereço do Label N
# s1 = Guarda o conteudo de N

# t2 = Guarda a resposta logica de (if N < 0)

#s2 =  Contador do FOR

#s4 = N+1 (Criado para melhor uso do slt)

# t4 = Guarda a resposta logica de (X < N+1)


# --------------------------------------------------------------
.include "bibliUtil.asm"

.data
	.align 2
	n: 	.space 4  #   int n;
	fat:    .space 4  #    int fat=1 (Precisamos ainda atribuir 1 a fat);
	str1:	.asciiz "Digite o valor desejado: "
	str0:	.asciiz "Não existe fatorial menor que 0."
	strf0:  .asciiz "Fatorial de 0 será: 1"
	strs0:  .asciiz " Fatorial será igual a: "
	 
.text
	# int fat = 1;
	la $t0 fat   #Carregando para o registrador $t0 o end. de fat
	lw $s0,0($t0) # carregando para $s0 o valor de conteudo de $t0
	addiu $s0, $zero, 1	# como fat=1, faremos a adicao aqui
	sw $s0, 0($t0)	#Apos isso, atualizamos o valor na memoria

	# printf("\n Digite o valor desejado: ");
	printStr(str1)
	
	#scanf("%d", &n);
	readInt($s1) #s1 = n
	
	la $t1, n #Carregando para o registrador $t1 o end. de n
	sw $s1, 0($t1)  #Apos isso, atualizamos o valor na memoria

	#if(n < 0)
	slti $t2, $s1, 0   # N < 0 ?  Se sim, T2=1 	[senao t2 = 0]
	beq $t2,$zero, nmai0 #T2 = 0 (Ou seja, digitou algo maior que 0)
	printNL
	printStr(str0) #Printa info
	j fim #pula para o fim
	
nmai0: #Nmaior que zero
	
	 # if(n==0)
	 beq $s1,$zero,nzero #n==0
	 
	 #	N > 0 (Abaixo codigo para N ser maior que 0)
	 #   for(x=1;x<=n;x++){
	 
	# x <= n
	 addiu $s2, $zero, 1 #Contador do for (X = 1)
	 addiu $s4, $s1,1  # Para realização do for, vou considerar que s4 será (valor digitado + 1)

For: 	# Laço FOR
 	 slt $t4, $s2,$s4 	# Enquanto s2(contador) for menor que s4(valordigitado+1) 
	 #T4 será 1 se (s2 < s4)  |  T4 será 0 se (s2 >= s4)
	 
	 beq $t4, $zero,saiFor #Saida do laço for
	 
	 ### FOR
	 mul $s0, $s0, $s2   # fat = fat * x
	 ######
	 
	 addiu $s2,$s2,1 #X++
	 j For

saiFor: 
	printNL
	printStr(strs0)
	printInt($s0)
	j fim	 #pula para o fim
	
nzero: 
	printNL
	printStr(strf0)#Printa info
	j fim	 #pula para o fim

fim:
	return0
	
	
	
	
	
	
	
	
	
	
