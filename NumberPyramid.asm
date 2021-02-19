.data
	prompt:	.asciiz "Enter the height of the pattern (must be greater than 0): "
	error: .asciiz "Invalid Entry!"
.text
	promptloop:
	#prompt user for height
	li $v0, 4
	la $a0, prompt
	syscall
	
	#get user's height
	#syscall 5 is read int(read users input)
	li $v0, 5
	syscall
		
	#store height in regisgter $t0
	li $t1, 0
	move $t0, $v0
	li $t3, 0
			
	#newline
	li $v0, 11
	la $a0, 0xA
	syscall
	
	blez $t0, errorloop
	#branch if $t0 is less than or equal to 0
	startloop:
		#break if $t0 hits 0
		blez $t0, endloop #break
		subi $t2, $t0, 1 #$t2 (height - 1) used for tabs
		j loop2		
	#tab loop
	#prints height - 1 amount of tabs
	#increments $t2 down, breaks when it hits 0
	#ex: h = 5, $t2 = 4, prints 4 tabs, $t2 = 3, loops etc.
	#when hits 0 breaks to print num loop
	loop2:
		blez $t2, loop3 #if $t2 = 0 break to loop3 to print num	
		#print tab
		li $v0, 11
		li $a0, 0x9 #unicode for tab
		syscall
		subi $t2, $t2, 1 #incriment $t2 down
		j loop2 #reset 
	#print num loop
	#prints 1 after tab loop, then increments up
	#not sure how to make it work past 1st level (1)
	#if $t3 
	#$t0 = 1, print num 1, print newline,
	
	loop3:
		#adds 1 to t3
		addi $t3, $t3, 1
		#print num in $t3, starts as 1 and goes up
		li $v0, 1
		la $a0, ($t3)
		syscall
		#if t3 = 1 (1st call), break
		beq $t3, 1, newline
		#else
		#jump to inner loop
		#after printing $t3, and incrementing up, breaks to middle logic loop
		j loopstars
		
 	loopstars:
 		li $t4, 1
 		#print tab
		li $v0, 11
		li $a0, 0x9 #unicode for tab
		syscall
 		#logic for tabs and asteriks
 		innerloop:
 			beq $t3, $t4, endloopstars
 			#print *
			li $v0, 11
			li $a0, 0x2A #unicode for *
			syscall
			#print tab
			li $v0, 11
			li $a0, 0x9 #unicode for tab
			syscall
			addi $t4, $t4, 1
			j innerloop
 	
 	endloopstars:
 		addi $t3, $t3, 1
 		#print num in $t3
		li $v0, 1
		la $a0, ($t3)
		syscall
 		j newline

	newline:
		#subtract user height by 1
		subi $t0, $t0, 1
		
		#print newline
		li $v0, 11
		li $a0, 0xA
		syscall
		
		#reset loop
		j startloop
		
	errorloop:
		li $v0, 4
		la $a0, error
		syscall
		j promptloop
	endloop:
		li $v0, 10
		syscall

		#sample code to copy and paste		
		#print tab
		#li $v0, 11
		#li $a0, 0x9 #unicode for tab
		#syscall
		 
		#print *
		#li $v0, 11
		#li $a0, 0x2A #unicode for *
		#syscall
		
		#printing int
		#li $v0, 1
		#la $a0, ($t0)
		#syscall
		
		#print newline
		#li $v0, 11
		#li $a0, 0xA
		#syscall
		
