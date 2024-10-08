From [youtube](youtu.be/IiIgm_yaoOA)


Elixir types are all immutable.

You can run interactive mode of elixir with iex in terminal.

Compiling elixir files is done automatically if extention is .ex but not if the extention is .exs (elixir script).
It can be compiled by using elixirc *name of the file*, with scand for elixir compile. Or from the interactive console using c "*filenale*", or recompile a module with r *module name*.

Modules are defined like:
defmodule *modulename* do
    def *functionname* do
        *code*
    end
end

Calling the functions inside the module can be done by adding a call to it after the *end* of the module
defmodule TestModule do
    def testfunc do
        IO.puts("Hello World)
    end
end
TestModule.testfunc // Bracjets are optional if no parameters are set.
Or it can be called through the iex by calling TestModule.testfunc.



Atoms can be declared using :*atomename* if the atome name have spaces then it should be initialized by :"*atomename*"


A common usecase in elixir is pattern matching:
inside iex:
:error
{:error, value} = {:error, "file not found}
value // will print "file not found"

:ok
{:ok, msg} = {:ok, "status 200 ok"}
msg // will pring "status 200 ok"


Strings are defined using double quotes:
name = "gaya"

Single quote are used for charated list:
charr = 'gaya'

in iex a really usefull command used to display information is the function i()
i("Gaya") will display a bunch of information about the value.

i('Gaya') will display different information than the previous command

The operator <> is the string concatonation operator
"G" <> name = "Gaya"
name // will print aya

the ? operator displays the raw representation of a value
?a // will pring 97

For lists we use ++ to concatonate two lists

is_list(value) to check if type is list

You cannot access values in list with an index in elixir, it is discouraged to do so.
To access a value with an index it is possible to use Enum.at(*list*, *index*)

To get help and see the documentation for a module and function we use the h() function.
t Enum.at // will print the documentation for at function

To ignore value in pattern matching use _:
[_,_, third] = ["a", "b", "c"]

The function head return the first element:
hd(list)

The function Tail return the remaining elements:
tl(list)

[ h | t] = list
The h is the first element and the t is the rest of the list.

Tuples are initialized like {1,2,3} 
{a, b} = {1, 2}

Keyword List 
data =  {a:1, b:2}
The key is stored as an atom, [{:a, 1}] = {a:1}

Maps:
my_map = %{a: 1, b: 2, c: 3}
%{a: first, b: second, c: third} = my_map
first // return 1
%{b: se} = my_map
value can be accessed like my_map.a // returns 1
if using none atome for key they the declaration should be like 
map2 = %{"a" => 1, "b" => 3}
%{"b" => b} = map2 // pattern matching with none atome maps
map2 = %{map2 | "b" => 4} //updating a value in a none atome map
my_map = %{my_map | c: 4} //updating a map that uses atoms

Structs:
To create a sctruct, a module need to be created
defmodule User do
    defstruct :username, :email, :age
    // can be used with parentheses 
    // defstruct(:username)
    // can be initialized
    // defstruct username: "", email: "", age: nil
end
Then to create Structs:
user1 = %User{username: "gaya", age: 27, email: "gaya@gaya.com"}
user1 = %{user1 | age: 21} // Modify the value of the struct

Flow Controle:

Case:
list= [1,2,3]
case Enum.at(list, 2) do
    1 -> "This won't print"
    3 -> "3 is a match!"
    _ -> "Catch all"
end
defmodule Post do
    defstruct(
        id: nil,
        title: "",
        description: "",
        author: ""
        )
end
post1 = %Post{id: 1, title: "Title no 1", author: "julius ceaser"}

case post1 do
    %{author: "Gaya"} -> "Got a post from Gaya"
    %{author: "ziad"} -> "Got a post from Ziad"
    _ -> "Got a post from #{post1.author}"
end

post1 = %{post1 | author: "Gaya"}


Cond:

cond do
    post1.author == "Gaya" -> "Editing a post from Octallium"
    post1.author == "Ziad" -> "Editing a post from Ziad"
    true -> "This is a catch all"
end

cond do
    hd(list) == 1 -> "Got a 1"
    true -> "Head is #{hd(list)}"
end

if/else: //not used often

if true do
    "This will fork"
else
    "Else this will work"
end


mix new *projectname* // to create a new elixir projectname

To start iex in the project:
iex -S mix

To create a single line function definition:
def *functionname*, do:
ex: def upto(0), do: 0

Tail Recursion:
  def downto(0), do: 0
  def downto(num) do
    IO.puts(num)
    downto(num - 1)
  end
  // 3, 2, 1
Head Recursion:
  def upto(0), do: 0
  def upto(num) do
    upto(num - 1)
    IO.puts(num)
  end
  // 1, 2, 3


lists are linked lists

@moduledoc """
""" // For documenting module should be below the module declaration

@doc """
Retturns the sum of the numbers in a List
""" // Documantation for a function, comes just before the funtion implementation

To specify types for function and return types:
@spec sum(list(number()), integer()) :: number()
def sum(nums, s \\ 0) // the \\ are for setting a default value in a function

div() // getting the result of the division as an int
rem() // getting the reminder of a division

Adding elements to a list is more efficient in the start of a list O(1) instead of the end of the list O(n)

annonimous functions are declared like:
double = fn x -> x * 2 end
calling them is done by calling *double.(2)* there has to be a dot


The pipe operator *|>* takes the output of a previous funtion and apply it to the next function:
Lists.map([1,2,3], fn x -> x * 2 end) |> Lists.reverse

[1,2,3,4,5,6] |> Lists.map(fn x -> x * 2 end) |> Enum.reverse // [2, 4, 6, 8, 10, 12]

Adding list together using *++* operator [1,2,3] ++ [4,5,6] // [1,2,3,4,5,6]

Private function are declared with *defp*

@spec func(list(), (any() -> list())) // you can declare anonimous funtions parameter type and return type with (*parameter type* -> *return type*)


in elixir there is a condition check in functions called *Guards* declared like so:

def *fuc*() when *condition*, do: .....















