#include <iostream>
#include <chrono>

#include "App.h"

int main(){

    // start the App
    App::Start();


    // wait for stop condition
    std::cin.get();

    // stop
    App::Stop();

    return 0;
}