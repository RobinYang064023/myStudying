package main

import "fmt"

func main() {
	var x int
	var y float64 = 12.0
	var z, i, j = 20, 38.3, "i am string."
	k := 16.4

	fmt.Printf("x is of type %T\n", x)
	fmt.Println(y)
	fmt.Printf("y is of type %T\n", y)
	fmt.Println(z)
	fmt.Printf("z is of type %T\n", z)
	fmt.Println(i)
	fmt.Printf("i is of type %T\n", i)
	fmt.Println(j)
	fmt.Printf("j is of type %T\n", j)
	fmt.Println(k)
	fmt.Printf("k is of type %T\n", k)
}
