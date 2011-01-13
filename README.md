tonto
=====

> stupid key-value document store ( that uses git as DB )

description
-----------

**tonto** ( which can be translated from Italian to *git* ) is a _simple_, _high-level_ and a bit _stupid_ document-oriented store that allows you to use git repos as schema-less NoSQL databases.

installation
------------

The best way to install **tonto** is with RubyGems:

    $ [sudo] gem install tonto


synopsis
--------

    require 'tonto'
    db = Tonto::Repo.new("/my/git/db")

    db.put {
      :id      => 26,
      :name    => "My first post",
      :content => "This is COOOL",
      :date    => "Time.now"
    }

    db.get(26)["name"]

> My First post

    db.put :id => 26, :name => "I'm tonto"
> true

    db.get(26)["name"]

> "I'm tonto"

    db.remove(26)

> true

    db.get(26)

> false

misc
----

* status: "alpha status"

* license: AGPLv3

inspired by [technoweenie](http://git-nosql-rar.heroku.com/), [nimbus](https://github.com/cloudhead/nimbus) and [gitmodel](https://github.com/pauldowman/gitmodel/)
