# Routing

Requests goes to endpoints through plugs and then to the router (router.ex) then to the controller
and view.


Router takes path, module, function name as atome. This will then call the funtion that ends with render function, the second argument is the name of the html.heex file which then render it.
