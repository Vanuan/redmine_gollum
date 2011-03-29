Redmine Gollum
==============

Gollum is a wiki system that powers GitHub Wikis (https://github.com/github/gollum).

Gollum Wiki plugin is a plugin that puts that power into Redmine.

You need to go to gollum settings and set a git path for your wiki. A directory on that will be created when you go to a plugin tab.

Be caution:

- The code is pretty alpha quality now, backward-incompatible changes are likely to be introduced in the future.
- It only support markdown (at the moment)
- It requires your redmine process (passenger / mongrel... whatever) to be able to write your git repositories
- Depending on your git server setup, you still need to configure the access control for the newly create wiki repositories
- IT DOES NOT IMPORT YOUR CURRENT WIKI CONTENT


