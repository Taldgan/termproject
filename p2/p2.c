unsigned char gArray[] = { 0x09, 0xFA, 0x5A, 0x18, 0x48, 0xAC, 0xD4, 0x71 }; 
short int gArraySI[] = { 0x09, 0xFA, 0x5A, 0x18, 0x48, 0xAC, 0xD4, 0x71 }; 
int gArrayI[] = { 0x09, 0xFA, 0x5A, 0x18, 0x48, 0xAC, 0xD4, 0x71 }; 


int test() 
{ 

	__asm { 
		mov al,gArray 
		lea esi,gArray 
		mov dl, byte ptr [esi]   
		mov edx, dword ptr [esi+2]
		mov al,gArray[5]  
		nop 
		mov ax,gArraySI 
		lea esi,gArraySI  
		mov dl, byte ptr [esi]  
		mov edx, dword ptr [esi+2]  
		mov ax,gArraySI[5] 
		nop 
		mov eax,gArrayI   
		lea esi,gArrayI 
		mov dl, byte ptr [esi]   
		mov edx, dword ptr [esi+2] 
		mov eax,gArrayI[5] 
		nop
		return 0;
	}

	int main(int argc, char *argv[]){
		test();
	}
