#!/bin/bash
echo "🧪 Testing pipex..."

# Cleanup
rm -f test*.txt out*.txt shell*.txt pipex*.txt

# Basic setup
echo "Hello World" > test1.txt
echo -e "line1\nline2\nline3" > test2.txt

# Run tests
echo "Test 1: Basic functionality"
./pipex test1.txt "cat" "wc -l" out1.txt
echo "Result: $(cat out1.txt) (expected: 1)"

echo "Test 2: Multiple lines"
./pipex test2.txt "cat" "wc -l" out2.txt
echo "Result: $(cat out2.txt) (expected: 3)"

echo "Test 3: Shell comparison"
< test2.txt cat | wc -w > shell.txt
./pipex test2.txt "cat" "wc -w" pipex.txt
if diff shell.txt pipex.txt > /dev/null; then
    echo "✅ Shell comparison PASSED"
else
    echo "❌ Shell comparison FAILED"
fi

echo "🎉 Tests completed!"