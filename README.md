# Testing
#FAUTH_TOKEN="ya29.a0AfH6SMC6nPz3w0bx8LlE_4p8OqXQZ3mN7EfnZIH61BoBDVgb-0Z9lMl2BzG_oMOM5Xf1Qs0AbqnnV3ealhAqkQyGG8"
-----------------------------------------------------------------------------------------------------------------

Refer - branch "test" for the config for pre-commit and if required you can clone it, install the hook and validate how the hook works.

Refer - branch "autoinstall" - this branch has auto-install script already placed inside the .git/hooks repo. You can clone this repo and you don't even have to install it, you can directly start using the pre-commit hook.
##################################################################


Steps to have a Talisman pre-commit in your repo:
----------------------------------------------------
Before installing pre-commit, below are the pre-requisites for both Mac and Windows:
1. Python 3.8+
2. pip (Python’s package installer)
3. Github


MacOS
------
Step 1: Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Step 2: Install Python (includes pip)
brew install python

After install:
python3 --version
pip3 --version

Step 3: Install Git (if not installed)
brew install git

Step 4: Install pre-commit
pip3 install pre-commit

Step 5: Verify installation
pre-commit --version

You should see something like:
pre-commit 3.6.0


Windows
--------
Step 1: Install Python from official site
* Go to: https://www.python.org/downloads/
* Download and install the latest version.
* ✅ Make sure to check the box that says "Add Python to PATH" during installation.

Step 2: Verify Python and pip installation
python --version
pip --version

Step 4: Install pre-commit
pip install pre-commit

Step 5: Verify installation
pre-commit --version



How to Use pre-commit
-----------------------
1. Go to your Git project directory:
cd /path/to/your/project

2. Create a .pre-commit-config.yaml file (sample below):
repos:
  -   repo: https://github.com/thoughtworks/talisman
      rev: 'v1.32.2' 
      hooks:
        - id: talisman-commit

3. Once you create file from 2nd step, Install the hooks:
	pre-commit install


Auto-install setup:(do this if you want the hooks to be auto-installed, if not you can already use the hooks after the above step)
---------------------------------------------
To have this pre-commit outo installed in every repo, we will need to have the below

Step - 1:
Have a .pre-commit-config.yaml in every repo of our org.

Step - 2:
If the step-1 is achieved then we need to update its .git-templates directory with the below:
1. Create (or update) your Git template hooks directory
mkdir -p ~/.git-templates/hooks

2. Create the post-checkout hook file
cat > ~/.git-templates/hooks/post-checkout <<'EOF'
#!/bin/sh
# Automatically install pre-commit hooks if .pre-commit-config.yaml exists
if [ -f .pre-commit-config.yaml ]; then
  command -v pre-commit >/dev/null 2>&1 || {
    echo "pre-commit not found! Please install pre-commit first." >&2
    exit 1
  }
  pre-commit install || exit 1
fi
EOF

3. Create the post-merge hook file (for merges and pulls)
cat > ~/.git-templates/hooks/post-merge <<'EOF'
#!/bin/sh
# Automatically install pre-commit hooks if .pre-commit-config.yaml exists
if [ -f .pre-commit-config.yaml ]; then
  command -v pre-commit >/dev/null 2>&1 || {
    echo "pre-commit not found! Please install pre-commit first." >&2
    exit 1
  }
  pre-commit install || exit 1
fi
EOF

4. Make the hooks executable
chmod +x ~/.git-templates/hooks/post-checkout
chmod +x ~/.git-templates/hooks/post-merge

5. Configure Git to use this template directory (run once)
git config --global init.templateDir ~/.git-templates



Inputs required on below - if pre-commit hooks are going to be implemented then will require inputs on the below points.
----------------------------
- Any developer can user —no-verify flag and bypass the checks and push the code to remote repo.
- Also, using this tool whenever a secret is detected it generates a checksum value - https://share.anysnap.app/fV873Yr74aPy
- This value when placed in a file called .talismanrc file inside the repo, it ignores the whole file with that checksum value.
- Has to update .git/hooks template for all the repos and also need to create .pre-commit-config.yaml file in each and every repo.
- It only works for the diff lines (new insertions/deletions only).
- We can auto-install this pre-commit feature by updating .git/hooks template in all repositories but there is a chance that this template can be modified.
- Anybody can delete the config files and bypass them.
                               



