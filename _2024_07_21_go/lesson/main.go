package main

import (
	"errors"
	"fmt"
)

func main() {
	printME("Hello, World!")

	fmt.Println(intDivision(4, 2))
	var res, rem, err = intDivisionDetailed(4, 0)
	// If statement
	if err != nil {
		fmt.Println(err)
	} else { // else need to be in the same line as }
		fmt.Println(res, rem)
	}

	var res1, rem1, err1 = intDivisionDetailed(4, 0)

	// Switch statement
	switch {
	case err1 != nil:
		fmt.Println(err1)
	case rem1 == 0:
		fmt.Printf("Result of the integer division is %v", res1)
	case rem1 != 0:
		fmt.Printf("Result of the integer division is %v with reminder %v", res1, rem1)
	default:
		fmt.Printf("Result of the integer division is %v with reminder %v", res1, rem1)

	}

}

// Function Declaration
func printME(s string) { // Curly braces need to be on the same line
	fmt.Println(s)
}

func intDivision(a int, b int) int { // int is the return type
	var result int = a / b
	return result
}
func intDivisionDetailed(a int, b int) (int, int, error) { // int is the return type
	// error is the return type
	var err error = nil
	if b == 0 {
		err = errors.New("cannot divide by zero")
		return 0, 0, err
	}
	var result = a / b
	var remainder = a % b

	return result, remainder, err
}
