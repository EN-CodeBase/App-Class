# App-Tool-C++

A tool for creating C++ applications. It simplifies compilation by handling binaries and `.cpp` files.

The name of the app will be taken from the parent folder name.

## Important Files

- **main.cpp** – The main file that runs the application. Change the stop condition as needed
- **App.h** – The application header file.  
- **AppImpl/Update.cpp** – The file where you define the update sequence.

---

# AppImpl

1. All application functionality should reside in this folder.  
2. `Update.cpp` must be included in this folder.  
3. `AppImpl/bin` should store all binaries.

---


# App-Class

```C

App::Start(); // starts the app and its main loop

// Stop condition here

App::Stop(); // stops the app completely and ends program

```

---

# Compilation

Open a terminal and run:

```sh
.\CompileMe
```
This will generate:

AppName.exe

This is the main executable of the app.
Important: AppName is the name of the parent folder.

# Upcoming Features

- Support for Linux and macOS
- Latency and Clock Speed controll
- Error Handling

