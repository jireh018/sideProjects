# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)


Note: 
This project will consist of:
 - a mix of declarative and custom development,
 - fields creation (if necessary),
 - Validation rules,
 - and more...

I like to start by thinking about the algorithm then write the simple code I can think of.
Then start the refactoring phase where I anaylze and check for codes that can be extracted into a new method, better way to implement features and testing each implementation/extraction using the 'Anonymous Window' in Developer Edition org.

Same goes for test classes, 
define all methods needed by testing best, worst cases scenarios and then refactoring code by extracting load data into a setup method or even utility class.

And I usually code from the 'Developer Console' Because of the real-time error check feature
