// main file
#include <iostream>
#include <string>
#include <variant>

int main() {
    std::variant<int, double> myVar = 42; // can hold either int or double
    if (std::holds_alternative<int>(myVar)) {
        std::cout << "The variant holds an int: " << std::get<int>(myVar) << std::endl;
    } else if (std::holds_alternative<double>(myVar)) {
        std::cout << "The variant holds a double: " << std::get<double>(myVar) << std::endl;
    }
    return 0;
}
