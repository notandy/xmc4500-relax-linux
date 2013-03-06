ENTRY(Reset_Handler)

MEMORY
{
    FLASH_cached (RX) : ORIGIN = 0x08000000, LENGTH = 0x100000
    FLASH_uncached (RX) : ORIGIN = 0x0C000000, LENGTH = 0x100000
    PRAM (RWX) : ORIGIN = 0x10000000, LENGTH = 0x10000
    DSRAM_system (RWX) : ORIGIN = 0x20000000, LENGTH = 0x10000
    STACK (RWX) : ORIGIN = 0x2000FFFF, LENGTH = 0x0
    DSRAM_comm (RWX) : ORIGIN = 0x30000000, LENGTH = 0x8000
}

/*
* Sections definitions:
*
* .text 		- machine instructions.
* .data 		- initialized data defined in the program.
* .bss  		- un-initialized global and static variables (to be initialized to 0 before starting main).
* .stack		- just contains the pointer to the stack end at the right place.
*/
SECTIONS
{
    . = ORIGIN(FLASH_uncached);

    .text :
    {
        KEEP(*(.reset_table))
        *(.text)
        *(.rodata)
        *(.rodata.*)
        _end_text = .;
    }>FLASH_uncached

    /* DATA */
    .data : 
    {
        _start_data = .;
        *(.data)
        _end_data = .;
    } > DSRAM_system AT >FLASH_uncached


    /* BSS */
    .bss : 
    {
    	_start_bss = .;
        *(.bss)
        _end_bss = .;
    }>DSRAM_system
    
	.stack : 
	{
		_stack_top = .; /* An index to the end of the stack */
	}>STACK

}