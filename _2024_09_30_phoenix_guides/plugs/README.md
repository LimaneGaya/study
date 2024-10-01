# Plugs

Plugs are an efficient and clan way to preprocess requests.


They can be used in endpoint, router, and controller.


They can be functions on arity of 2 (*conn* and *opts* as arguments) that returns conn, these can be used by adding **plug :function_name**


They can also be Modules, these need to have **init/1** which initializes any arguments or options to be passed to call/2 and **call/2** which does the corrections and returns the conn or assign/3 which adds data to the conn data structure.


Plugs in router are defined inside *pipeline* at the root of router and can be used inside pipes using *pipe_through*


Plugs in controllers gives us a feature to execute them only on specific cases. **plug HelloWeb.Plugs.Locale, "en" when action in [:index]** will only excecute when index action is invoked.


Plugs are usefull for composition, instead of writing a big fuctions with a lot of nester conditionals, 
you could use many Plug functions to controll the flow of the requests and using *halt(conn)* to tell plug to not run the other plugs if an error occures. This is much more readable and resusable.