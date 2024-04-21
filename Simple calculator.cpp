Here's the code without comments:

```cpp
#include <iostream>
#include <stack>
#include <string>
#include <sstream>
#include <cmath>

using namespace std;

bool isOperator(char c) {
    return c == '+' || c == '-' || c == '*' || c == '/' || c == '^';
}

int precedence(char op) {
    if(op == '^')
        return 3;
    else if(op == '*' || op == '/')
        return 2;
    else if(op == '+' || op == '-')
        return 1;
    else
        return -1;
}

string infixToPostfix(string infix) {
    stack<char> s;
    string postfix = "";

    for (char& c : infix) {
        if (isalnum(c))
            postfix += c;
        else if (c == '(')
            s.push(c);
        else if (c == ')') {
            while (!s.empty() && s.top() != '(') {
                postfix += s.top();
                s.pop();
            }
            s.pop();
        }
        else {
            while (!s.empty() && precedence(c) <= precedence(s.top())) {
                postfix += s.top();
                s.pop();
            }
            s.push(c);
        }
    }

    while (!s.empty()) {
        postfix += s.top();
        s.pop();
    }

    return postfix;
}

double evaluatePostfix(string postfix) {
    stack<double> s;

    for (char& c : postfix) {
        if (isalnum(c))
            s.push(c - '0');
        else {
            double operand2 = s.top();
            s.pop();
            double operand1 = s.top();
            s.pop();
            switch (c) {
                case '+':
                    s.push(operand1 + operand2);
                    break;
                case '-':
                    s.push(operand1 - operand2);
                    break;
                case '*':
                    s.push(operand1 * operand2);
                    break;
                case '/':
                    s.push(operand1 / operand2);
                    break;
                case '^':
                    s.push(pow(operand1, operand2));
                    break;
            }
        }
    }

    return s.top();
}

bool areParenthesesBalanced(string expression) {
    stack<char> s;
    for (char& c : expression) {
        if (c == '(')
            s.push(c);
        else if (c == ')') {
            if (s.empty() || s.top() != '(')
                return false;
            s.pop();
        }
    }
    return s.empty();
}

int main() {
    string input;
    cout << "Enter expressions (Ctrl+D to exit):" << endl;

    while (getline(cin, input)) {
        if (input.empty())
            continue;

        if (!areParenthesesBalanced(input)) {
            cout << "Error: Unbalanced parentheses!" << endl;
            continue;
        }

        string postfix = infixToPostfix(input);
        double result = evaluatePostfix(postfix);

        cout << "Output: " << result << endl;
    }

    return 0;
}
```