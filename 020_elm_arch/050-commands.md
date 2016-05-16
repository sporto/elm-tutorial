> WIP

# Commands

Commands are how we tell Elm to perform side effects in our application. For example making an http request to fetch users or changing the browser location. Your components will create commands as needed. 

When we create a command we are not actually executing them, they are just data at this point. These commands are run by the Elm runtime.