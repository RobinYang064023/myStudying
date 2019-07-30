package main

import "fmt"


func main(){
	var gg = "hello, 123!"
	fmt.Printf("This is origin:\n%s", gg)
	fmt.Printf("\n")
	fmt.Printf("This is hex form:\n%x", gg)
	fmt.Printf("\n")
	fmt.Printf("This is dec form(trigger a panic):\n%d", gg)
	fmt.Printf("\n")
	fmt.Printf("This is oct form(trigger a panic):\n%o", gg)
}
