/*
MIT License

Copyright (c) 2018 Xavier "Crashoz" Launey
*/

#pragma once

#include <random>
#include <string>
#include <limits>
#include <iostream>
#include <cstdint>
#include <memory>
#include <cstring>

namespace UUIDv4 {

class UUID {
public:
    UUID() {
        std::memset(data, 0, sizeof(data));
    }

    UUID(const UUID& other) {
        std::memcpy(data, other.data, sizeof(data));
    }

    UUID(uint64_t x, uint64_t y) {
        std::memcpy(data, &x, sizeof(x));
        std::memcpy(data + 8, &y, sizeof(y));
    }

    UUID(const uint8_t* bytes) {
        std::memcpy(data, bytes, sizeof(data));
    }

    /*
     * Builds an UUID from a byte string (16 bytes long)
     */
    explicit UUID(const std::string& bytes) {
        if (bytes.size() >= sizeof(data)) {
            std::memcpy(data, bytes.data(), sizeof(data));
        } else {
            std::memset(data, 0, sizeof(data));
            std::memcpy(data, bytes.data(), bytes.size());
        }
    }

    /*
     * Static factory to parse an UUID from its string representation
     */
    static UUID fromStrFactory(const std::string& s) {
        return fromStrFactory(s.c_str());
    }

    static UUID fromStrFactory(const char* raw) {
        UUID uuid;

        int byteIndex = 0;
        int nibble = -1;

        for (const char* p = raw; *p != '\0' && byteIndex < 16; ++p) {
            if (*p == '-') {
                continue;
            }

            uint8_t value;

            if (*p >= '0' && *p <= '9') {
                value = static_cast<uint8_t>(*p - '0');
            } else if (*p >= 'a' && *p <= 'f') {
                value = static_cast<uint8_t>(*p - 'a' + 10);
            } else if (*p >= 'A' && *p <= 'F') {
                value = static_cast<uint8_t>(*p - 'A' + 10);
            } else {
                continue;
            }

            if (nibble == -1) {
                nibble = value;
            } else {
                uuid.data[byteIndex++] =
                    static_cast<uint8_t>((nibble << 4) | value);
                nibble = -1;
            }
        }

        return uuid;
    }

    void fromStr(const char* raw) {
        *this = fromStrFactory(raw);
    }

    UUID& operator=(const UUID& other) {
        if (this != &other) {
            std::memcpy(data, other.data, sizeof(data));
        }

        return *this;
    }

    friend bool operator==(const UUID& lhs, const UUID& rhs) {
        return std::memcmp(lhs.data, rhs.data, sizeof(lhs.data)) == 0;
    }

    friend bool operator<(const UUID& lhs, const UUID& rhs) {
        return std::memcmp(lhs.data, rhs.data, sizeof(lhs.data)) < 0;
    }

    friend bool operator!=(const UUID& lhs, const UUID& rhs) {
        return !(lhs == rhs);
    }

    friend bool operator>(const UUID& lhs, const UUID& rhs) {
        return rhs < lhs;
    }

    friend bool operator<=(const UUID& lhs, const UUID& rhs) {
        return !(lhs > rhs);
    }

    friend bool operator>=(const UUID& lhs, const UUID& rhs) {
        return !(lhs < rhs);
    }

    /*
     * Serializes the UUID to a byte string (16 bytes)
     */
    std::string bytes() const {
        return std::string(
            reinterpret_cast<const char*>(data),
            sizeof(data)
        );
    }

    void bytes(std::string& out) const {
        out.assign(
            reinterpret_cast<const char*>(data),
            sizeof(data)
        );
    }

    void bytes(char* out) const {
        std::memcpy(out, data, sizeof(data));
    }

    /*
     * Converts UUID to its string representation.
     */
    std::string str() const {
        static constexpr char hex[] = "0123456789abcdef";

        std::string result;
        result.resize(36);

        int outputIndex = 0;

        for (int i = 0; i < 16; ++i) {
            if (i == 4 || i == 6 || i == 8 || i == 10) {
                result[outputIndex++] = '-';
            }

            result[outputIndex++] = hex[(data[i] >> 4) & 0x0F];
            result[outputIndex++] = hex[data[i] & 0x0F];
        }

        return result;
    }

    void str(std::string& out) const {
        out = str();
    }

    void str(char* out) const {
        static constexpr char hex[] = "0123456789abcdef";

        int outputIndex = 0;

        for (int i = 0; i < 16; ++i) {
            if (i == 4 || i == 6 || i == 8 || i == 10) {
                out[outputIndex++] = '-';
            }

            out[outputIndex++] = hex[(data[i] >> 4) & 0x0F];
            out[outputIndex++] = hex[data[i] & 0x0F];
        }
    }

    friend std::ostream& operator<<(std::ostream& stream, const UUID& uuid) {
        return stream << uuid.str();
    }

    friend std::istream& operator>>(std::istream& stream, UUID& uuid) {
        std::string s;
        stream >> s;
        uuid = fromStrFactory(s);
        return stream;
    }

    size_t hash() const {
        const uint64_t a = readUint64(data);
        const uint64_t b = readUint64(data + 8);

        return a ^ (b + 0x9e3779b9ULL + (a << 6) + (a >> 2));
    }

private:
    static uint64_t readUint64(const uint8_t* bytes) {
        uint64_t value = 0;

        std::memcpy(&value, bytes, sizeof(value));

        return value;
    }

    alignas(16) uint8_t data[16];
};


/*
 * Generates UUIDv4 from a provided random generator.
 */
template <typename RNG>
class UUIDGenerator {
public:
    UUIDGenerator()
        : generator(new RNG(std::random_device()())),
          distribution(
              (std::numeric_limits<uint64_t>::min)(),
              (std::numeric_limits<uint64_t>::max)()
          )
    {}

    UUIDGenerator(uint64_t seed)
        : generator(new RNG(seed)),
          distribution(
              (std::numeric_limits<uint64_t>::min)(),
              (std::numeric_limits<uint64_t>::max)()
          )
    {}

    UUIDGenerator(RNG& gen)
        : generator(std::shared_ptr<RNG>(&gen, [](RNG*) {})),
          distribution(
              (std::numeric_limits<uint64_t>::min)(),
              (std::numeric_limits<uint64_t>::max)()
          )
    {}

    UUID getUUID() {
        uint64_t high = distribution(*generator);
        uint64_t low = distribution(*generator);

        /*
         * UUID version 4:
         * version = 0100
         */
        high &= 0xFFFFFFFFFFFF0FFFULL;
        high |= 0x0000000000004000ULL;

        /*
         * UUID variant:
         * 10xxxxxx
         */
        low &= 0x3FFFFFFFFFFFFFFFULL;
        low |= 0x8000000000000000ULL;

        return UUID(low, high);
    }

private:
    std::shared_ptr<RNG> generator;
    std::uniform_int_distribution<uint64_t> distribution;
};

} // namespace UUIDv4


namespace std {

template <>
struct hash<UUIDv4::UUID> {
    size_t operator()(const UUIDv4::UUID& uuid) const {
        return uuid.hash();
    }
};

}