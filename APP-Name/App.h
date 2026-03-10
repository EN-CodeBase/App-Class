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
#include <stdexcept>

class App {
private:
    static std::atomic_bool running;
    static std::thread AppThread;

    static void ThreadMain() {
        while (running.load()) {
            try{

                Update();

            } catch(const std::runtime_error& e) {
                std::cout << e.what() << std::endl; 
                // add runtime error handling
                
            } catch(const std::exception& e) {
                std::cout << e.what() << std::endl;
            }
        }
    }

public:

    static void Start() {
        running.store(true);

        App::Setup();

        AppThread = std::thread(ThreadMain);
    }

    static void Setup();

    static void Update();

    static void Stop() {
        running.store(false);
        if (AppThread.joinable())
            AppThread.join();
    }
};

