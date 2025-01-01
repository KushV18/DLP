#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <string>
#include <vector>

using namespace std;

bool isValid(int noOfSymbol, const string& inputSymbols, int noOfState, int initialState, const unordered_set<int>& acceptingStates, const string& inputString) {
    // Check if the input string contains only valid symbols
    for (char c : inputString) {
        if (inputSymbols.find(c) == string::npos) {
            return false;
        }
    }

    // Transition table
    unordered_map<int, unordered_map<char, int>> transitionTable;

    // Input transition states
    for (int i = 0; i < noOfState; i++) {
        for (char symbol : inputSymbols) {
            cout << "Enter next state if current state is " << (i + 1) << " and input symbol is " << symbol << ": ";
            int tempState;
            cin >> tempState;
            transitionTable[i + 1][symbol] = tempState;
        }
    }

    // Process the input string
    int currentState = initialState;
    for (char symbol : inputString) {
        // Check if the current state has a transition for the given symbol
        if (transitionTable[currentState].find(symbol) != transitionTable[currentState].end()) {
            currentState = transitionTable[currentState][symbol];
        } else {
            // If no valid transition exists, the string is invalid
            return false;
        }
    }

    // Check if the final state is one of the accepting states
    return acceptingStates.find(currentState) != acceptingStates.end();
}

int main() {
    cout << "Enter number of input symbols: ";
    int noOfSymbol;
    cin >> noOfSymbol;
    cin.ignore(); // To ignore the newline character after the integer input

    cout << "Enter input symbols: ";
    string inputSymbols;
    getline(cin, inputSymbols);

    cout << "Enter number of states: ";
    int noOfState;
    cin >> noOfState;

    cout << "Enter initial state: ";
    int initialState;
    cin >> initialState;

    cout << "Enter number of accepting states: ";
    int noOfAcceptingStates;
    cin >> noOfAcceptingStates;

    unordered_set<int> acceptingStates;
    cout << "Enter accepting states: ";
    for (int i = 0; i < noOfAcceptingStates; i++) {
        int state;
        cin >> state;
        acceptingStates.insert(state);
    }

    cin.ignore(); // To ignore the newline character after the integer input
    cout << "Enter input string: ";
    string inputString;
    getline(cin, inputString);

    bool isValidString = isValid(noOfSymbol, inputSymbols, noOfState, initialState, acceptingStates, inputString);

    if (isValidString) {
        cout << "The input string is valid." << endl;
    } else {
        cout << "The input string is invalid." << endl;
    }

    return 0;
}