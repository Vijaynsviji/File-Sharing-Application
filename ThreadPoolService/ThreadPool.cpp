//
// Created by VijayNSadashiva on 24-07-2026.
//

#include <iostream>
#include "ThreadPool.h"

void ThreadPool::addTask(Task task) {
    std::unique_lock<std::mutex> lock(this->threadMutex);
    this->taskQueue.push(task);
    lock.unlock();
    this->thread_condition_variable.notify_one();
}

void ThreadPool::ExecuteTask() {

    while (true) {
        std::unique_lock<std::mutex> lock(this->threadMutex);
        this->thread_condition_variable.wait(lock,[&](){
            return this->taskQueue.size() != 0 || this->isShutDown;
        });
        if (isShutDown && taskQueue.size() == 0) {
            lock.unlock();
            break;
        }
        Task& task = this->taskQueue.front();
        this->taskQueue.pop();
        lock.unlock();
        this->thread_condition_variable.notify_one();
        task.executeGivenTask();
    }

}

void ThreadPool::shutDownPool() {
    std::unique_lock<std::mutex> lock(this->threadMutex);
    this->isShutDown = true;
    lock.unlock();
    this->thread_condition_variable.notify_all();
}

