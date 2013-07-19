Change
======

Change is a tool for managing your Git workflow. Change expects three types of
branches in your repositories:

 1. **change** branches where changes get committed;
 1. **collection** branches where changes get merged together for testing; and,
 1. a **master** branch with the latest, stable code.

The branches of a repository maintained with Change might look like this:

```
bug/new-page-error                # change
change/footer-resize              # change
experimental/advanced-navigation  # change
feature/style-improvements        # change
hotfix/login-redirect             # change
master                            # master
staging                           # collection
v1.0.0                            # collection
```

There are two important rules that are the onus of the user to adhere to:

- A change branches MUST NOT be deleted until they have been merged into the
  master branch (unless they have been abandoned).
- Commits MUST NOT be made directly to a collection branch (except to resolve
  merge conflicts).

Installing
----------

Install with [Homebrew](http://mxcl.github.com/homebrew/) via the
`ketchup/brewhouse` tap:

```
brew tap ketchup/brewhouse
brew install change
```

If you've got Homebrew's `bash-completions` or `zsh-completions` installed
you'll get tab completion out-of-the-box.

Reference
---------

### Overview

```text
change checkout <change> [--skip-fetch]
change delete [<change>] [-f] [--skip-fetch] [--return-branch <branch>]
change ds [-f] [--skip-fetch] [--return-branch <branch>]
change list
change publish [<change>] [--skip-fetch] [--return-branch <branch>]
change stage [<change>] [--skip-fetch] [--return-branch <branch>]
change start <change> [--skip-fetch]
change update [<change>] [--skip-fetch] [--return-branch <branch>]
change version
```

### Details

- [Checkout](#checkout)
- [Delete](#delete)
- [Delete Staging](#delete-staging)
- [List](#list)
- [Publish](#publish)
- [Stage](#stage)
- [Start](#start)
- [Update](#update)
- [Version](#version)

#### Checkout

```text
change checkout <change> [--skip-fetch]
```

The `checkout` command will checkout a local branch for the given change (creating it's local
branch if it doesn't already exist).

#### Delete

```text
change delete [<change>] [-f] [--skip-fetch] [--return-branch <branch>]
```

The `delete` command deletes a change branch locally and on the remote. The `-f` option can be used
to force the delete if the change hasn't been merged into the master branch.

If you're abandoning a change using `change delete -f` and that change has previously been added to
the staging branch, you would normally want run `change ds -f`. This is because the staging branch
would be polluted with this now abandoned change.

#### Delete Staging

```text
change ds [-f] [--skip-fetch] [--return-branch <branch>]
```

The `ds` command will delete the current staging branch locally and on the remote. If the staging
branch is not fully merged with the master branch (which is normally the case) you must use the
`-f` option to confirm you want to delete the staging branch.

This command is useful if a change needs to be removed from staging.

#### List

```text
change list
```

The `list` command will print all the changes available both locally and remotely.

#### Publish

```text
change publish [<change>] [--skip-fetch] [--return-branch <branch>]
```

The `publish` command pushes a change branch to the remote (creating it if it doesn't already
exist).

#### Stage

```text
change stage [<change>] [--skip-fetch] [--return-branch <branch>]
```

The `stage` command merges a change into the staging branch before pushing it to the remote. If the
change hasn't been pushed to the remote, it is added in the process. If the staging branch doesn't
yet exist it is created in the process.

#### Start

```text
change start <change> [--skip-fetch]
```

The `start` creates a new change branch off master.

#### Update

```text
change update [<change>] [--skip-fetch] [--return-branch <branch>]
```

The `update` command merges the latest changes from the master branch into the change branch.

#### Version

```text
change version
```

The `version` command prints the version number.

License
-------

Copyright (c) 2012-2013 Katalyst Interactive, Haydn Ewers.

This project is released under the MIT License, see LICENSE for details.

Acknowledgments
---------------

Built with [sub](http://github.com/37signals/sub) - Copyright (c) 2012 Sam Stephenson, Nick
Quaranto, 37signals.

