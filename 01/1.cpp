#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <numeric>

int main(int argc, char** argv) {
  if (argv[1] != NULL) {
    std::ifstream infile;
    infile.open(argv[1]);
    if (infile.is_open()) {
      std::string brackets;
      getline(infile, brackets);
      infile.close();
      std::cout <<
        std::accumulate(brackets.begin(), brackets.end(), 0,
          [](int acc, char c) -> int { return acc + (c == '(' ? 1 : -1); }
        );
      std::cout << '\n';
      return 0;
    } else {
      std::cout << "File could not be opening for reading.\n";
      return -1;
    }
  } else {
    std::cout << "Valid input file from AdventOfCode required as first argument.\n";
    return -1;
  }
}
