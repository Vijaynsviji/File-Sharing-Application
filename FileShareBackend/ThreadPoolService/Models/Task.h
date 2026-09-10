//
// Created by VijayNSadashiva on 24-07-2026.
//
#pragma once
// #ifndef FILESHAREBACKEND_TASK_H
// #define FILESHAREBACKEND_TASK_H

#include <functional>
#include <iostream>
#include <string>


class Task {
private:
    std::string taskName;
    std::function<void()> executeTaskCallback;

public:
    Task(std::string taskName, std::function<void()> executeTask) {
        this->taskName = taskName;
        this->executeTaskCallback = executeTask;
    }

    void executeGivenTask() {
        if (this->executeTaskCallback) {
            this->executeTaskCallback();
        }
    }
};

// #endif //FILESHAREBACKEND_TASK_H