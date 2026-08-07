//
// Created by VijayNSadashiva on 24-07-2026.
//

#pragma once
// #ifndef FILESHAREBACKEND_THREADPOOL_H
// #define FILESHAREBACKEND_THREADPOOL_H
#include <condition_variable>
#include <queue>
#include <thread>
#include<vector>
#include "Models/Task.h"

class ThreadPool {
private:
    std::queue<Task> taskQueue;
    std::vector<std::thread> threadArray;
    std::mutex threadMutex;
    std::condition_variable thread_condition_variable;

    bool isShutDown = false;
public:
    ThreadPool();

    void addTask(Task task);
    void ExecuteTask();
    void shutDownPool();
};

// #endif //FILESHAREBACKEND_THREADPOOL_H