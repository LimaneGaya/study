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

 


