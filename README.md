# Nemo

![d5637bf1cfcc06cd9ec22d4439387c24](https://github.com/user-attachments/assets/8c090dcb-2e63-46c7-be65-9afbd7bc3551)

**Nemo** is a Ruby script designed to generate iOS projects with a predefined structure and default files. It provides two key functionalities: 

- `-c` for creating a new iOS project.
- `-s` for adding a new scene to an existing project.

## Prerequisites

To use **Nemo**, you must have a Ruby version manager installed, such as:

- [chruby](https://github.com/postmodern/chruby)
- [rbenv](https://github.com/rbenv/rbenv)
- [RVM](https://rvm.io/)

The default version of Ruby on macOS is not supported.

## Installation

Clone the repository and navigate to the folder:

```bash
git clone https://github.com/your-username/nemo.git
cd nemo
chmod +x nemo
bundle install
```
Open a terminal and edit your shell configuration file (.zshrc) 
```bash
nano ~/.zshrc
```
Inside the .zshrc file, add your alias in the following format and save
```bash
alias nemo='path_to_script/bin/nemo'
```
Apply the changes by refreshing your shell configuration
```bash
source ~/.zshrc
```

## Usage

### Create a new iOS project
To generate a new iOS project, run the following command:
```bash
nemo -c ProjectName
```
This will create a new iOS project with the default structure and necessary files.

### Add a VIPER scene to an existing project
To add a VIPER scene to an already existing iOS project, use:
```bash
cd ProjectName
nemo -s SceneName
```
This command will add a new scene with all the VIPER layeres to the specified project.

## Contributing
If you'd like to contribute to Nemo, feel free to open an issue or submit a pull request.




