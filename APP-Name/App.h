#pragma once
#include <iostream>
#include <thread>
#include <atomic>

class App {
private:
    static std::atomic_bool running;
    static std::thread PrivateThread;

    static void ThreadMain() {
        while (running.load()) {
            Update();
        }
    }

public:

    static void Start() {
        running.store(true);
        PrivateThread = std::thread(ThreadMain);
    }

    static void Update();

    static void Stop() {
        running.store(false);
        if (PrivateThread.joinable())
            PrivateThread.join();
    }
};
