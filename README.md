# dnote-cli-utils
This repository includes some tiny bash scripts to create a working environment for dirary task management through the official [dnote-cli](https://github.com/dnote/dnote). The goal of these scripts is to facilitate the management of dirary tasks with a minimal infrastructure, just over a terminal. To achieve this goal, this software works with four `books`:

- `all-tasks` book includes all the tasks that must be performed.
- `today-tasks` book includes all the tasks that must be performed for today.
- `done-tasks` book includes all the tasks that have already been performed.
- `weekly-progress` book includes all the tasks that have been performed during the last week.

A task follows thus a lifecycle that makes to travel it through the different books. At the very beginning, a task is created in the `all-tasks` book. Once the user decides to assign the task, this one is moved to the `today-tasks` book. Lately, when the task is closed, this one is moved to the `done-tasks` and `weekly-progress` books. The following figure presents the lifecycle of a task in this schema.

FIGURE

As the previous figure presents, the tasks can also be moved backward. Specifically, if an assigned task cannot be closed in the corresponding day, it can be retracted to the `all-tasks` book. The same can be achieved with tasks that are closed in the `done-tasks` book, which can be opened again to the `all-tasks`.

`done-tasks` and `weekly-progress` books share some similarities, but they differ in a particular option. `done-tasks` is conceived to persistently keep all the tasks performed. However, `weekly-progress` book is a dynamic environment, in which the user can remove the tasks once they have already been evaluated (e.g. in a weekly progress meeting). 

Note that as the dnote-cli-utils works over dnote-cli, you can use it with a remote server or locally.

Each book follows a specific format that must be respected to have a correct behavior. Here you can find an example of the `all-tasks` with a single task:
```
Here you have all the tasks that you must accomplish:
#0 An example of a task 
```
The first line presents a brief description of the goal of the book, and **it must not be removed**. Every task that you you create must be determined by a specific identifier. This identifier is determined by the character '#' and a number. This task identifier must be different in each book, because it is used to move the tasks between the books. In the previous example, there is just one task that is identified by `#0`.

## Requirements
The scripts are implemented in bash, thus any Operative System that is able to execute bash can also work with dnote-cli-utils. Additionally, this software uses the official dnote-cli software. Therefore, you must install this command-line interface tool before installing the dnote-cli-utils. Here you will find the instructions to perform the installation. 

## Installation and Construction
These are the following steps to install the dnote-cli-utils:
```bash
git clone git@github.com:Noitty/dnote-cli-utils.git  # or any release version
cd dnote-cli-utils
sudo chmod +x install.sh
sudo ./install.sh
```
These steps installs the main scripts in `/opt/dnote-cli-utils` path, and create symbolik links in `/usr/bin` folder. After the installation, the different books must be created and configured. You can perform this by executing this instruction in the base project folder:
```bash
sudo chmod +x construct.sh
./construct.sh
```
This script creates all the books, and writes the file `~/.dnote-cli-utils/.env` which includes all the environment variables used in the main scripts.

## Main operations
A global view of the software has previously presented. Let's now evaluate how to perform all the actions. Four different binaries are installed to manipulate the tasks. These binaries follow the same name as the books (e.g. `all-tasks`, `today-tasks`, etc.) You can retrieve usage information of each binary by passing `--help` argument:
```bash
all-tasks --help
```
Although the different actions are presented in this usage information, following sections briefly presents these operations.

### View tasks of a book
To print all the content of a book, you just have to type its name:
```bash
done-tasks
```

### Edit a book
As in the dnote case, we can manipulate any book by using `edit` option or its alias `e`:
```bash
today-tasks edit
```
The default text editor configured in dnote is also used in this case. All editions are automatically synchronized with the configured remote server after the modification. 

### Synchronize a book
Although each modification is synchronized, you can also specifically synchronize the books by using `sync`option or its alias `s`:
```bash
weekly-progress sync
```

### Assign a task to `today-tasks` book
Once a new task is created by editing the `all-tasks` book, you can assign it to your `today-tasks` book. To do that, you must use `assign` option or its alias `a` of the `all-tasks` book. This action/option requires the (or a list of) identifier that corresponds to the task to be assigned. Here are some examples:
```bash
all-tasks assign 1 # it assigns task with identifier #1
all-tasks a 2 9 12 # it assigns the tasks #2, #9, and #12
```

### Close a task once it is finished
Once a task is finished, you can close and move it from the `today-tasks`. To perform it, you must use `close` option or its alias `c` of the `today-tasks` book. As in the assign case, you must indicate which tasks shall be closed. Here are some examples:
```bash
today-tasks close 56 # closes task #56
today-tasks c 5 14 7 # closes tasks #5, #14, and #7
```

### Clean tasks from `weekly-progress` book
Whenever you want you can clean `weekly-progress` book by using `clean` option or its alias `c`:
```bash
weekly-progress clean
```

## Collaborate
Everybody is wellcome to participate in the development of future features. You can participate by developing code yourselves, or raising an issue, comments or future improvements. You can write them in the [Issues](https://github.com/Noitty/dnote-cli-utils/issues) section of this repository. Thank you :)!
