nasm -f elf64 main.asm -o Objects/main.o
nasm -f elf64 ../Files/string.asm -o Objects/string.o
nasm -f elf64 ../Files/io.asm -o Objects/io.o
nasm -f elf64 ../Files/allocate.asm -o Objects/allocate.o
nasm -f elf64 ../Files/ioConsole.asm -o Objects/ioConsoleio.o
gcc Objects/main.o Objects/string.o Objects/io.o Objects/ioConsoleio.o Objects/allocate.o -g -o Release/Program -m64 -no-pie
echo "Build file: Release/Program"

