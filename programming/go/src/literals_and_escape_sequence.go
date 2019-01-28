package main

import "fmt"

func main() {
	fmt.Println("Let's use fmt.Println first. Some of them will fail, so I comment them.\n")
	fmt.Println("legal integer literals are 4651, 3215u, 5464l, 321U, 0x1234, 043, 0xFeeL\n")
	//fmt.Println("illegal integer literals are 097(9 isn't an oct), 0xR12(R isn't hex), 456R, 1235UU, 1265LL\n")
	fmt.Println("legal floating-point literals are 3.141592, 314159E-5L, 7926E-9L, 123E2\n")
	fmt.Println("\\\\ is \\.\n")
	//fmt.Println("\\\' is \'.\n")
	fmt.Println("\\\" is \".\n")
	//fmt.Println("\\\? is \?.\n")
	//fmt.Println("\\a is \a.\n")
	fmt.Println("\\b is \b.\n")
	fmt.Println("\\f is \f.\n")
	fmt.Println("\\n is \n.\n")
	fmt.Println("\\r is \r.\n")
	fmt.Println("\\t is \t.\n")
	//fmt.Println("\\v is \v.\n")
	fmt.Println("\\26 is \013.\n")
	fmt.Println("\\x56 is \x56.\n")

	fmt.Printf("\nNow, We use fmt.Printf method to print\n.")
	fmt.Printf("legal integer literals are 4651, 3215u, 5464l, 321U, 0x1234, 043, 0xFeeL\n")
	fmt.Printf("illegal integer literals are 097(9 isn't an oct), 0xR12(R isn't hex), 456R, 1235UU, 1265LL\n")
	fmt.Printf("legal floating-point literals are 3.141592, 314159E-5L, 7926E-9L, 123E2\n")
	fmt.Printf("\\\\ is \\.\n")
	//fmt.Printf("\\\' is \'.\n")
	fmt.Printf("\\\" is \".\n")
	//fmt.Printf("\\\? is \?.\n")
	//fmt.Printf("\\a is \a.\n")
	fmt.Printf("\\b is \b.\n")
	fmt.Printf("\\f is \f.\n")
	fmt.Printf("\\n is \n.\n")
	fmt.Printf("\\r is \r.\n")
	fmt.Printf("\\t is \t.\n")
	fmt.Printf("\\v is \v.\n")
	fmt.Printf("\\26 is \013.\n")
	fmt.Printf("\\x56 is \x56.\n")
}
