# funcy-containers
Develop Azure Python functions using several workflows:

| Workflow | Python is Installed | Function is Executed | F5/Debug Experience Supported | 
| -------- | ------------------- | -------------------- | ----------------------- |
| VsCode Remote-Containers | Container | Container | Yes |
| Local development (host) | Host | Host | Yes |

NOTE: The hot-reload workflow was removed but incorporated into the VsCode Remote-Containers workflow. 

# Workflow: VsCode Remote-Containers (Recommended Workflow)
The following Visual Studio extensions must be installed first:

1. ms-vscode-remote.remote-containers

To start working in the container, from VsCode: 

1. Press Ctrl+Shift+P to bring up the palette
2. Select Dev Containers: Open Folder In Container...
3. Select the root of this repository.

You are now developing 'in' the container. If this is the first time running, you will be prompted by VsCode to 'Show Logs' - this will show the progress of containers being fetched and started.  

### Check that VsCode recognised the Tasks
There appears to be an error on Windows hosts with WSL2 (could not verify on Linux) whereby tasks.json is parsed by VsCode when opening a folder in Remote Containers but before the Azure Functions extension is installed. This seems to happen the first time the containers are built/created; but not on subsequent reconnections. 

Check the Output Tab. If you see an error like this (I see it every time on Windows with WSL2):

![func-task-type-not-registered](docs/func-task-type-not-registered.png)

...you will need to Close the Remote Connection (Ctrl+Shift+P; Remote: Close Remote Connection) and then re-open the folder (Ctrl+Shift+P; Dev Containers: Reopen in Container). If you do not do this, you will see this error when you press F5:

![func-debug-error](docs/func-debug-error.png)

You should perform this check every time your application starts but I have only seen it on the first use and only on Windows using WSL2. 

### Debugging (F5 experience)
To launch the Azure Function under the Debugger, just press F5. 

Set a breakpoint in __init__.py and then invoke the function:

```
curl http://localhost:7071/api/funcy-python
```

### Hot reload
When source code changes, we want to automatically restart the function. There are complications to doing this on Windows with WSL2 (see references below); as a workaround (there are several) we can use nodemon to 'poll' the file system (--legacy-watch) and restart the function if the source code changes. 

To install nodemon as its dependencies:

```
apt-get update
apt-get install -y npm
npm install -g nodemon
```

To use the hot reload workflow within the container:

```
nodemon -w funcy-python/*py -w funcy-python/function.json --legacy-watch --exec "func host start --verbose"
```

### Python Virtual Environments
Python Virtual Environments are not required for this use case. 


# Workflow: Local development (host)
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

# References
| Reference | Link | 
| -- | -- |
| Add --watch support to func start | https://github.com/Azure/azure-functions-core-tools/issues/1239#issue-437771257 |
| File changes on Windows doe not trigger notifications in Linux apps | https://github.com/microsoft/WSL/issues/4739 |
