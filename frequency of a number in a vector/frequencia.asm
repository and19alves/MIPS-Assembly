
# --------------------------------------------------------------

#int main(){
#    int vetor[] = {1,1,2,3,2,4,5,6,5,4,8,9,1,1,14};
#    int n;
#    int i;
#    int contador = 0;

#    printf("\n Digite o numero que desejas verificar a frequencia: ");
#    scanf("%d", &n);


#     for(i=0; i<15;i++){ // vetor tem 15 posicoes
#        if (n == vetor[i]){
#            contador++;
#        }
#    }
#    printf("\n A frequencia do numero no vetor será de:"contador);
#}


#// freq(5)


# --------------------------------------------------------------
#t0 = Guarda endereço de vetor[0]
#s0 = guarda valor de vetor[0]

#t1 = Guarda endereço de cont
#s1 = guarda valor de cont

#s2 = valor de n

#s3 = valor contador de For i
#t3 = flag para (0 =Maior igual | 1 = Menor)
# --------------------------------------------------------------
.include "bibliUtil.asm"
.include "vetor.asm"

.data
	.align 2
	n:	.space 4
	cont:	.space 4  
	str0:	.asciiz " Digite o numero que desejas verificar a frequencia: "
	str1:   .asciiz " A frequencia do numero no vetor será de: "
.text
	# int cont = 0;
	la $t1 cont   #Carregando para o registrador $t1 o end. de cont
	lw $s1,0($t1) # carregando para $s1 o valor de conteudo de $t1
	addu $s1, $zero, $zero	# como cont = 0, faremos a adicao aqui
	sw $s1, 0($t1)	#Apos isso, atualizamos o valor na memoria

	#printf("\n Digite o numero que desejas verificar a frequencia: ");
	printStr(str0)
	
	#scanf("%d", &n);
	readInt($s2) #s2 = n
	
	# for(i=0; i<15;i++){ // vetor tem 15 posicoes
	
	addu $s3, $zero, $zero 	# S3 será nosso I (CONTADOR) e inicializamos ele como 0
	
	## Recarregando o vetor para a memoria (Pra fazermos a comparação da linha X)
	la $t0 vetor  #Carregando para o registrador $t0 o end. de vetor
	lw $s0,0($t0) #Carregando para S0 o valor de conteudo de $t0
	
FOR:	slti $t3, $s3, 15	# i(s3)<15 	(T3 recebe a resposta) 
	beq  $t3, $zero, SAI # T3 = 0 quando S3 >= 15 [SAIR DO FOR]
	### 
	
	
	# if (n == vetor[i]){
	beq $s2,$s0,INCREMENTA1 #N == vetor[i]
	j NAOINCREMENTA
	
INCREMENTA1:	
	addiu $s1, $s1, 1	#  cont++;
	j FIMFOR
NAOINCREMENTA:
	# Apenas pula o label INCREMENTA1
	j FIMFOR
	
FIMFOR:
	###
	addiu $t0, $t0, 4	# Aritmetica de ponteiro para irmos ao proximo indice do vetor
	lw $s0,0($t0) #Carregando para S0 o valor de conteudo de $t0
	addiu $s3, $s3, 1	#i++
	j FOR
	
SAI:  #SAIDA DO FOR

#  printf("" A frequencia do numero no vetor será de: %d",cont);
printNL
printStr(str1) 
printInt($s1)
printNL
	j fim	 #pula para o fim
	

fim:
	return0
	
	