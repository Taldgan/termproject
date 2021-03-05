# Compute first twenty-five Fibonacci numbers and put in array, then print
	.data
prompt:    .asciiz     "Please enter fibonacci number: \n"

      .text
      #####Get input#########################################
      la    $a0,prompt    # display prompt string
      li    $v0,4
      syscall
      li    $v0,5    # read array size into $t9
      syscall
      move  $t9,$v0 
      ######Allocate Stack Space for ###############
      move $t5, $t9        #  move user-given array size into $t5
      mul $t9, $t9, 4	   #multiply 'array size' by 4 to account for word size
      sub  $sp, $sp, $t9   #allocate space on stack for user-input array size
      la $t0, ($sp)      # load address of array (top of stack) into $t0
      ######################################################
      li   $t2, 1           # 1 is first and second Fib. number
      add.d $f0, $f2, $f4
      sw   $t2, 0($t0)      # F[0] = 1
      sw   $t2, 4($t0)      # F[1] = F[0] = 1
      addi $t1, $t5, -2     # Counter for loop, will execute (size-2) times
loop: lw   $t3, 0($t0)      # Get value from array F[n] 
      lw   $t4, 4($t0)      # Get value from array F[n+1]
      add  $t2, $t3, $t4    # $t2 = F[n] + F[n+1]
      sw   $t2, 8($t0)      # Store F[n+2] = F[n] + F[n+1] in array
      addi $t0, $t0, 4      # increment address of Fib. number source
      addi $t1, $t1, -1     # decrement loop counter
      bgtz $t1, loop        # repeat if not finished yet.
      ########################################################################################################
      la   $t0, ($sp)	    #reset $t0 to top of stack for print
      la   $a0, ($t0)       # first argument for print (array)  ALTERED: uses addres stored in $t0 instead of fib
      ########################################################################################################
      add  $a1, $zero, $t5  # second argument for print (size)
      jal  print            # call print routine. 
      li   $v0, 10          # system call for exit
      syscall               # we are out of here.
		
#########  routine to print the numbers on one line. 

      .data
space:.asciiz  " "          # space to insert between numbers
head: .asciiz  "The Fibonacci numbers are:\n"
      .text
print:add  $t0, $zero, $a0  # starting address of array
      add  $t1, $zero, $a1  # initialize loop counter to array size
      la   $a0, head        # load address of print heading
      li   $v0, 4           # specify Print String service
      syscall               # print heading
out:  lw   $a0, 0($t0)      # load fibonacci number for syscall
      li   $v0, 1           # specify Print Integer service
      syscall               # print fibonacci number
      la   $a0, space       # load address of spacer for syscall
      li   $v0, 4           # specify Print String service
      syscall               # output string
      addi $t0, $t0, 4      # increment address
      addi $t1, $t1, -1     # decrement loop counter
      bgtz $t1, out         # repeat if not finished
      jr   $ra              # return
	
