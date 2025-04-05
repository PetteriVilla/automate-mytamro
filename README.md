# MyTamro Automation Framework

This automation framework is built using Robot Framework to automate MyTamro portal interactions. It provides automated testing capabilities for the MyTamro login process and other functionalities.

## Prerequisites

- Python 3.8 or newer
- Google Chrome browser
- Mac OS (for other operating systems, adjust browser settings accordingly)

## Installation

1. Create and activate a Python virtual environment:
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   ```

2. Install the required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Initialize the Browser library:
   ```bash
   rfbrowser init
   ```

## Configuration

1. Create a `.env` file based on the template:
   ```bash
   cp .env.example .env
   ```

2. Edit the `.env` file with your MyTamro credentials:
   ```
   MYTAMRO_USERNAME=your_username
   MYTAMRO_PASSWORD=your_password
   ```

## Project Structure

```
.
├── README.md
├── requirements.txt
├── tests/
│   └── login_test.robot
└── resources/
    └── login_keywords.robot
```

## Running Tests

To run all tests:
```bash
robot tests/
```

To run a specific test file:
```bash
robot tests/login_test.robot
```

### Test Options

- Run tests with specific tags:
  ```bash
  robot -i smoke tests/
  ```

- Generate custom output directory:
  ```bash
  robot --outputdir results tests/
  ```

- Run tests in headless mode (add to test file's Suite Setup):
  ```robotframework
  Open Browser    about:blank    chrome    options=add_argument("--headless")
  ```

## Test Reports

Robot Framework automatically generates several report files after test execution:

- `report.html` - The main test report with statistics and results
- `log.html` - Detailed test execution log
- `output.xml` - Raw test data in XML format

These files are created in the directory where you run the tests, or in the specified output directory.

## Writing Tests

### Basic Test Structure
```robotframework
*** Settings ***
Documentation     Test suite description
Resource          ../resources/keywords.robot

*** Test Cases ***
Example Test
    [Documentation]    Test case description
    [Tags]    tag1    tag2
    Step 1 Keyword
    Step 2 Keyword    ${parameter}
```

### Using Custom Keywords
Custom keywords are defined in resource files under the `resources/` directory. Example:
```robotframework
*** Keywords ***
Input Username
    [Arguments]    ${username}
    Input Text    id=userNameInput    ${username}
```

## Troubleshooting

1. **Browser Issues**
   - Ensure Chrome is installed
   - Try updating Chrome to the latest version
   - Check if webdriver is properly initialized

2. **Authentication Issues**
   - Verify credentials in `.env` file
   - Check if environment variables are properly loaded
   - Ensure you have proper access rights to MyTamro

3. **Test Failures**
   - Check the generated log.html for detailed error messages
   - Verify selectors in login_keywords.robot match the current UI
   - Ensure stable internet connection

## Best Practices

1. Always use resource files for reusable keywords
2. Maintain proper documentation for tests and keywords
3. Use tags to organize and categorize tests
4. Keep sensitive data in environment variables
5. Regular updates of dependencies
6. Version control of test scripts

## Contributing

1. Follow the existing code structure
2. Add proper documentation for new tests
3. Update README.md with new features or changes
4. Test your changes before committing

## Security Notes

- Never commit `.env` file with real credentials
- Keep your credentials secure
- Use environment variables for sensitive data 