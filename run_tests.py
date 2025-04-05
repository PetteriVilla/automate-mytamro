#!/usr/bin/env python3

import os
import sys
import subprocess
import time
from pathlib import Path
import venv

# ANSI colors for terminal output
class Colors:
    GREEN = '\033[92m'
    BLUE = '\033[94m'
    RED = '\033[91m'
    ENDC = '\033[0m'

def clear_screen():
    """Clear the terminal screen."""
    os.system('cls' if os.name == 'nt' else 'clear')

def show_menu():
    """Display the main menu."""
    clear_screen()
    print(f"{Colors.BLUE}================ MyTamro Test Runner ================={Colors.ENDC}")
    print("1: Run 'Valid Login' test")
    print("2: Run all tests")
    print("Q: Quit")
    print(f"{Colors.BLUE}=================================================={Colors.ENDC}")

def get_venv_python():
    """Get the path to the virtual environment Python executable."""
    if os.name == 'nt':  # Windows
        return str(Path(".venv") / "Scripts" / "python.exe")
    return str(Path(".venv") / "bin" / "python")

def get_venv_pip():
    """Get the path to the virtual environment pip executable."""
    if os.name == 'nt':  # Windows
        return str(Path(".venv") / "Scripts" / "pip.exe")
    return str(Path(".venv") / "bin" / "pip")

def install_requirements():
    """Install requirements using pip."""
    print("Installing requirements...")
    try:
        pip_path = get_venv_pip()
        subprocess.run([pip_path, "install", "-r", "requirements.txt"], check=True)
        print(f"{Colors.GREEN}Requirements installed successfully!{Colors.ENDC}")
    except subprocess.CalledProcessError as e:
        print(f"{Colors.RED}Error installing requirements: {e}{Colors.ENDC}")
        sys.exit(1)

def activate_venv():
    """Create and activate virtual environment if it doesn't exist."""
    venv_path = Path(".venv")
    
    if not venv_path.exists():
        print("Virtual environment not found. Creating one...")
        venv.create(".venv", with_pip=True)
        install_requirements()
    else:
        # Verify robot framework is installed
        try:
            python_path = get_venv_python()
            result = subprocess.run([python_path, "-c", "import robot"], capture_output=True, text=True)
            if result.returncode != 0:
                print("Robot Framework not found in existing virtual environment. Installing requirements...")
                install_requirements()
        except subprocess.CalledProcessError:
            print("Checking virtual environment failed. Reinstalling requirements...")
            install_requirements()

def check_env_file():
    """Check if .env file exists, create from template if it doesn't."""
    if not os.path.exists(".env"):
        print("'.env' file not found. Creating from template...")
        if os.path.exists(".env.example"):
            with open(".env.example", "r") as example, open(".env", "w") as env:
                env.write(example.read())
            print(f"{Colors.RED}Please edit the '.env' file with your credentials before running tests.{Colors.ENDC}")
            sys.exit(1)
        else:
            print(f"{Colors.RED}'.env.example' file not found. Cannot create '.env' file.{Colors.ENDC}")
            sys.exit(1)

def run_robot_test(test_name=None):
    """Run Robot Framework test."""
    try:
        python_path = get_venv_python()
        robot_path = str(Path(".venv") / "bin" / "robot") if os.name != "nt" else str(Path(".venv") / "Scripts" / "robot.exe")
        
        if not os.path.exists(robot_path):
            print(f"{Colors.RED}Robot executable not found. Reinstalling requirements...{Colors.ENDC}")
            install_requirements()
        
        if test_name:
            subprocess.run([robot_path, "-t", test_name, "tests/login_test.robot"], check=True)
        else:
            subprocess.run([robot_path, "tests/login_test.robot"], check=True)
    except subprocess.CalledProcessError as e:
        print(f"{Colors.RED}Error running test: {e}{Colors.ENDC}")
    except FileNotFoundError:
        print(f"{Colors.RED}Robot Framework not found. Please ensure virtual environment is properly set up.{Colors.ENDC}")
    
    input("\nPress Enter to continue...")

def main():
    """Main function to run the test menu."""
    try:
        # Ensure we're in the correct directory
        script_dir = os.path.dirname(os.path.abspath(__file__))
        os.chdir(script_dir)
        
        # Setup environment
        activate_venv()
        check_env_file()

        while True:
            show_menu()
            choice = input("Please make a selection: ").strip().lower()

            if choice == '1':
                print(f"{Colors.GREEN}Running 'Valid Login' test...{Colors.ENDC}")
                run_robot_test("Valid Login")
            elif choice == '2':
                print(f"{Colors.GREEN}Running all tests...{Colors.ENDC}")
                run_robot_test()
            elif choice == 'q':
                print("Exiting...")
                break
            else:
                print("Invalid selection. Please try again.")
                time.sleep(2)

    except KeyboardInterrupt:
        print("\nExiting...")
        sys.exit(0)
    except Exception as e:
        print(f"{Colors.RED}An error occurred: {e}{Colors.ENDC}")
        sys.exit(1)

if __name__ == "__main__":
    main()