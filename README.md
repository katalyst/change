Change
======

Change is a tool for managing your git workflow. It has been designed work with GitHub's pull request system allowing changes to be staged and reviewed before being merged into the main codebase.

Change enforces a git branch structure like so:

```bash
change/abc # work in progress
change/zyx # more work in progress
master # 100% tested and ready to go live
staging # testing for work in progress
```

Change expects you to abide by these rules:

- _NEVER_ commit to the **master** branch.
- _NEVER_ commit to the **staging** branch _EXCEPT_ to resolve merge conflicts.
- _NEVER_ merge the the **staging** branch into another branch.
- Every change _MUST_ be done on a **change/*** branch.
- Every change _MUST_ be merged into the **master** branch via a GitHub pull request.
- Every change _MUST_ be staged & reviewed before being merged into the **master** branch.

Installing
----------

Install with [Homebrew](http://mxcl.github.com/homebrew/) via the `ketchup/brewhouse` tap:

```
brew tap ketchup/brewhouse
brew install change
```

Workflow
--------

1.  Start a change (called "fix-typos" in this example).

    ```bash
    $ change start fix-typos
    ```

2.  Do some work and commit it to the change branch.

    ```bash
    $ touch example
    $ git add example
    $ git commit -m "example commit"
    ```

3.  Add the change to the staging branch & deploy it to the staging server.

    ```bash
    $ change stage fix-typos
    # deploy the staging branch to the staging server
    ```

4.  Open a pull request and repeat steps 2 & 3 until the pull request has been approved.

    ```bash
    # open a pull request on github.com
    ```

5.  Merge the pull request into master, delete the change & deploy to production.

    ```bash
    # merge the pull request on github.com
    $ change delete fix-typos
    # deploy the master branch to the production server
    ```

Reference
---------

### Common Commands

- [Start](#start)
- [Stage](#stage)
- [Update](#update)
- [Delete](#delete)


#### Start

```text
change start <name>
```

The `start` command pulls thew latest version of the master branch and creates a new change branch off that.

#### Stage

```text
change stage [<name>]
```

The `stage` command merges a change into the master branch before pushing it to the remote. If the staging branch doesn't yet exist it is created in the process.

#### Update

```text
change update [<name>]
```

The `update` command merges the latest changes from the master branch into the change branch.

#### Delete

```text
change delete [<name>] [-f]
```

The `delete` command deletes a change branch locally and on the remote. The `-f` option can be used to force the delete if the change hasn't been merged into the master branch (`git branch -D change/<name>`).

After using `change delete <name> -f` on a change that has previously been staged, you would normally want run `change ds -f` as the staging branch would be polluted with this abandoned change.


### Additional Commands

- [Publish](#publish)
- [Delete Staging](#delete-staging)

#### Publish

```text
change publish [<name>]
```

The `publish` command pushes a change branch to the remote (creating it if it doesn't already exist).

#### Delete Staging

```text
change ds [-f]
```

The `ds` command will delete the current staging branch locally and on the remote. If the staging branch has not been merged into the master branch (which is normally the case) you must use the `-f` option to confirm you want to delete the staging branch.

This command is useful if a change needs to be removed from staging.

License
-------

Copyright (c) 2012 Katalyst Interactive.

See the LICENSE file for details.

Acknowledgments
---------------

Built with [sub](http://github.com/37signals/sub) - Copyright (c) 2012 Sam Stephenson, Nick Quaranto, 37signals.
