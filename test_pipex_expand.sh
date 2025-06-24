#!/bin/bash
echo "🧪 Testing pipex - Extended version..."

# Colors voor output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Cleanup
rm -f test*.txt out*.txt shell*.txt pipex*.txt

# Test files setup  
echo -e "apple\nbanana\ncherry\napricot\navocado" > fruits.txt
echo -e "line1 a1 test\nline2 b2 data\nline3 a1 more\nline4 c3 info" > data.txt
ls -la > dirlist.txt

echo "${YELLOW}=== BASIC FUNCTIONALITY TESTS ===${NC}"

# Test 1: Exact example from subject
echo "Test 1: ls -l | wc -l"
./pipex dirlist.txt "ls -l" "wc -l" out1.txt
< dirlist.txt ls -l | wc -l > shell1.txt
if diff out1.txt shell1.txt > /dev/null; then
    echo "${GREEN}✅ Test 1 PASSED${NC}"
else
    echo "${RED}❌ Test 1 FAILED${NC}"
    echo "Pipex: $(cat out1.txt)"
    echo "Shell: $(cat shell1.txt)"
fi

# Test 2: Exact example from subject  
echo "Test 2: grep a1 | wc -w"
./pipex data.txt "grep a1" "wc -w" out2.txt
< data.txt grep a1 | wc -w > shell2.txt
if diff out2.txt shell2.txt > /dev/null; then
    echo "${GREEN}✅ Test 2 PASSED${NC}"
else
    echo "${RED}❌ Test 2 FAILED${NC}"
    echo "Pipex: $(cat out2.txt)"
    echo "Shell: $(cat shell2.txt)"
fi

# Test 3: Complex command with flags
echo "Test 3: cat -e | grep $"
./pipex fruits.txt "cat -e" "grep $" out3.txt
< fruits.txt cat -e | grep '$' > shell3.txt
if diff out3.txt shell3.txt > /dev/null; then
    echo "${GREEN}✅ Test 3 PASSED${NC}"
else
    echo "${RED}❌ Test 3 FAILED${NC}"
fi

echo "${YELLOW}=== ERROR HANDLING TESTS ===${NC}"

# Test 4: Non-existent input file
echo "Test 4: Non-existent input file"
./pipex nonexistent.txt "cat" "wc -l" out4.txt 2>/dev/null
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
    echo "${GREEN}✅ Test 4 PASSED (correct exit code: $EXIT_CODE)${NC}"
else
    echo "${RED}❌ Test 4 FAILED (should fail with non-zero exit)${NC}"
fi

# Test 5: Invalid command
echo "Test 5: Invalid first command"
./pipex fruits.txt "invalidcmd" "wc -l" out5.txt 2>/dev/null
EXIT_CODE=$?
if [ $EXIT_CODE -eq 127 ]; then
    echo "${GREEN# Maak dit script: test_pipex.sh second command  
echo "Test 6: Invalid second command"
./pipex fruits.txt "cat" "invalidcmd" out6.txt 2>/dev/null
EXIT_CODE=$?
if [ $EXIT_CODE -eq 127 ]; then
    echo "${GREEN}✅ Test 6 PASSED (exit code 127)${NC}"
else
    echo "${RED}❌ Test 6 FAILED (expected exit code 127, got $EXIT_CODE)${NC}"
fi

echo "${YELLOW}=== EDGE CASES ===${NC}"

# Test 7: Empty file
touch empty.txt
echo "Test 7: Empty input file"
./pipex empty.txt "cat" "wc -l" out7.txt
< empty.txt cat | wc -l > shell7.txt
if diff out7.txt shell7.txt > /dev/null; then
    echo "${GREEN}✅ Test 7 PASSED${NC}"
else
    echo "${RED}❌ Test 7 FAILED${NC}"
fi

# Test 8: Command with multiple arguments
echo "Test 8: Commands with multiple flags"
./pipex fruits.txt "grep -v apple" "sort -r" out8.txt
< fruits.txt grep -v apple | sort -r > shell8.txt
if diff out8.txt shell8.txt > /dev/null; then
    echo "${GREEN}✅ Test 8 PASSED${NC}"
else
    echo "${RED}❌ Test 8 FAILED${NC}"
fi

echo "${YELLOW}=== CLEANUP ===${NC}"
rm -f test*.txt out*.txt shell*.txt pipex*.txt fruits.txt data.txt dirlist.txt empty.txt

echo "🎉 All tests completed!"