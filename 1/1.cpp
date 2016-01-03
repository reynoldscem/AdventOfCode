#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <numeric>

int main(int ARGC, char** ARGV)
{
  std::ifstream infile;
  infile.open(ARGV[1]);
  if (infile.is_open()) {
    std::string brackets;
    getline(infile, brackets);
    infile.close();
    std::cout <<
      std::accumulate(brackets.begin(), brackets.end(), 0,
        [](int acc, char c) -> int { return acc + (c == '(' ? 1 : -1); }
      ) << "\n";
  } else {
    std::cout << "Oops\n";
  }
}
