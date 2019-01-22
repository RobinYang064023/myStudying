package main

import ("fmt"
	"math")

func swap (x int, y int) int {
	tmp := x
	x = y
	y = tmp
	fmt.Printf("a is %d, b is %d in swap())\n", x, y)
	return tmp
}

func swap_by_reference(x *int, y *int){
	var tmp int
	tmp = *x
	*x = *y
	*y = tmp
	fmt.Printf("a is %d, b is %d in swap())\n", *x, *y)
}


func get_square_root (x float64) float64{
	return math.Sqrt(x)
}

func get_fibnacci() func() int {
	var a, b int = 0, 1
	return func() int {
		tmp := b
		b += a
		a = tmp
		return a
	}
}

type Square struct {
	x, y, edge float64
}

func(square Square) get_diagonal() float64 {
	return math.Sqrt(math.Pow(square.edge, 2) * 2)
}

func main(){
	//call by value
	a := 10
	b := 20
	fmt.Printf("a = %d, b = %d\n", a, b)
	swap(a, b)
	fmt.Printf("a = %d, b = %d\n", a, b)
	//call by reference
	a = 10
	b = 20
	fmt.Printf("a = %d, b = %d\n", a, b)
	swap_by_reference(&a, &b)
	fmt.Printf("a = %d, b = %d\n", a, b)
	//func as value
	fmt.Println(get_square_root(16))
	//func as closure
	fib_next_number1 := get_fibnacci()
	fmt.Println(fib_next_number1())
	fmt.Println(fib_next_number1())
	fmt.Println(fib_next_number1())
	fmt.Println(fib_next_number1())
	fmt.Println(fib_next_number1())
	fmt.Println(fib_next_number1())
	fmt.Println(fib_next_number1())
	fib_next_number2 := get_fibnacci()
	fmt.Println(fib_next_number2())
	fmt.Println(fib_next_number2())
	fmt.Println(fib_next_number2())
	fmt.Println(fib_next_number2())
	//func as method
	square1 := Square{x:0, y:0, edge:9}
	fmt.Printf("Square's diagonal are %f", square1.get_diagonal())
}
