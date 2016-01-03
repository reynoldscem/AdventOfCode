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
      int numToks = brackets.length();
      int nums[numToks];
      std::transform(brackets.begin(), brackets.end(), nums,
        [](char c) -> int { return(c == '(' ? 1 : -1); }
      );
      int pos = 0;
      for (int floor = 0; floor != -1; pos++)
        floor += nums[pos];
      std::cout << pos << "\n";
      return 0;
    } else {
      std::cout << "File could not be opened for reading.\n";
      return -1;
    }
  } else {
    std::cout << "Valid input file from AdventOfCode required as first argument.\n";
    return -1;
  }
}
