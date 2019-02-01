#include <iostream>
#include <typeinfo>
#include <iomanip>

int main(){
    std::cout << "This is a simple C++ program!\n";
    using namespace std;
    cout << "There is no need for std:: after using namespace\n";
    cout << "    *    \n" << "   ***   \n"
         << "  *****  \n" << " ******* \n";
    cout << -3000000000 << '\n';
    int x{10};
    cout << x << '\n';
    cout << "AB\bCD\aEF" << '\n';
    cout << "a\rb\n";
    cout << "\r\n";
    enum Animals {
        Dog,
        Cat,
        Cow,
        Monkey
    };
    Animals myAnimal = Cow;
    cout << myAnimal << '\n';
    auto cnt = 1;
    auto ch = 'A';
    char ch_2 = 0;
    cout << "cnt = " << cnt << " and cnt is type of " << typeid(cnt).name() << '\n';
    cout << "ch = " << ch << " and ch is type of " << typeid(ch).name() << '\n';
    for (int i = 0;i < 127; i++) {
        cout << ch_2 << " ";
        ch_2 += 1;
    }
    cout << '\n';
    enum class Animals_2 {
        Fox,
        Elephant,
        Deer,
        Lion,
        Tiger
    };
    cout << static_cast<int>(Animals_2::Deer) << " "
         << static_cast<int>(Animals_2::Fox) << '\n';
    double pi = 3.141592;
    cout << setprecision(3) << pi << '\n';
    cout << setprecision(5) << pi << '\n';
    int x1 = 1, y1 = 10, x2 = 130, y2 = 150;
    cout << "origin\n";
    cout << "x1 = " << x1 <<" | y1 = " << y1 << " | x2 = " << x2 << " | y2 = " << y2 << '\n';
    y1 = x1++;
    cout << "After x++\n";
    cout << "x1 = " << x1 <<" | y1 = " << y1 << " | x2 = " << x2 << " | y2 = " << y2 << '\n';
    y2 = ++x2;
    cout << "After ++x2\n";
    cout << "x1 = " << x1 <<" | y1 = " << y1 << " | x2 = " << x2 << " | y2 = " << y2 << '\n';
    /* for the sake of saving running time
    int input, sum = 0;
    while (cin >> input)
        sum += input;
    cout << "Sum = " << sum << '\n';
    */
    cout << setw(3) << 1 << '\n';
}