/*
 * App-Tool-C++
 * Copyright (c) 2026 Erli Nuraj
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

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
