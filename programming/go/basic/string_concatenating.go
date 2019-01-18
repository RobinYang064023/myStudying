package main

import ("fmt"
	"strings")

func main() {
	var a string = "123456"
	var b string = "234567"
	cat := []string{"12345","345678"}
	c := a + b
	fmt.Println(a+b)
	fmt.Println(c)
	fmt.Println(strings.Join(cat, " "))
}
