import random

def run_tests():
    # Simulate test results with random failures
    if random.randint(0, 10) > 7:
        print("Test failed!")
        exit(1)
    else:
        print("All tests passed!")

if __name__ == "__main__":
    run_tests()
