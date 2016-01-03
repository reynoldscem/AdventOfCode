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
    std::cout << std::accumulate(nums, nums + numToks, 0, std::plus<int>()) << std::endl;
  } else {
    std::cout << "Oops" << std::endl;
  }
}
