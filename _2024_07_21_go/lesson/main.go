package main

import (
	"fmt"
	"strconv"
	"unicode/utf8"
)

func main() {
	var intNum int8 = 127
	var intNum2 int16 = 32767
	var intNum3 int32 = 2147483647
	var intNum4 int64 = 9223372036854775807
	var intNum5 int = 2147483647
	fmt.Println("int8  " + string(intNum))
	fmt.Println("int16 " + string(intNum2))
	fmt.Println("int32 " + string(intNum3))
	fmt.Println("int64 " + string(intNum4))
	fmt.Println("int   " + string(intNum5))
	var floatNum float32 = 3.141592653589793
	var floatNum2 float64 = 3.141592653589793

	fmt.Println("float32 " + fmt.Sprint(floatNum))
	fmt.Println("float64 " + strconv.FormatFloat(floatNum2, 'f', -1, 64))
	//kk
	var intandfload float64 = float64(intNum) + floatNum2
	fmt.Println("int and float " + strconv.FormatFloat(intandfload, 'f', -1, 64))
	// division result is int
	var intdevint int = int(intNum) / int(intNum2)
	fmt.Println("int dev int " + string(intdevint))
	// modulo results in the reminder
	var intmodint int = int(intNum) % int(intNum2)
	fmt.Println("int mod int " + string(intmodint))
	var word string = "hello"
	fmt.Println(word)
	var word2 = "world \nHello"
	fmt.Println(word2)
	var word3 = `word 
	Hello`
	fmt.Println(word3)
	var word4 = "hello" + "world"
	fmt.Println(word4)
	// length in standard alphabet
	var len int = len("Hellooo")
	fmt.Println(len)

	// length in unicode
	var len2 int = utf8.RuneCountInString("Helloµ")
	fmt.Println(len2)

	// runes = char in c#
	var run rune = 'a'
	fmt.Println(run) //  >> 97

	// booleans
	var boo bool = true
	fmt.Println(boo)

	// Constants
	const cst = "hello"
	fmt.Println(cst)

	// Constants
	const cst1 string = "hello"
	fmt.Println(cst1)

	// Variable without var
	vr := "hello"
	fmt.Println(vr)

	// Multiple variables
	vr, vr2, vr3 := "hello", "hello2", "hello3"
	fmt.Println(vr + vr2 + vr3)
}
