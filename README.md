# funcy-containers
Develop Azure Python functions using several workflows:

| Workflow | Python is Installed | Function is Executed | F5/Debug Experience Supported | 
| -------- | ------------------- | -------------------- | ----------------------- |
| Local development (host) | Host | Host | Yes |
| docker-compose direct | Container | Container | No |
| VsCode Remote-Containers | Container | Container | Yes |

## Workflow: Local development (host)
Tasks have been configured to support interactive debugging on the host. 

### Launching the function
To launch the function manually:

```
func host start --verbose
```

The function is "hot reload" by default on the host: it will automatically reload after changes to the function are saved. 

### Debugging (F5 experience)
To launch the Azure Function under the Debugger, just press F5. 

Set a breakpoint in __init__.py and then invoke the function:

```
curl http://localhost:7071/api/funcy-python
```

### Python Virtual Environments
Python Virtual Environments have been disabled for this project on the host. 

To enable it, in settings.json, add the following line:

```
"azureFunctions.pythonVenv": ".venv"
```

Then execute this command:

```
python -m venv .venv
```

## Workflow: docker-compose direct
Start the function in 'hot reload' mode with this command:

```
docker-compose -f docker-compose.yml -f docker-compose.hot-reload.yml up
```

Every time you save code changes, the function will automatically restart within the container. 

## Workflow: VsCode Remote-Containers (Recommended Workflow)
To start working in the container, from VsCode: 

1. Press Ctrl+Shift+P to bring up the palette
2. Select Open Folder...
3. Select the root of this repository.

You are now developing 'in' the container. Open up the Terminal (bash) to get a shell directly in the container. 

This provides an experience similar to developing on the host - except that all runtimes, debuggers and tools are running in containers. 

### Debugging (F5 experience)
To launch the Azure Function under the Debugger, just press F5. 

Set a breakpoint in __init__.py and then invoke the function:

```
curl http://localhost:7071/api/funcy-python
```

### Hot reload
File system notifications are not detected in WSL2. nodemon is used to 'poll' the filesystem for changes and restart the container. 

To use the hot reload workflow within the container:

```
nodemon -w funcy-python/*py -w funcy-python/function.json --legacy-watch --exec "func host start --verbose"
```

### Python Virtual Environments
Python Virtual Environments are not required for this use case. 
