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
    int numToks = brackets.length();
    int nums[numToks];
    std::transform(brackets.begin(), brackets.end(), nums,
      [](char c) -> int { return(c == '(' ? 1 : -1); } );
    int pos = 0;
    for (int floor = 0; floor != -1; pos++)
      floor += nums[pos];
    std::cout << pos << std::endl;
  } else {
    std::cout << "Oops" << std::endl;
  }
}
