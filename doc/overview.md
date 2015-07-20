TODO: Enter the cookbook description here.

## Getting Started
If you plan to fork the main cookbook repo please see [forking](#forking) below.

1. Clone this cookbook.
1. Make changes as necessary (be sure to write tests as you go)
1. See [Testing](#testing) below for details on how to run the various tests locally.
1. Commit and push
1. Submit a pull request for review.

## Generating Documentation
DO NOT EDIT THIS README.md file directly. This file is generated using knife-cookbook-doc plugin.
Install this plugin with `gem install knife-cookbook-doc`.
Documentation is compiled from the following sources:

1. Derived for attributes/recipes either by scanning the source code or by explicit declaration 
in metadata.rb 
1. Markdown files in the doc/ directory (overview is always the first to be compiled)

To edit this README:

1. Change relevant sections within the markdown files in the doc/ directory
1. Edit metadata.rb or use inline annotated comments within the source code. 
1. Generate new README using knife-cookbook-doc plugin and push changes to remote branch.

# Usage

TODO: Enter usage details here

# Testing

## Code Style
To run style tests (Rubocop and Foodcritic):
`rake style`

If you want to run either Rubocop or Foodcritic separately, specify the style
test type (Rubocop = ruby, Foodcritic = chef)
`rake style:chef`
or
`rake style:ruby`

## RSpec tests
Run RSpec unit tests
`rake spec`

## Test Kitchen
Run Test Kitchen tests (these tests take quite a bit of time)
`rake integration:vagrant`

If the cookbook has tests that run in EC2
`rake integration:cloud`

# Forking

If you choose to fork this cookbook here are some good tips to keep things in
order

1. Fork the cookbook *before* cloning.
1. Clone the *forked* repo, not the original.
1. Once the fork is cloned, go to the repo directory and add an `upstream`
remote
`git remote add upstream git@gitlab.example.com:cookbooks/this_cookbook.git`

Now you can pull `upstream` changes (things merged into the main cookbook repo).
Note that you will also need to push to your fork's master to keep it updated.
The alias below will help you. After adding the alias you will simply be able to
run `git-reup` and it will pull the upstream changes and push them to
your fork. Then checkout a branch and work as normal.

Add the following alias in `~/.bash_profile`.
`alias git-reup='git checkout master && git pull upstream master && git push origin master'`
