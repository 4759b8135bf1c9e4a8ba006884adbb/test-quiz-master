# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Question.create(question: "What is the capital of Japan?", answer: "Tokyo")
Question.create(question: "What is 70 ÷ 10 ?", answer: "7")
Question.create(question: "What is the closest planet to the Sun?", answer: "Mercury")

question = <<-'EOS'.strip_heredoc
# What is the pre-conversion format of this question?

# h1
## h2
### h3
#### h4
##### h5
###### h6

# ul

- [li] 1
    - [li] 1-1
        - [li] 1-1-1
        - [li] 1-1-2
    - [li] 1-2
- [li] 2

# ol

1. [ol] 1
    1. [ol] 1-1
        1. [ol] 1-1-1
        1. [ol] 1-1-2
    1. [ol] 1-2
1. [ol] 2

# blockquote

> foo
>> bar

# code

`foo`

# em

*foo*
_foo_

# strong

**foo**
__foo__

# em + strong

***foo***
___foo___

# hr

***

---

* * *

# a

[example.com](http://example.com)
EOS

Question.create(question: question, answer: "Markdown")
