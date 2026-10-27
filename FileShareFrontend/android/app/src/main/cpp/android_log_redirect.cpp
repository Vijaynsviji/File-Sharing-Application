//
// Created by VijayNSadashiva on 25-10-2026.
//


#include <android/log.h>
#include <unistd.h>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <mutex>
#include <string>
#include <thread>

namespace {

std::once_flag redirectFlag;

void consumeLogs(int fd, const char* tag, int priority) {
    char buffer[1024];
    std::string line;

    while (true) {
        ssize_t count = read(fd, buffer, sizeof(buffer));

        if (count < 0) {
            continue;
        }

        if (count == 0) {
            break;
        }

        for (ssize_t i = 0; i < count; ++i) {
            if (buffer[i] == '\n') {
                __android_log_write(
                    priority, tag, line.c_str()
                );
                line.clear();
            } else {
                line += buffer[i];

                // Keep messages below Android's log size limit.
                if (line.size() >= 3000) {
                    __android_log_write(
                        priority, tag, line.c_str()
                    );
                    line.clear();
                }
            }
        }
    }

    if (!line.empty()) {
        __android_log_write(priority, tag, line.c_str());
    }

    close(fd);
}

void redirectStream(int targetFd,
                    const char* tag,
                    int priority) {
    int pipeFds[2];

    if (pipe(pipeFds) != 0) {
        return;
    }

    if (dup2(pipeFds[1], targetFd) == -1) {
        close(pipeFds[0]);
        close(pipeFds[1]);
        return;
    }

    close(pipeFds[1]);

    std::thread(
        consumeLogs,
        pipeFds[0],
        tag,
        priority
    ).detach();
}

} // namespace

extern "C" __attribute__((visibility("default")))
void redirectCppLogsToLogcat() {
    std::call_once(redirectFlag, [] {
        std::fflush(stdout);
        std::fflush(stderr);

        redirectStream(
            STDOUT_FILENO,
            "CppStdout",
            ANDROID_LOG_INFO
        );

        redirectStream(
            STDERR_FILENO,
            "CppStderr",
            ANDROID_LOG_ERROR
        );

        // Flush cout output promptly, including newline-only writes.
        std::cout.setf(std::ios::unitbuf);
    });
}
